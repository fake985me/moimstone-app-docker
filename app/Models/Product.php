<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    use HasFactory;

    /**
     * Boot the model and add event listeners for auto stock sync
     */
    protected static function boot()
    {
        parent::boot();

        // Auto-sync CurrentStock when Product is created
        static::created(function ($product) {
            \App\Models\CurrentStock::firstOrCreate(
                ['product_id' => $product->id],
                ['quantity' => $product->stock ?? 0, 'last_updated' => now()]
            );
        });

        // Auto-sync CurrentStock when Product stock is updated
        static::updated(function ($product) {
            if ($product->isDirty('stock')) {
                $currentStock = \App\Models\CurrentStock::firstOrCreate(
                    ['product_id' => $product->id],
                    ['quantity' => 0, 'last_updated' => now()]
                );
                $currentStock->quantity = $product->stock ?? 0;
                $currentStock->last_updated = now();
                $currentStock->save();
            }
        });

        // Auto-delete CurrentStock when Product is deleted
        static::deleted(function ($product) {
            \App\Models\CurrentStock::where('product_id', $product->id)->delete();
        });
    }

    protected $fillable = [
        'sku',
        'image',
        'category',
        'sub_category',
        'brand',
        'title',
        'descriptions',
        'stock',
        'minimum_stock',
    ];

    protected $casts = [
        'stock' => 'integer',
        'minimum_stock' => 'integer',
    ];

    /**
     * Stock management scopes
     */
    public function scopeLowStock($query)
    {
        return $query->whereColumn('stock', '<=', 'minimum_stock');
    }

    public function scopeInStock($query)
    {
        return $query->where('stock', '>', 0);
    }

    public function scopeOutOfStock($query)
    {
        return $query->where('stock', '<=', 0);
    }
}

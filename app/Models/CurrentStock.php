<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CurrentStock extends Model
{
    use HasFactory;

    protected $fillable = [
        'product_id',
        'quantity',
        'last_updated'
    ];

    protected $casts = [
        'quantity' => 'integer',
        'last_updated' => 'datetime',
    ];

    /**
     * Get the product
     */
    public function product()
    {
        return $this->belongsTo(Product::class);
    }
}

<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'description',
    ];

    /**
     * Get products that match this category name
     * Note: Products use VARCHAR category field, not foreign key
     */
    public function getProductsCountAttribute()
    {
        return \DB::table('products')
            ->where('category', $this->name)
            ->count();
    }
}

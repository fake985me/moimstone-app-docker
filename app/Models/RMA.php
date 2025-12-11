<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class RMA extends Model
{
    use HasFactory;

    protected $table = 'rmas';

    protected $fillable = [
        'rma_code',
        'warranty_id',
        'product_id',
        'customer_name',
        'customer_contact',
        'quantity',
        'reason',
        'status',
        'issue_date',
        'received_date',
        'condition',
        'resolution',
        'notes',
        'user_id'
    ];

    protected $casts = [
        'quantity' => 'integer',
        'issue_date' => 'date',
        'received_date' => 'date',
    ];

    /**
     * Get the warranty (optional)
     */
    public function warranty()
    {
        return $this->belongsTo(Warranty::class);
    }

    /**
     * Get the product
     */
    public function product()
    {
        return $this->belongsTo(Product::class);
    }

    /**
     * Get the user who created the RMA
     */
    public function user()
    {
        return $this->belongsTo(User::class);
    }
}

<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Sale extends Model
{
    use HasFactory;

    protected $fillable = [
        'invoice_number',
        'customer_name',
        'customer_email',
        'customer_phone',
        'customer_address',
        'total_amount',
        'status',
        'sales_person_id',
        'user_id',
        'sale_date',
        'notes'
    ];

    protected $casts = [
        'total_amount' => 'decimal:2',
        'sale_date' => 'date',
    ];

    /**
     * Get the user who created the sale
     */
    public function user()
    {
        return $this->belongsTo(User::class);
    }

    /**
     * Get the sales person
     */
    public function salesPerson()
    {
        return $this->belongsTo(SalesPerson::class, 'sales_person_id');
    }

    /**
     * Get sale items
     */
    public function items()
    {
        return $this->hasMany(SaleItem::class);
    }

    /**
     * Get warranties
     */
    public function warranties()
    {
        return $this->hasMany(Warranty::class);
    }

    /**
     * Get stock transactions
     */
    public function stockTransactions()
    {
        return $this->hasMany(StockTransaction::class, 'reference_id')
            ->where('reference_type', 'sale');
    }

    /**
     * Get the delivery for this sale
     */
    public function delivery()
    {
        return $this->hasOne(Delivery::class);
    }
}

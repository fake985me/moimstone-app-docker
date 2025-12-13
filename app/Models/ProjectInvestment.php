<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProjectInvestment extends Model
{
    use HasFactory;

    protected $fillable = [
        'project_code',
        'project_name',
        'client_name',
        'client_contact',
        'description',
        'start_date',
        'expected_end_date',
        'actual_end_date',
        'status',
        'total_value',
        'user_id',
        'approved_by',
        'approved_at',
    ];

    protected $casts = [
        'start_date' => 'date',
        'expected_end_date' => 'date',
        'actual_end_date' => 'date',
        'approved_at' => 'datetime',
        'total_value' => 'decimal:2',
    ];

    public function items()
    {
        return $this->hasMany(ProjectInvestmentItem::class);
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function approver()
    {
        return $this->belongsTo(User::class, 'approved_by');
    }

    public function calculateTotalValue()
    {
        $this->total_value = $this->items()->sum('total_price');
        $this->save();
    }
}

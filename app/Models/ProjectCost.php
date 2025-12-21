<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProjectCost extends Model
{
    use HasFactory;

    protected $fillable = [
        'project_plan_id',
        'category',
        'description',
        'estimated_amount',
        'actual_amount',
        'date',
        'notes',
    ];

    protected $casts = [
        'estimated_amount' => 'decimal:2',
        'actual_amount' => 'decimal:2',
        'date' => 'date',
    ];

    protected $appends = ['variance', 'variance_percentage'];

    public const CATEGORIES = [
        'labor' => 'Tenaga Kerja',
        'overhead' => 'Overhead',
        'equipment' => 'Peralatan',
        'transport' => 'Transportasi',
        'other' => 'Lainnya',
    ];

    public function projectPlan()
    {
        return $this->belongsTo(ProjectPlan::class);
    }

    public function getVarianceAttribute()
    {
        return $this->estimated_amount - $this->actual_amount;
    }

    public function getVariancePercentageAttribute()
    {
        if ($this->estimated_amount <= 0) return 0;
        return round((($this->estimated_amount - $this->actual_amount) / $this->estimated_amount) * 100, 2);
    }

    public function getCategoryLabelAttribute()
    {
        return self::CATEGORIES[$this->category] ?? $this->category;
    }
}

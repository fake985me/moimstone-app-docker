<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ProjectMaterial extends Model
{
    use HasFactory;

    protected $fillable = [
        'project_plan_id',
        'product_id',
        'material_name',
        'quantity_planned',
        'quantity_used',
        'unit_price',
        'total_cost',
        'notes',
    ];

    protected $casts = [
        'quantity_planned' => 'integer',
        'quantity_used' => 'integer',
        'unit_price' => 'decimal:2',
        'total_cost' => 'decimal:2',
    ];

    protected $appends = ['usage_percentage', 'remaining_quantity', 'estimated_cost'];

    public function projectPlan()
    {
        return $this->belongsTo(ProjectPlan::class);
    }

    public function product()
    {
        return $this->belongsTo(Product::class);
    }

    public function getUsagePercentageAttribute()
    {
        if ($this->quantity_planned <= 0) return 0;
        return round(($this->quantity_used / $this->quantity_planned) * 100, 2);
    }

    public function getRemainingQuantityAttribute()
    {
        return max(0, $this->quantity_planned - $this->quantity_used);
    }

    public function getEstimatedCostAttribute()
    {
        return $this->quantity_planned * $this->unit_price;
    }

    public function updateUsage($quantity)
    {
        $this->quantity_used = $quantity;
        $this->total_cost = $quantity * $this->unit_price;
        $this->save();
        
        // Recalculate project costs
        $this->projectPlan->recalculateCosts();
    }

    // Get material name (product title or custom name)
    public function getMaterialDisplayName()
    {
        return $this->product ? $this->product->title : $this->material_name;
    }
}

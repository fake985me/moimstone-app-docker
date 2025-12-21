<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

class ProjectPlan extends Model
{
    use HasFactory;

    protected $fillable = [
        'project_code',
        'title',
        'description',
        'client_name',
        'client_contact',
        'start_date',
        'end_date',
        'estimated_duration_days',
        'actual_duration_days',
        'status',
        'total_estimated_cost',
        'total_actual_cost',
        'progress_percentage',
        'user_id',
        'notes',
    ];

    protected $casts = [
        'start_date' => 'date',
        'end_date' => 'date',
        'total_estimated_cost' => 'decimal:2',
        'total_actual_cost' => 'decimal:2',
        'progress_percentage' => 'decimal:2',
    ];

    protected $appends = ['remaining_days', 'budget_variance', 'is_on_schedule', 'is_on_budget'];

    // Relationships
    public function milestones()
    {
        return $this->hasMany(ProjectMilestone::class)->orderBy('order');
    }

    public function materials()
    {
        return $this->hasMany(ProjectMaterial::class);
    }

    public function costs()
    {
        return $this->hasMany(ProjectCost::class);
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    // Calculated Attributes
    public function getRemainingDaysAttribute()
    {
        if (!$this->end_date) return null;
        return max(0, Carbon::now()->diffInDays($this->end_date, false));
    }

    public function getBudgetVarianceAttribute()
    {
        return $this->total_estimated_cost - $this->total_actual_cost;
    }

    public function getIsOnScheduleAttribute()
    {
        if (!$this->end_date) return true;
        return Carbon::now()->lte($this->end_date);
    }

    public function getIsOnBudgetAttribute()
    {
        return $this->total_actual_cost <= $this->total_estimated_cost;
    }

    // Methods
    public function calculateProgress()
    {
        $milestones = $this->milestones;
        if ($milestones->isEmpty()) return 0;

        $completed = $milestones->where('status', 'completed')->count();
        return round(($completed / $milestones->count()) * 100, 2);
    }

    public function calculateTotalEstimatedCost()
    {
        $materialCost = $this->materials()->sum(\DB::raw('quantity_planned * unit_price'));
        $otherCost = $this->costs()->sum('estimated_amount');
        return $materialCost + $otherCost;
    }

    public function calculateTotalActualCost()
    {
        $materialCost = $this->materials()->sum('total_cost');
        $otherCost = $this->costs()->sum('actual_amount');
        return $materialCost + $otherCost;
    }

    public function recalculateCosts()
    {
        $this->total_estimated_cost = $this->calculateTotalEstimatedCost();
        $this->total_actual_cost = $this->calculateTotalActualCost();
        $this->progress_percentage = $this->calculateProgress();
        $this->save();
    }

    public function getTimelineStatus()
    {
        if ($this->status === 'completed') return 'completed';
        if ($this->status === 'cancelled') return 'cancelled';
        if (!$this->end_date) return 'no_deadline';
        
        $daysRemaining = $this->remaining_days;
        if ($daysRemaining < 0) return 'overdue';
        if ($daysRemaining <= 7) return 'critical';
        if ($daysRemaining <= 14) return 'warning';
        return 'on_track';
    }

    // Generate project code
    public static function generateProjectCode()
    {
        $prefix = 'PRJ';
        $year = date('Y');
        $month = date('m');
        
        $lastProject = self::whereYear('created_at', $year)
            ->whereMonth('created_at', $month)
            ->orderBy('id', 'desc')
            ->first();
        
        $sequence = $lastProject ? intval(substr($lastProject->project_code, -4)) + 1 : 1;
        
        return sprintf('%s-%s%s-%04d', $prefix, $year, $month, $sequence);
    }
}

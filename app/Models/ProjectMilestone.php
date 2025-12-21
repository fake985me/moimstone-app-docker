<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

class ProjectMilestone extends Model
{
    use HasFactory;

    protected $fillable = [
        'project_plan_id',
        'name',
        'description',
        'target_date',
        'completed_date',
        'status',
        'cost_allocation',
        'order',
    ];

    protected $casts = [
        'target_date' => 'date',
        'completed_date' => 'date',
        'cost_allocation' => 'decimal:2',
    ];

    protected $appends = ['is_overdue', 'days_remaining'];

    public function projectPlan()
    {
        return $this->belongsTo(ProjectPlan::class);
    }

    public function getIsOverdueAttribute()
    {
        if ($this->status === 'completed') return false;
        return Carbon::now()->gt($this->target_date);
    }

    public function getDaysRemainingAttribute()
    {
        if ($this->status === 'completed') return 0;
        return Carbon::now()->diffInDays($this->target_date, false);
    }

    public function markComplete()
    {
        $this->status = 'completed';
        $this->completed_date = Carbon::now();
        $this->save();
        
        // Recalculate project progress
        $this->projectPlan->recalculateCosts();
    }
}

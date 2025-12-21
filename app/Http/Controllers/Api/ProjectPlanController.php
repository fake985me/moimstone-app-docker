<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\ProjectPlan;
use App\Models\ProjectMilestone;
use App\Models\ProjectMaterial;
use App\Models\ProjectCost;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ProjectPlanController extends Controller
{
    public function index(Request $request)
    {
        $query = ProjectPlan::with(['milestones', 'user'])
            ->withCount(['milestones', 'materials', 'costs']);

        if ($request->search) {
            $search = $request->search;
            $query->where(function ($q) use ($search) {
                $q->where('title', 'like', "%{$search}%")
                    ->orWhere('project_code', 'like', "%{$search}%")
                    ->orWhere('client_name', 'like', "%{$search}%");
            });
        }

        if ($request->status) {
            $query->where('status', $request->status);
        }

        $projects = $query->orderBy('created_at', 'desc')
            ->paginate($request->per_page ?? 15);

        return response()->json($projects);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'title' => 'required|string|max:255',
            'description' => 'nullable|string',
            'client_name' => 'nullable|string|max:255',
            'client_contact' => 'nullable|string|max:255',
            'start_date' => 'required|date',
            'end_date' => 'nullable|date|after_or_equal:start_date',
            'notes' => 'nullable|string',
            'milestones' => 'nullable|array',
            'milestones.*.name' => 'required|string',
            'milestones.*.target_date' => 'required|date',
            'milestones.*.cost_allocation' => 'nullable|numeric',
            'materials' => 'nullable|array',
            'materials.*.product_id' => 'nullable|exists:products,id',
            'materials.*.material_name' => 'nullable|string',
            'materials.*.quantity_planned' => 'required|integer|min:1',
            'materials.*.unit_price' => 'required|numeric|min:0',
            'costs' => 'nullable|array',
            'costs.*.category' => 'required|in:labor,overhead,equipment,transport,other',
            'costs.*.description' => 'required|string',
            'costs.*.estimated_amount' => 'required|numeric|min:0',
        ]);

        return DB::transaction(function () use ($validated, $request) {
            // Calculate duration
            $startDate = \Carbon\Carbon::parse($validated['start_date']);
            $endDate = $validated['end_date'] ? \Carbon\Carbon::parse($validated['end_date']) : null;
            $duration = $endDate ? $startDate->diffInDays($endDate) : 0;

            $project = ProjectPlan::create([
                'project_code' => ProjectPlan::generateProjectCode(),
                'title' => $validated['title'],
                'description' => $validated['description'] ?? null,
                'client_name' => $validated['client_name'] ?? null,
                'client_contact' => $validated['client_contact'] ?? null,
                'start_date' => $validated['start_date'],
                'end_date' => $validated['end_date'] ?? null,
                'estimated_duration_days' => $duration,
                'status' => 'draft',
                'user_id' => auth()->id(),
                'notes' => $validated['notes'] ?? null,
            ]);

            // Create milestones
            if (!empty($validated['milestones'])) {
                foreach ($validated['milestones'] as $index => $milestone) {
                    $project->milestones()->create([
                        'name' => $milestone['name'],
                        'description' => $milestone['description'] ?? null,
                        'target_date' => $milestone['target_date'],
                        'cost_allocation' => $milestone['cost_allocation'] ?? 0,
                        'order' => $index,
                    ]);
                }
            }

            // Create materials
            if (!empty($validated['materials'])) {
                foreach ($validated['materials'] as $material) {
                    $project->materials()->create([
                        'product_id' => $material['product_id'] ?? null,
                        'material_name' => $material['material_name'] ?? null,
                        'quantity_planned' => $material['quantity_planned'],
                        'unit_price' => $material['unit_price'],
                    ]);
                }
            }

            // Create costs
            if (!empty($validated['costs'])) {
                foreach ($validated['costs'] as $cost) {
                    $project->costs()->create([
                        'category' => $cost['category'],
                        'description' => $cost['description'],
                        'estimated_amount' => $cost['estimated_amount'],
                    ]);
                }
            }

            // Calculate totals
            $project->recalculateCosts();

            return response()->json($project->load(['milestones', 'materials.product', 'costs']), 201);
        });
    }

    public function show(ProjectPlan $projectPlan)
    {
        $projectPlan->load(['milestones', 'materials.product', 'costs', 'user']);
        return response()->json($projectPlan);
    }

    public function update(Request $request, ProjectPlan $projectPlan)
    {
        $validated = $request->validate([
            'title' => 'sometimes|required|string|max:255',
            'description' => 'nullable|string',
            'client_name' => 'nullable|string|max:255',
            'client_contact' => 'nullable|string|max:255',
            'start_date' => 'sometimes|required|date',
            'end_date' => 'nullable|date|after_or_equal:start_date',
            'status' => 'sometimes|in:draft,planning,in_progress,on_hold,completed,cancelled',
            'notes' => 'nullable|string',
        ]);

        // Recalculate duration if dates changed
        if (isset($validated['start_date']) || isset($validated['end_date'])) {
            $startDate = \Carbon\Carbon::parse($validated['start_date'] ?? $projectPlan->start_date);
            $endDate = isset($validated['end_date']) ? \Carbon\Carbon::parse($validated['end_date']) : $projectPlan->end_date;
            if ($endDate) {
                $validated['estimated_duration_days'] = $startDate->diffInDays($endDate);
            }
        }

        $projectPlan->update($validated);
        $projectPlan->recalculateCosts();

        return response()->json($projectPlan->load(['milestones', 'materials.product', 'costs']));
    }

    public function destroy(ProjectPlan $projectPlan)
    {
        $projectPlan->delete();
        return response()->json(['message' => 'Project deleted successfully']);
    }

    // Milestone operations
    public function addMilestone(Request $request, ProjectPlan $projectPlan)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'description' => 'nullable|string',
            'target_date' => 'required|date',
            'cost_allocation' => 'nullable|numeric|min:0',
        ]);

        $maxOrder = $projectPlan->milestones()->max('order') ?? -1;
        $validated['order'] = $maxOrder + 1;

        $milestone = $projectPlan->milestones()->create($validated);
        
        return response()->json($milestone, 201);
    }

    public function updateMilestone(Request $request, ProjectPlan $projectPlan, ProjectMilestone $milestone)
    {
        $validated = $request->validate([
            'name' => 'sometimes|required|string|max:255',
            'description' => 'nullable|string',
            'target_date' => 'sometimes|required|date',
            'status' => 'sometimes|in:pending,in_progress,completed,overdue',
            'cost_allocation' => 'nullable|numeric|min:0',
        ]);

        if (isset($validated['status']) && $validated['status'] === 'completed') {
            $validated['completed_date'] = now();
        }

        $milestone->update($validated);
        $projectPlan->recalculateCosts();

        return response()->json($milestone);
    }

    public function deleteMilestone(ProjectPlan $projectPlan, ProjectMilestone $milestone)
    {
        $milestone->delete();
        $projectPlan->recalculateCosts();
        return response()->json(['message' => 'Milestone deleted']);
    }

    // Material operations
    public function addMaterial(Request $request, ProjectPlan $projectPlan)
    {
        $validated = $request->validate([
            'product_id' => 'nullable|exists:products,id',
            'material_name' => 'nullable|string|max:255',
            'quantity_planned' => 'required|integer|min:1',
            'unit_price' => 'required|numeric|min:0',
            'notes' => 'nullable|string',
        ]);

        $material = $projectPlan->materials()->create($validated);
        $projectPlan->recalculateCosts();

        return response()->json($material->load('product'), 201);
    }

    public function updateMaterial(Request $request, ProjectPlan $projectPlan, ProjectMaterial $material)
    {
        $validated = $request->validate([
            'quantity_planned' => 'sometimes|integer|min:0',
            'quantity_used' => 'sometimes|integer|min:0',
            'unit_price' => 'sometimes|numeric|min:0',
            'notes' => 'nullable|string',
        ]);

        if (isset($validated['quantity_used'])) {
            $validated['total_cost'] = $validated['quantity_used'] * ($validated['unit_price'] ?? $material->unit_price);
        }

        $material->update($validated);
        $projectPlan->recalculateCosts();

        return response()->json($material);
    }

    public function deleteMaterial(ProjectPlan $projectPlan, ProjectMaterial $material)
    {
        $material->delete();
        $projectPlan->recalculateCosts();
        return response()->json(['message' => 'Material deleted']);
    }

    // Cost operations
    public function addCost(Request $request, ProjectPlan $projectPlan)
    {
        $validated = $request->validate([
            'category' => 'required|in:labor,overhead,equipment,transport,other',
            'description' => 'required|string|max:255',
            'estimated_amount' => 'required|numeric|min:0',
            'actual_amount' => 'nullable|numeric|min:0',
            'date' => 'nullable|date',
            'notes' => 'nullable|string',
        ]);

        $cost = $projectPlan->costs()->create($validated);
        $projectPlan->recalculateCosts();

        return response()->json($cost, 201);
    }

    public function updateCost(Request $request, ProjectPlan $projectPlan, ProjectCost $cost)
    {
        $validated = $request->validate([
            'category' => 'sometimes|in:labor,overhead,equipment,transport,other',
            'description' => 'sometimes|string|max:255',
            'estimated_amount' => 'sometimes|numeric|min:0',
            'actual_amount' => 'sometimes|numeric|min:0',
            'date' => 'nullable|date',
            'notes' => 'nullable|string',
        ]);

        $cost->update($validated);
        $projectPlan->recalculateCosts();

        return response()->json($cost);
    }

    public function deleteCost(ProjectPlan $projectPlan, ProjectCost $cost)
    {
        $cost->delete();
        $projectPlan->recalculateCosts();
        return response()->json(['message' => 'Cost deleted']);
    }

    // Status changes
    public function start(ProjectPlan $projectPlan)
    {
        $projectPlan->update(['status' => 'in_progress']);
        return response()->json($projectPlan);
    }

    public function complete(ProjectPlan $projectPlan)
    {
        $projectPlan->update([
            'status' => 'completed',
            'actual_duration_days' => $projectPlan->start_date->diffInDays(now()),
        ]);
        return response()->json($projectPlan);
    }

    public function cancel(ProjectPlan $projectPlan)
    {
        $projectPlan->update(['status' => 'cancelled']);
        return response()->json($projectPlan);
    }

    // Dashboard / Summary
    public function summary()
    {
        $stats = [
            'total' => ProjectPlan::count(),
            'in_progress' => ProjectPlan::where('status', 'in_progress')->count(),
            'completed' => ProjectPlan::where('status', 'completed')->count(),
            'overdue' => ProjectPlan::where('status', '!=', 'completed')
                ->where('status', '!=', 'cancelled')
                ->where('end_date', '<', now())
                ->count(),
            'total_estimated_cost' => ProjectPlan::sum('total_estimated_cost'),
            'total_actual_cost' => ProjectPlan::sum('total_actual_cost'),
        ];

        return response()->json($stats);
    }
}

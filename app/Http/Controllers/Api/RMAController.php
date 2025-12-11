<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\RMA;
use App\Models\Warranty;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class RMAController extends Controller
{
    public function index(Request $request)
    {
        try {
            $query = RMA::with(['warranty', 'product', 'user']);

            // Filter by status
            if ($request->has('status') && !empty($request->status)) {
                $query->where('status', $request->status);
            }

            // Filter by reason
            if ($request->has('reason') && !empty($request->reason)) {
                $query->where('reason', $request->reason);
            }

            // Search
            if ($request->has('search') && !empty($request->search)) {
                $search = $request->search;
                $query->where(function($q) use ($search) {
                    $q->where('rma_code', 'like', "%{$search}%")
                      ->orWhere('customer_name', 'like', "%{$search}%");
                });
            }

            $rmas = $query->orderBy('created_at', 'desc')
                ->paginate($request->per_page ?? 15);

            return response()->json($rmas);
        } catch (\Exception $e) {
            \Log::error('RMAs API Error: ' . $e->getMessage());
            return response()->json([
                'message' => 'Error loading RMAs',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function store(Request $request)
    {
       $validated = $request->validate([
            'warranty_id' => 'nullable|exists:warranties,id',
            'product_id' => 'required|exists:products,id',
            'customer_name' => 'required|string|max:255',
            'customer_contact' => 'nullable|string',
            'quantity' => 'required|integer|min:1',
            'reason' => 'required|in:warranty_claim,damaged_shipment,defective,dead_on_arrival',
            'issue_date' => 'required|date',
            'notes' => 'nullable|string',
        ]);

        DB::beginTransaction();
        try {
            // Auto-generate RMA code
            $rmaCode = 'RMA-' . date('Ymd') . '-' . str_pad(RMA::whereDate('created_at', today())->count() + 1, 4, '0', STR_PAD_LEFT);

            $rma = RMA::create([
                ...$validated,
                'rma_code' => $rmaCode,
                'user_id' => auth()->id(),
                'status' => 'pending',
            ]);

            DB::commit();
            return response()->json($rma->load(['warranty', 'product', 'user']), 201);
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json(['message' => $e->getMessage()], 422);
        }
    }

    public function show($id)
    {
        $rma = RMA::with(['warranty', 'product', 'user'])->findOrFail($id);
        return response()->json($rma);
    }

    public function update(Request $request, $id)
    {
        $rma = RMA::findOrFail($id);

        $validated = $request->validate([
            'status' => 'sometimes|in:pending,approved,rejected,received,processed,completed',
            'resolution' => 'nullable|in:repair,replace,refund',
            'received_date' => 'nullable|date',
            'notes' => 'nullable|string',
        ]);

        $rma->update($validated);

        return response()->json($rma->load(['warranty', 'product', 'user']));
    }

    public function destroy($id)
    {
        $rma = RMA::findOrFail($id);
        $rma->delete();

        return response()->json(['message' => 'RMA deleted successfully']);
    }

    /**
     * Mark RMA as received
     */
    public function markReceived(Request $request, $id)
    {
        $rma = RMA::findOrFail($id);
        
        // Validate condition
        $validated = $request->validate([
            'condition' => 'required|string|max:255'
        ]);
        
        DB::beginTransaction();
        try {
            $stockService = new \App\Services\StockSyncService();
            
            // Check if condition is "working" - if yes, add back to stock
            // Otherwise, deduct from stock (damaged/broken/parts_only/custom)
            if (strtolower($validated['condition']) === 'working') {
                // Item is functional, add back to available stock
                $stockService->addStock(
                    $rma->product_id,
                    $rma->quantity,
                    'rma_return_working',
                    $rma->id,
                    "RMA Received: {$rma->rma_code} - Condition: Working (Returned to Stock)"
                );
            } else {
                // Item is damaged/broken/etc, deduct from available stock
                $stockService->deductStock(
                    $rma->product_id,
                    $rma->quantity,
                    'rma_return_defective',
                    $rma->id,
                    "RMA Received: {$rma->rma_code} - Condition: {$validated['condition']} (Removed from Stock)"
                );
            }
            
            // Update RMA status and condition
            $rma->update([
                'status' => 'received',
                'received_date' => now(),
                'condition' => $validated['condition']
            ]);

            DB::commit();
            return response()->json($rma->load(['warranty', 'product', 'user']));
        } catch (\Exception $e) {
            DB::rollBack();
            return response()->json(['message' => $e->getMessage()], 422);
        }
    }

    /**
     * Process RMA with resolution
     */
    public function process(Request $request, $id)
    {
        $rma = RMA::findOrFail($id);

        $validated = $request->validate([
            'resolution' => 'required|in:repair,replace,refund',
        ]);

        $rma->update([
            'status' => 'processed',
            'resolution' => $validated['resolution'],
        ]);

        // TODO: Handle resolution actions
        // - repair: track repair process
        // - replace: create new delivery
        // - refund: process refund

        return response()->json($rma->load(['warranty', 'product', 'user']));
    }
}

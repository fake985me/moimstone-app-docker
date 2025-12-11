<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\CurrentStock;
use App\Models\StockTransaction;
use App\Models\Product;
use Illuminate\Http\Request;

class StockController extends Controller
{
    public function index(Request $request)
    {
        try {
            $query = CurrentStock::with('product');

            // Filter by low stock (using default threshold since min_stock removed)
            if ($request->has('low_stock') && $request->low_stock == 'true') {
                $query->where('quantity', '<=', 10); // Default low stock threshold
            }

            // Search by product title
            if ($request->has('search') && !empty($request->search)) {
                $search = $request->search;
                $query->whereHas('product', function ($q) use ($search) {
                    $q->where('title', 'like', "%{$search}%")
                        ->orWhere('brand', 'like', "%{$search}%");
                });
            }

            $stocks = $query->paginate($request->per_page ?? 15);

            return response()->json($stocks);
        } catch (\Exception $e) {
            \Log::error('Stock API Error: ' . $e->getMessage());
            return response()->json([
                'message' => 'Error loading stock',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function transactions(Request $request)
    {
        try {
            $query = StockTransaction::with(['product', 'user'])
                ->orderBy('created_at', 'desc');

            // Filter by product
            if ($request->has('product_id') && !empty($request->product_id)) {
                $query->where('product_id', $request->product_id);
            }

            // Filter by type
            if ($request->has('type') && !empty($request->type)) {
                $query->where('transaction_type', $request->type);
            }

            // Date range
            if ($request->has('start_date') && !empty($request->start_date)) {
                $query->whereDate('created_at', '>=', $request->start_date);
            }
            if ($request->has('end_date') && !empty($request->end_date)) {
                $query->whereDate('created_at', '<=', $request->end_date);
            }

            $transactions = $query->paginate($request->per_page ?? 15);

            return response()->json($transactions);
        } catch (\Exception $e) {
            \Log::error('Stock Transactions API Error: ' . $e->getMessage());
            return response()->json([
                'message' => 'Error loading transactions',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'product_id' => 'required|exists:products,id',
            'transaction_type' => 'required|in:in,out',
            'quantity' => 'required|integer|min:1',
            'reference_type' => 'nullable|string',
            'reference_id' => 'nullable|integer',
            'notes' => 'nullable|string',
        ]);

        try {
            $stockService = new \App\Services\StockSyncService();
            
            // Use StockSyncService for proper stock management
            if ($validated['transaction_type'] === 'in') {
                $stockService->addStock(
                    $validated['product_id'],
                    $validated['quantity'],
                    $validated['reference_type'] ?? 'manual_adjustment',
                    $validated['reference_id'] ?? 0,
                    $validated['notes']
                );
            } else {
                $stockService->deductStock(
                    $validated['product_id'],
                    $validated['quantity'],
                    $validated['reference_type'] ?? 'manual_adjustment',
                    $validated['reference_id'] ?? 0,
                    $validated['notes']
                );
            }
            
            // Get the created transaction
            $transaction = StockTransaction::with(['product', 'user'])
                ->where('product_id', $validated['product_id'])
                ->latest()
                ->first();

            return response()->json($transaction, 201);
        } catch (\Exception $e) {
            return response()->json([
                'message' => $e->getMessage()
            ], 422);
        }
    }

    /**
     * Get RMA stock inventory grouped by product and condition
     */
    public function rmaStock()
    {
        try {
            $rmas = \App\Models\RMA::with('product')
                ->where('status', 'received')
                ->select('product_id', 'condition', \DB::raw('SUM(quantity) as total_quantity'))
                ->groupBy('product_id', 'condition')
                ->get();

            return response()->json($rmas);
        } catch (\Exception $e) {
            \Log::error('RMA Stock API Error: ' . $e->getMessage());
            return response()->json([
                'message' => 'Error loading RMA stock',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}

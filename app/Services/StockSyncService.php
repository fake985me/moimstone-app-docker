<?php

namespace App\Services;

use App\Models\Product;
use App\Models\CurrentStock;
use App\Models\StockTransaction;
use Illuminate\Support\Facades\DB;

class StockSyncService
{
    /**
     * Deduct stock from both Product and CurrentStock tables
     * 
     * @param int $productId
     * @param int $quantity
     * @param string $referenceType (sale, lending, etc.)
     * @param int $referenceId
     * @param string|null $notes
     * @return bool
     * @throws \Exception
     */
    public function deductStock($productId, $quantity, $referenceType, $referenceId, $notes = null)
    {
        DB::beginTransaction();
        try {
            // Get product
            $product = Product::findOrFail($productId);
            
            // Get or create current stock
            $currentStock = CurrentStock::firstOrCreate(
                ['product_id' => $productId],
                ['quantity' => $product->stock ?? 0, 'last_updated' => now()]
            );
            
            // Check if enough stock available
            if ($currentStock->quantity < $quantity) {
                throw new \Exception("Insufficient stock for {$product->title}. Available: {$currentStock->quantity}, Requested: {$quantity}");
            }
            
            // Deduct from both tables
            $product->decrement('stock', $quantity);
            $currentStock->quantity -= $quantity;
            $currentStock->last_updated = now();
            $currentStock->save();
            
            // Create stock transaction
            StockTransaction::create([
                'product_id' => $productId,
                'transaction_type' => 'out',
                'quantity' => $quantity,
                'reference_type' => $referenceType,
                'reference_id' => $referenceId,
                'user_id' => auth()->id(),
                'notes' => $notes,
            ]);
            
            DB::commit();
            return true;
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }
    
    /**
     * Add stock to both Product and CurrentStock tables
     * 
     * @param int $productId
     * @param int $quantity
     * @param string $referenceType (purchase, lending_return, etc.)
     * @param int $referenceId
     * @param string|null $notes
     * @return bool
     */
    public function addStock($productId, $quantity, $referenceType, $referenceId, $notes = null)
    {
        DB::beginTransaction();
        try {
            // Get product
            $product = Product::findOrFail($productId);
            
            // Get or create current stock
            $currentStock = CurrentStock::firstOrCreate(
                ['product_id' => $productId],
                ['quantity' => $product->stock ?? 0, 'last_updated' => now()]
            );
            
            // Add to both tables
            $product->increment('stock', $quantity);
            $currentStock->quantity += $quantity;
            $currentStock->last_updated = now();
            $currentStock->save();
            
            // Create stock transaction
            StockTransaction::create([
                'product_id' => $productId,
                'transaction_type' => 'in',
                'quantity' => $quantity,
                'reference_type' => $referenceType,
                'reference_id' => $referenceId,
                'user_id' => auth()->id(),
                'notes' => $notes,
            ]);
            
            DB::commit();
            return true;
        } catch (\Exception $e) {
            DB::rollBack();
            throw $e;
        }
    }
    
    /**
     * Sync Product stock with CurrentStock
     * Useful after data imports or when tables get out of sync
     * 
     * @param int|null $productId If null, sync all products
     * @return int Number of products synced
     */
    public function syncProductStock($productId = null)
    {
        $query = Product::query();
        
        if ($productId) {
            $query->where('id', $productId);
        }
        
        $products = $query->get();
        $synced = 0;
        
        foreach ($products as $product) {
            $currentStock = CurrentStock::firstOrCreate(
                ['product_id' => $product->id],
                ['quantity' => 0, 'last_updated' => now()]
            );
            
            // Sync CurrentStock quantity with Product stock
            $currentStock->quantity = $product->stock ?? 0;
            $currentStock->last_updated = now();
            $currentStock->save();
            
            $synced++;
        }
        
        return $synced;
    }
    
    /**
     * Check if product has sufficient stock
     * 
     * @param int $productId
     * @param int $quantity
     * @return bool
     */
    public function hasStock($productId, $quantity)
    {
        $currentStock = CurrentStock::where('product_id', $productId)->first();
        
        if (!$currentStock) {
            return false;
        }
        
        return $currentStock->quantity >= $quantity;
    }
    
    /**
     * Get current stock quantity for a product
     * 
     * @param int $productId
     * @return int
     */
    public function getStockQuantity($productId)
    {
        $currentStock = CurrentStock::where('product_id', $productId)->first();
        return $currentStock ? $currentStock->quantity : 0;
    }
}

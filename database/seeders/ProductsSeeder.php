<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class ProductsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $this->command->info('Seeding products from exported data...');
        
        // Load exported products data
        $productsFile = database_path('seeders/data/products.php');
        
        if (!file_exists($productsFile)) {
            $this->command->error('Products data file not found!');
            $this->command->line('Please run: php artisan export:products');
            return;
        }
        
        $products = include $productsFile;
        
        if (empty($products)) {
            $this->command->warn('No products found in data file!');
            return;
        }

        // Get all categories and subcategories for mapping
        $categories = DB::table('categories')->pluck('id', 'name')->toArray();
        $subCategories = DB::table('sub_categories')
            ->select('id', 'name', 'category_id')
            ->get()
            ->groupBy('category_id');
        
        // Insert products in batches for better performance
        $batchSize = 100;
        $batches = array_chunk($products, $batchSize);
        $totalInserted = 0;
        $categoryLinks = [];
        
        foreach ($batches as $index => $batch) {
            // Remove id and convert timestamps for each product
            $cleanBatch = array_map(function($product) {
                $originalId = $product['id'];
                unset($product['id']);
                // Keep timestamps as is, they're already in correct format
                if (isset($product['created_at'])) {
                    $product['created_at'] = \Carbon\Carbon::parse($product['created_at']);
                }
                if (isset($product['updated_at'])) {
                    $product['updated_at'] = \Carbon\Carbon::parse($product['updated_at']);
                }
                return $product;
            }, $batch);
            
            DB::table('products')->insert($cleanBatch);
            $totalInserted += count($cleanBatch);
            $this->command->line("Batch " . ($index + 1) . " inserted (" . count($cleanBatch) . " products)");
        }
        
        $this->command->info("✓ Successfully seeded {$totalInserted} products!");
        
        // Now sync product_category pivot table
        $this->command->info('Syncing product categories to pivot table...');
        
        // Get all products with their category/sub_category strings
        $allProducts = DB::table('products')
            ->select('id', 'category', 'sub_category')
            ->whereNotNull('category')
            ->get();
        
        $pivotRecords = [];
        $linked = 0;
        
        foreach ($allProducts as $product) {
            // Find category ID by name
            $categoryId = $categories[$product->category] ?? null;
            
            if ($categoryId) {
                // Find subcategory ID if exists
                $subCategoryId = null;
                if ($product->sub_category && isset($subCategories[$categoryId])) {
                    $subCat = $subCategories[$categoryId]->firstWhere('name', $product->sub_category);
                    $subCategoryId = $subCat ? $subCat->id : null;
                }
                
                $pivotRecords[] = [
                    'product_id' => $product->id,
                    'category_id' => $categoryId,
                    'sub_category_id' => $subCategoryId,
                    'created_at' => now(),
                    'updated_at' => now(),
                ];
                $linked++;
            }
        }
        
        // Insert pivot records in batches
        if (!empty($pivotRecords)) {
            // Clear existing pivot records first
            DB::table('product_category')->truncate();
            
            $pivotBatches = array_chunk($pivotRecords, 100);
            foreach ($pivotBatches as $pivotBatch) {
                DB::table('product_category')->insert($pivotBatch);
            }
        }
        
        $this->command->info("✓ Linked {$linked} products to categories via pivot table!");
    }
}

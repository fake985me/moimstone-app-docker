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
        
        // Insert products in batches for better performance
        $batchSize = 100;
        $batches = array_chunk($products, $batchSize);
        $totalInserted = 0;
        
        foreach ($batches as $index => $batch) {
            // Remove id and convert timestamps for each product
            $cleanBatch = array_map(function($product) {
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
    }
}

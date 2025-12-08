<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ProductSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Load products from exported file
        $productsFile = base_path('database/seeders/data/products.php');

        if (!file_exists($productsFile)) {
            $this->command->error('Products data file not found. Run: php artisan export:products');
            return;
        }

        $products = include $productsFile;

        if (empty($products)) {
            $this->command->error('No products found in data file');
            return;
        }

        $this->command->info('Importing ' . count($products) . ' products...');

        foreach ($products as $productData) {
            // Remove timestamps and id to let database handle them
            unset($productData['created_at'], $productData['updated_at'], $productData['id']);

            try {
                // Use updateOrCreate to avoid duplicates
                // Match by slug since SKU is empty for most products
                \App\Models\Product::updateOrCreate(
                    ['slug' => $productData['slug']], // Match by slug (unique identifier)
                    $productData
                );
            } catch (\Exception $e) {
                $this->command->warn('Failed to import product ' . ($productData['title'] ?? 'Unknown') . ': ' . $e->getMessage());
            }
        }

        $count = \App\Models\Product::count();
        $this->command->info("✅ Products seeded successfully! Total products: {$count}");
    }
}

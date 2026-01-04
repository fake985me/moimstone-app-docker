<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class SubCategorySeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Get category IDs
        $xgspon = DB::table('categories')->where('name', 'XGSPON')->first();
        $gpon = DB::table('categories')->where('name', 'GPON')->first();
        $switch = DB::table('categories')->where('name', 'SWITCH')->first();
        $router = DB::table('categories')->where('name', 'ROUTER')->first();
        $wireless = DB::table('categories')->where('name', 'WIRELESS')->first();

        // Check if categories exist
        if (!$xgspon || !$gpon || !$switch) {
            $this->command->error('Categories must be seeded first! Run CategorySeeder.');
            return;
        }

        $subCategories = [
            ['category_id' => $xgspon->id, 'name' => 'OLT', 'description' => 'Optical Line Terminal'],
            ['category_id' => $xgspon->id, 'name' => 'ONT', 'description' => 'Optical Network Terminal'],
            ['category_id' => $xgspon->id, 'name' => 'ONU PoE', 'description' => 'Optical Network Unit with PoE'],
            ['category_id' => $gpon->id, 'name' => 'OLT', 'description' => 'Optical Line Terminal'],
            ['category_id' => $gpon->id, 'name' => 'ONT', 'description' => 'Optical Network Terminal'],
            ['category_id' => $gpon->id, 'name' => 'ONU', 'description' => 'Optical Network Unit'],
            ['category_id' => $gpon->id, 'name' => 'ONU PoE', 'description' => 'Optical Network Unit with PoE'],
            ['category_id' => $switch->id, 'name' => 'Backbone Switch', 'description' => 'Backbone Switch'],
            ['category_id' => $switch->id, 'name' => 'L2 Switch', 'description' => 'Layer 2 Switch'],
            ['category_id' => $switch->id, 'name' => 'L2 POE Switch', 'description' => 'Layer 2 Switch with PoE'],
            ['category_id' => $switch->id, 'name' => 'L3 Switch', 'description' => 'Layer 3 Switch'],
        ];

        // Add optional categories if they exist
        if ($router) {
            $subCategories[] = ['category_id' => $router->id, 'name' => 'ENTERPRISE ROUTER', 'description' => 'Enterprise Router'];
        }
        if ($wireless) {
            $subCategories[] = ['category_id' => $wireless->id, 'name' => 'INDOOR AP', 'description' => 'Indoor Access Point'];
            $subCategories[] = ['category_id' => $wireless->id, 'name' => 'OUTDOOR AP', 'description' => 'Outdoor Access Point'];
            $subCategories[] = ['category_id' => $wireless->id, 'name' => 'CONTROLLER', 'description' => 'Wireless Controller'];
        }

        foreach ($subCategories as $subCategory) {
            // Use updateOrCreate to avoid duplicates
            DB::table('sub_categories')->updateOrInsert(
                ['category_id' => $subCategory['category_id'], 'name' => $subCategory['name']],
                $subCategory
            );
        }

        $this->command->info('✅ Sub-categories seeded successfully!');
    }
}

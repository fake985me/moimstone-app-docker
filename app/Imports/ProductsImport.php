<?php

namespace App\Imports;

use App\Models\Product;
use Maatwebsite\Excel\Concerns\ToModel;
use Maatwebsite\Excel\Concerns\WithHeadingRow;
use Maatwebsite\Excel\Concerns\WithValidation;
use Maatwebsite\Excel\Concerns\SkipsOnFailure;
use Maatwebsite\Excel\Concerns\SkipsFailures;
use Maatwebsite\Excel\Concerns\WithBatchInserts;
use Maatwebsite\Excel\Concerns\WithChunkReading;
use Illuminate\Support\Str;

class ProductsImport implements ToModel, WithHeadingRow, WithValidation, SkipsOnFailure, WithBatchInserts, WithChunkReading
{
    use SkipsFailures;

    /**
     * @param array $row
     * @return \Illuminate\Database\Eloquent\Model|null
     */
    public function model(array $row)
    {
        // Check if product exists by SKU
        $product = null;
        if (!empty($row['sku'])) {
            $product = Product::where('sku', $row['sku'])->first();
        }

        // Generate slug from title if not exists
        $slug = !empty($row['title']) ? Str::slug($row['title']) : null;

        $data = [
            'sku' => $row['sku'] ?? null,
            'title' => $row['title'] ?? null,
            'subtitle' => $row['subtitle'] ?? null,
            'category' => $row['category'] ?? null,
            'sub_category' => $row['sub_category'] ?? null,
            'brand' => $row['brand'] ?? null,
            'module' => $row['module'] ?? 'A',
            'slug' => $slug,
            'descriptions' => $row['descriptions'] ?? null,
            // Specs
            'spec1' => $row['spec1'] ?? null,
            'spec2' => $row['spec2'] ?? null,
            'spec3' => $row['spec3'] ?? null,
            'spec4' => $row['spec4'] ?? null,
            'spec5' => $row['spec5'] ?? null,
            'spec6' => $row['spec6'] ?? null,
            'spec7' => $row['spec7'] ?? null,
            // Features
            'fitur1' => $row['fitur1'] ?? null,
            'fitur2' => $row['fitur2'] ?? null,
            'fitur3' => $row['fitur3'] ?? null,
            'fitur4' => $row['fitur4'] ?? null,
            'fitur5' => $row['fitur5'] ?? null,
            'fitur6' => $row['fitur6'] ?? null,
            'fitur7' => $row['fitur7'] ?? null,
            'fitur8' => $row['fitur8'] ?? null,
            'fitur9' => $row['fitur9'] ?? null,
            'fitur10' => $row['fitur10'] ?? null,
            'fitur11' => $row['fitur11'] ?? null,
            'fitur12' => $row['fitur12'] ?? null,
            'fitur13' => $row['fitur13'] ?? null,
            'fitur14' => $row['fitur14'] ?? null,
            'fitur15' => $row['fitur15'] ?? null,
            // Technical Specs
            'flash_memory' => $row['flash_memory'] ?? null,
            'sdram_memory' => $row['sdram_memory'] ?? null,
            'interface_main' => $row['interface_main'] ?? null,
            'interface1' => $row['interface1'] ?? null,
            'interface2' => $row['interface2'] ?? null,
            'interface3' => $row['interface3'] ?? null,
            'interface4' => $row['interface4'] ?? null,
            'interface5' => $row['interface5'] ?? null,
            'operating_temperature' => $row['operating_temperature'] ?? null,
            'storage_temperature' => $row['storage_temperature'] ?? null,
            'operating_humidity' => $row['operating_humidity'] ?? null,
            'power1' => $row['power1'] ?? null,
            'power2' => $row['power2'] ?? null,
            'power3' => $row['power3'] ?? null,
            'power_consumptions' => $row['power_consumptions'] ?? null,
            'dimensions' => $row['dimensions'] ?? null,
            'diagram' => $row['diagram'] ?? null,
            'network_diagram' => $row['network_diagram'] ?? null,
        ];

        if ($product) {
            // Update existing product
            $product->update($data);
            return $product;
        } else {
            // Create new product
            return new Product($data);
        }
    }

    /**
     * @return array
     */
    public function rules(): array
    {
        return [
            'title' => 'required|string|max:255',
            'sku' => 'nullable|string|max:100',
            'category' => 'nullable|string|max:100',
            'sub_category' => 'nullable|string|max:100',
            'brand' => 'nullable|string|max:100',
        ];
    }

    /**
     * @return array
     */
    public function customValidationMessages()
    {
        return [
            'title.required' => 'Product title is required',
        ];
    }

    /**
     * @return int
     */
    public function batchSize(): int
    {
        return 100;
    }

    /**
     * @return int
     */
    public function chunkSize(): int
    {
        return 100;
    }
}

<?php

namespace App\Exports;

use App\Models\Product;
use Maatwebsite\Excel\Concerns\FromCollection;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithMapping;
use Maatwebsite\Excel\Concerns\WithColumnWidths;
use Maatwebsite\Excel\Concerns\WithStyles;
use PhpOffice\PhpSpreadsheet\Worksheet\Worksheet;

class ProductsExport implements FromCollection, WithHeadings, WithMapping, WithColumnWidths, WithStyles
{
    /**
     * @return \Illuminate\Support\Collection
     */
    public function collection()
    {
        return Product::all();
    }

    /**
     * @return array
     */
    public function headings(): array
    {
        return [
            'SKU',
            'Title',
            'Subtitle',
            'Category',
            'Sub Category',
            'Brand',
            'Module',
            'Descriptions',
            // Specs
            'Spec1',
            'Spec2',
            'Spec3',
            'Spec4',
            'Spec5',
            'Spec6',
            'Spec7',
            // Features
            'Fitur1',
            'Fitur2',
            'Fitur3',
            'Fitur4',
            'Fitur5',
            'Fitur6',
            'Fitur7',
            'Fitur8',
            'Fitur9',
            'Fitur10',
            'Fitur11',
            'Fitur12',
            'Fitur13',
            'Fitur14',
            'Fitur15',
            // Technical Specs
            'Flash Memory',
            'SDRAM Memory',
            'Interface Main',
            'Interface1',
            'Interface2',
            'Interface3',
            'Interface4',
            'Interface5',
            'Operating Temperature',
            'Storage Temperature',
            'Operating Humidity',
            'Power1',
            'Power2',
            'Power3',
            'Power Consumptions',
            'Dimensions',
            'Diagram',
            'Network Diagram',
        ];
    }

    /**
     * @param Product $product
     * @return array
     */
    public function map($product): array
    {
        return [
            $product->sku,
            $product->title,
            $product->subtitle,
            $product->category,
            $product->sub_category,
            $product->brand,
            $product->module,
            $product->descriptions,
            // Specs
            $product->spec1,
            $product->spec2,
            $product->spec3,
            $product->spec4,
            $product->spec5,
            $product->spec6,
            $product->spec7,
            // Features
            $product->fitur1,
            $product->fitur2,
            $product->fitur3,
            $product->fitur4,
            $product->fitur5,
            $product->fitur6,
            $product->fitur7,
            $product->fitur8,
            $product->fitur9,
            $product->fitur10,
            $product->fitur11,
            $product->fitur12,
            $product->fitur13,
            $product->fitur14,
            $product->fitur15,
            // Technical Specs
            $product->flash_memory,
            $product->sdram_memory,
            $product->interface_main,
            $product->interface1,
            $product->interface2,
            $product->interface3,
            $product->interface4,
            $product->interface5,
            $product->operating_temperature,
            $product->storage_temperature,
            $product->operating_humidity,
            $product->power1,
            $product->power2,
            $product->power3,
            $product->power_consumptions,
            $product->dimensions,
            $product->diagram,
            $product->network_diagram,
        ];
    }

    /**
     * @return array
     */
    public function columnWidths(): array
    {
        return [
            'A' => 20,  // SKU
            'B' => 30,  // Title
            'C' => 25,  // Subtitle
            'D' => 15,  // Category
            'E' => 20,  // Sub Category
            'F' => 15,  // Brand
            'G' => 10,  // Module
            'H' => 50,  // Descriptions
        ];
    }

    /**
     * @param Worksheet $sheet
     * @return array
     */
    public function styles(Worksheet $sheet)
    {
        return [
            // Style the first row as bold text
            1 => ['font' => ['bold' => true]],
        ];
    }
}

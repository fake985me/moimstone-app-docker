<?php

namespace App\Exports;

use Maatwebsite\Excel\Concerns\FromArray;
use Maatwebsite\Excel\Concerns\WithHeadings;
use Maatwebsite\Excel\Concerns\WithColumnWidths;
use Maatwebsite\Excel\Concerns\WithStyles;
use PhpOffice\PhpSpreadsheet\Worksheet\Worksheet;

class ProductsTemplateExport implements FromArray, WithHeadings, WithColumnWidths, WithStyles
{
    /**
     * @return array
     */
    public function array(): array
    {
        // Return empty array for template
        return [];
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
            // Style the first row as bold text with background
            1 => [
                'font' => ['bold' => true],
                'fill' => [
                    'fillType' => \PhpOffice\PhpSpreadsheet\Style\Fill::FILL_SOLID,
                    'startColor' => ['rgb' => 'E2EFDA']
                ]
            ],
        ];
    }
}

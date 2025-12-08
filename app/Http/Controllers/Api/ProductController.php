<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Product;
use App\Models\CurrentStock;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Maatwebsite\Excel\Facades\Excel;
use App\Exports\ProductsExport;
use App\Exports\ProductsTemplateExport;
use App\Imports\ProductsImport;

class ProductController extends Controller
{
    public function index(Request $request)
    {
        $query = Product::query();

        // Search
        if ($request->has('search')) {
            $search = $request->search;
            $query->where(function ($q) use ($search) {
                $q->where('title', 'like', "%{$search}%")
                    ->orWhere('sku', 'like', "%{$search}%")
                    ->orWhere('brand', 'like', "%{$search}%")
                    ->orWhere('category', 'like', "%{$search}%")
                    ->orWhere('descriptions', 'like', "%{$search}%");
            });
        }

        // Filter by category
        if ($request->has('category') && $request->category) {
            $query->where('category', $request->category);
        }

        // Filter by sub_category
        if ($request->has('sub_category') && $request->sub_category) {
            $query->where('sub_category', $request->sub_category);
        }

        // Filter by brand
        if ($request->has('brand') && $request->brand) {
            $query->where('brand', $request->brand);
        }

        // Filter by stock status
        if ($request->has('stock_status')) {
            switch ($request->stock_status) {
                case 'low':
                    $query->lowStock();
                    break;
                case 'out':
                    $query->outOfStock();
                    break;
                case 'in':
                    $query->inStock();
                    break;
            }
        }

        $products = $query->paginate($request->per_page ?? 15);

        return response()->json($products);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'sku' => 'nullable|string|max:100',
            'title' => 'required|string|max:255',
            'category' => 'nullable|string|max:100',
            'sub_category' => 'nullable|string|max:100',
            'brand' => 'nullable|string|max:100',
            'image' => 'nullable|string',
            'descriptions' => 'nullable|string',
            'stock' => 'nullable|integer|min:0',
            'minimum_stock' => 'nullable|integer|min:0',
        ]);

        $product = Product::create($validated);

        return response()->json($product, 201);
    }

    public function show($id)
    {
        $product = Product::findOrFail($id);

        return response()->json($product);
    }

    public function update(Request $request, $id)
    {
        $product = Product::findOrFail($id);

        $validated = $request->validate([
            'sku' => 'nullable|string|max:100',
            'title' => 'required|string|max:255',
            'category' => 'nullable|string|max:100',
            'sub_category' => 'nullable|string|max:100',
            'brand' => 'nullable|string|max:100',
            'image' => 'nullable|string',
            'descriptions' => 'nullable|string',
            'stock' => 'nullable|integer|min:0',
            'minimum_stock' => 'nullable|integer|min:0',
        ]);

        $product->update($validated);

        return response()->json($product);
    }

    public function destroy($id)
    {
        $product = Product::findOrFail($id);
        $product->delete();

        return response()->json(['message' => 'Product deleted successfully']);
    }

    public function uploadImages(Request $request, $id)
    {
        $product = Product::findOrFail($id);

        $request->validate([
            'images.*' => 'required|image|max:2048',
        ]);

        $images = [];
        foreach ($request->file('images') as $image) {
            $path = $image->store('products', 'public');
            $productImage = $product->images()->create([
                'image_path' => $path,
            ]);
            $images[] = $productImage;
        }

        return response()->json($images);
    }

    public function filterOptions()
    {
        $categories = Product::whereNotNull('category')
            ->distinct()
            ->pluck('category')
            ->filter()
            ->sort()
            ->values();

        $brands = Product::whereNotNull('brand')
            ->distinct()
            ->pluck('brand')
            ->filter()
            ->sort()
            ->values();

        return response()->json([
            'categories' => $categories,
            'brands' => $brands,
        ]);
    }

    /**
     * Export all products to Excel
     */
    public function exportProducts()
    {
        return Excel::download(new ProductsExport, 'products_' . date('Y-m-d') . '.xlsx');
    }

    /**
     * Export empty Excel template
     */
    public function exportTemplate()
    {
        return Excel::download(new ProductsTemplateExport, 'products_template.xlsx');
    }

    /**
     * Import products from Excel
     */
    public function importProducts(Request $request)
    {
        $request->validate([
            'file' => 'required|file|mimes:xlsx,xls,csv|max:10240', // Max 10MB
        ]);

        try {
            $file = $request->file('file');

            $import = new ProductsImport();
            Excel::import($import, $file);

            $failures = $import->failures();
            $failureCount = count($failures);
            $successCount = Product::count(); // This is approximate

            if ($failureCount > 0) {
                $errors = [];
                foreach ($failures as $failure) {
                    $errors[] = [
                        'row' => $failure->row(),
                        'attribute' => $failure->attribute(),
                        'errors' => $failure->errors(),
                        'values' => $failure->values(),
                    ];
                }

                return response()->json([
                    'success' => true,
                    'message' => "Import completed with {$failureCount} errors",
                    'failures' => $errors,
                    'failure_count' => $failureCount,
                ], 200);
            }

            return response()->json([
                'success' => true,
                'message' => 'Products imported successfully!',
                'failure_count' => 0,
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Import failed: ' . $e->getMessage(),
            ], 500);
        }
    }
}

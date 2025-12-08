<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Category;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class CategoryController extends Controller
{
    public function index(Request $request)
    {
        $query = Category::query();

        // Search
        if ($request->has('search')) {
            $search = $request->search;
            $query->where('name', 'like', "%{$search}%");
        }

        $categories = $query->get();

        // Add product count for each category
        $categories->each(function ($category) {
            $category->products_count = DB::table('products')
                ->where('category', $category->name)
                ->count();
        });

        return response()->json($categories);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:100|unique:categories,name',
            'description' => 'nullable|string',
        ]);

        $category = Category::create($validated);

        return response()->json($category, 201);
    }

    public function show($id)
    {
        $category = Category::findOrFail($id);

        // Get products that match this category
        $category->products_count = DB::table('products')
            ->where('category', $category->name)
            ->count();

        return response()->json($category);
    }

    public function update(Request $request, $id)
    {
        $category = Category::findOrFail($id);

        $validated = $request->validate([
            'name' => 'required|string|max:100|unique:categories,name,' . $id,
            'description' => 'nullable|string',
        ]);

        $category->update($validated);

        return response()->json($category);
    }

    public function destroy($id)
    {
        $category = Category::findOrFail($id);

        // Check if category is used by products
        $productsCount = DB::table('products')
            ->where('category', $category->name)
            ->count();

        if ($productsCount > 0) {
            return response()->json([
                'message' => "Cannot delete category. It is used by {$productsCount} product(s). Please reassign products first.",
                'products_count' => $productsCount
            ], 422);
        }

        $category->delete();

        return response()->json(['message' => 'Category deleted successfully']);
    }
}

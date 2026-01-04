<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Warehouse;
use App\Models\WarehouseLocation;
use Illuminate\Http\Request;

class WarehouseController extends Controller
{
    /**
     * Display a listing of warehouses.
     */
    public function index(Request $request)
    {
        $query = Warehouse::query()
            ->withCount(['locations', 'stocks'])
            ->withSum('stocks', 'quantity');

        if ($request->filled('search')) {
            $search = $request->search;
            $query->where(function ($q) use ($search) {
                $q->where('name', 'like', "%{$search}%")
                    ->orWhere('code', 'like', "%{$search}%")
                    ->orWhere('address', 'like', "%{$search}%");
            });
        }

        if ($request->filled('is_active')) {
            $query->where('is_active', $request->boolean('is_active'));
        }

        $warehouses = $query->orderBy('is_default', 'desc')
            ->orderBy('name')
            ->paginate($request->get('per_page', 15));

        return response()->json($warehouses);
    }

    /**
     * Store a newly created warehouse.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'code' => 'nullable|string|max:20|unique:warehouses,code',
            'address' => 'nullable|string',
            'phone' => 'nullable|string|max:50',
            'email' => 'nullable|email|max:255',
            'description' => 'nullable|string',
            'is_active' => 'boolean',
            'is_default' => 'boolean',
        ]);

        $warehouse = Warehouse::create($validated);

        // If this is set as default, unset other defaults
        if ($warehouse->is_default) {
            Warehouse::where('id', '!=', $warehouse->id)
                ->where('is_default', true)
                ->update(['is_default' => false]);
        }

        return response()->json($warehouse, 201);
    }

    /**
     * Display the specified warehouse.
     */
    public function show(Warehouse $warehouse)
    {
        $warehouse->load(['locations' => function ($q) {
            $q->withSum('stocks', 'quantity');
        }]);
        
        $warehouse->loadCount(['locations', 'stocks']);
        $warehouse->loadSum('stocks', 'quantity');

        return response()->json($warehouse);
    }

    /**
     * Update the specified warehouse.
     */
    public function update(Request $request, Warehouse $warehouse)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'code' => 'nullable|string|max:20|unique:warehouses,code,' . $warehouse->id,
            'address' => 'nullable|string',
            'phone' => 'nullable|string|max:50',
            'email' => 'nullable|email|max:255',
            'description' => 'nullable|string',
            'is_active' => 'boolean',
            'is_default' => 'boolean',
        ]);

        $warehouse->update($validated);

        // If this is set as default, unset other defaults
        if ($warehouse->is_default) {
            Warehouse::where('id', '!=', $warehouse->id)
                ->where('is_default', true)
                ->update(['is_default' => false]);
        }

        return response()->json($warehouse);
    }

    /**
     * Remove the specified warehouse.
     */
    public function destroy(Warehouse $warehouse)
    {
        // Check if warehouse has stock
        if ($warehouse->stocks()->exists()) {
            return response()->json([
                'message' => 'Cannot delete warehouse with existing stock. Please transfer or remove stock first.'
            ], 422);
        }

        $warehouse->delete();

        return response()->json(['message' => 'Warehouse deleted successfully']);
    }

    /**
     * Get warehouse locations
     */
    public function locations(Warehouse $warehouse)
    {
        $locations = $warehouse->locations()
            ->withSum('stocks', 'quantity')
            ->orderBy('zone')
            ->orderBy('aisle')
            ->orderBy('rack')
            ->orderBy('shelf')
            ->get();

        return response()->json($locations);
    }

    /**
     * Store a new location in warehouse
     */
    public function storeLocation(Request $request, Warehouse $warehouse)
    {
        $validated = $request->validate([
            'code' => 'nullable|string|max:20',
            'name' => 'required|string|max:255',
            'zone' => 'nullable|string|max:10',
            'aisle' => 'nullable|string|max:10',
            'rack' => 'nullable|string|max:10',
            'shelf' => 'nullable|string|max:10',
            'capacity' => 'nullable|integer|min:0',
            'is_active' => 'boolean',
        ]);

        $validated['warehouse_id'] = $warehouse->id;

        // Check for duplicate code in same warehouse
        if (!empty($validated['code'])) {
            $exists = WarehouseLocation::where('warehouse_id', $warehouse->id)
                ->where('code', $validated['code'])
                ->exists();
            
            if ($exists) {
                return response()->json([
                    'message' => 'Location code already exists in this warehouse'
                ], 422);
            }
        }

        $location = WarehouseLocation::create($validated);

        return response()->json($location, 201);
    }

    /**
     * Update a location
     */
    public function updateLocation(Request $request, WarehouseLocation $location)
    {
        $validated = $request->validate([
            'code' => 'nullable|string|max:20',
            'name' => 'required|string|max:255',
            'zone' => 'nullable|string|max:10',
            'aisle' => 'nullable|string|max:10',
            'rack' => 'nullable|string|max:10',
            'shelf' => 'nullable|string|max:10',
            'capacity' => 'nullable|integer|min:0',
            'is_active' => 'boolean',
        ]);

        // Check for duplicate code in same warehouse
        if (!empty($validated['code'])) {
            $exists = WarehouseLocation::where('warehouse_id', $location->warehouse_id)
                ->where('code', $validated['code'])
                ->where('id', '!=', $location->id)
                ->exists();
            
            if ($exists) {
                return response()->json([
                    'message' => 'Location code already exists in this warehouse'
                ], 422);
            }
        }

        $location->update($validated);

        return response()->json($location);
    }

    /**
     * Delete a location
     */
    public function destroyLocation(WarehouseLocation $location)
    {
        if ($location->stocks()->exists()) {
            return response()->json([
                'message' => 'Cannot delete location with existing stock. Please move stock first.'
            ], 422);
        }

        $location->delete();

        return response()->json(['message' => 'Location deleted successfully']);
    }

    /**
     * Get warehouse statistics
     */
    public function statistics()
    {
        $stats = [
            'total_warehouses' => Warehouse::count(),
            'active_warehouses' => Warehouse::where('is_active', true)->count(),
            'total_locations' => WarehouseLocation::count(),
            'active_locations' => WarehouseLocation::where('is_active', true)->count(),
            'warehouses' => Warehouse::withCount('locations')
                ->withSum('stocks', 'quantity')
                ->orderBy('stocks_sum_quantity', 'desc')
                ->limit(10)
                ->get(),
        ];

        return response()->json($stats);
    }

    /**
     * Set warehouse as default
     */
    public function setDefault(Warehouse $warehouse)
    {
        $warehouse->setAsDefault();

        return response()->json([
            'message' => 'Warehouse set as default successfully',
            'warehouse' => $warehouse
        ]);
    }
}

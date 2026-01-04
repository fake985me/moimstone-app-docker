<template>
  <div class="space-y-6">
    <!-- Header -->
    <div class="flex justify-between items-center">
      <div>
        <h2 class="text-2xl font-bold bg-gradient-to-r from-emerald-600 to-teal-600 bg-clip-text text-transparent">
          Warehouse Management
        </h2>
        <p class="text-sm text-gray-600 mt-1">Manage your warehouses and storage locations</p>
      </div>
      <button
        @click="showModal = true; resetForm()"
        class="px-6 py-3 bg-gradient-to-r from-emerald-600 to-teal-600 text-white rounded-lg hover:from-emerald-700 hover:to-teal-700 transition-all duration-200 shadow-md hover:shadow-lg font-medium">
        + New Warehouse
      </button>
    </div>

    <!-- Statistics Cards -->
    <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
      <div class="card p-4 bg-gradient-to-br from-emerald-50 to-teal-50">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm text-gray-600">Total Warehouses</p>
            <p class="text-2xl font-bold text-emerald-600">{{ stats.total_warehouses || 0 }}</p>
          </div>
          <span class="text-3xl">🏭</span>
        </div>
      </div>
      <div class="card p-4 bg-gradient-to-br from-blue-50 to-indigo-50">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm text-gray-600">Active Warehouses</p>
            <p class="text-2xl font-bold text-blue-600">{{ stats.active_warehouses || 0 }}</p>
          </div>
          <span class="text-3xl">✅</span>
        </div>
      </div>
      <div class="card p-4 bg-gradient-to-br from-purple-50 to-pink-50">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm text-gray-600">Total Locations</p>
            <p class="text-2xl font-bold text-purple-600">{{ stats.total_locations || 0 }}</p>
          </div>
          <span class="text-3xl">📍</span>
        </div>
      </div>
      <div class="card p-4 bg-gradient-to-br from-orange-50 to-amber-50">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm text-gray-600">Active Locations</p>
            <p class="text-2xl font-bold text-orange-600">{{ stats.active_locations || 0 }}</p>
          </div>
          <span class="text-3xl">📦</span>
        </div>
      </div>
    </div>

    <!-- Filters -->
    <div class="card p-4">
      <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
        <input
          v-model="filters.search"
          @input="loadWarehouses"
          type="text"
          placeholder="Search warehouses..."
          class="input" />
        <select v-model="filters.is_active" @change="loadWarehouses" class="input">
          <option value="">All Status</option>
          <option value="1">Active</option>
          <option value="0">Inactive</option>
        </select>
      </div>
    </div>

    <!-- Warehouses Table -->
    <div class="table-wrapper">
      <div class="card-header">
        <h3 class="text-lg font-semibold text-gray-900">Warehouses</h3>
      </div>

      <div v-if="loading" class="p-8 text-center">
        <p class="text-gray-600">Loading warehouses...</p>
      </div>

      <table v-else class="min-w-full">
        <thead class="table-header">
          <tr>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Code</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Name</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Address</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Locations</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Total Stock</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Status</th>
            <th class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase">Actions</th>
          </tr>
        </thead>
        <tbody class="bg-white divide-y divide-gray-200">
          <tr v-for="warehouse in warehouses.data" :key="warehouse.id" class="hover:bg-gray-50">
            <td class="px-6 py-4 whitespace-nowrap">
              <div class="flex items-center">
                <span class="text-sm font-medium text-gray-900">{{ warehouse.code }}</span>
                <span v-if="warehouse.is_default" class="ml-2 px-2 py-0.5 text-xs rounded-full bg-yellow-100 text-yellow-800">Default</span>
              </div>
            </td>
            <td class="px-6 py-4">
              <div class="text-sm font-medium text-gray-900">{{ warehouse.name }}</div>
              <div v-if="warehouse.email" class="text-xs text-gray-500">{{ warehouse.email }}</div>
            </td>
            <td class="px-6 py-4">
              <div class="text-sm text-gray-600 max-w-xs truncate">{{ warehouse.address || '-' }}</div>
            </td>
            <td class="px-6 py-4 whitespace-nowrap">
              <span class="text-sm font-medium text-purple-600">{{ warehouse.locations_count || 0 }}</span>
            </td>
            <td class="px-6 py-4 whitespace-nowrap">
              <span class="text-sm font-bold text-emerald-600">{{ warehouse.stocks_sum_quantity || 0 }}</span>
            </td>
            <td class="px-6 py-4 whitespace-nowrap">
              <span :class="warehouse.is_active ? 'bg-green-100 text-green-800' : 'bg-gray-100 text-gray-800'"
                class="px-2 py-1 text-xs rounded-full">
                {{ warehouse.is_active ? 'Active' : 'Inactive' }}
              </span>
            </td>
            <td class="px-6 py-4 text-right text-sm space-x-2">
              <button @click="viewWarehouse(warehouse)" class="text-indigo-600 hover:text-indigo-900">View</button>
              <button @click="editWarehouse(warehouse)" class="text-blue-600 hover:text-blue-900">Edit</button>
              <button v-if="!warehouse.is_default" @click="setDefault(warehouse)" class="text-yellow-600 hover:text-yellow-900">Set Default</button>
              <button @click="deleteWarehouse(warehouse)" class="text-red-600 hover:text-red-900">Delete</button>
            </td>
          </tr>
          <tr v-if="!warehouses.data?.length">
            <td colspan="7" class="px-6 py-8 text-center text-gray-500">No warehouses found</td>
          </tr>
        </tbody>
      </table>

      <!-- Pagination -->
      <div v-if="warehouses.data?.length" class="px-6 py-4 bg-gray-50 flex justify-between">
        <p class="text-sm text-gray-700">Showing {{ warehouses.from }} to {{ warehouses.to }} of {{ warehouses.total }}</p>
        <div class="flex space-x-2">
          <button @click="loadWarehouses(warehouses.current_page - 1)" :disabled="!warehouses.prev_page_url" class="btn-secondary disabled:opacity-50">Previous</button>
          <button @click="loadWarehouses(warehouses.current_page + 1)" :disabled="!warehouses.next_page_url" class="btn-secondary disabled:opacity-50">Next</button>
        </div>
      </div>
    </div>

    <!-- Create/Edit Modal -->
    <div v-if="showModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
      <div class="bg-white rounded-xl p-6 w-full max-w-lg max-h-[90vh] overflow-y-auto">
        <h3 class="text-2xl font-bold mb-6">{{ editingId ? 'Edit Warehouse' : 'New Warehouse' }}</h3>
        
        <form @submit.prevent="saveWarehouse" class="space-y-4">
          <div class="grid grid-cols-2 gap-4">
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-1">Code</label>
              <input v-model="form.code" class="input" placeholder="Auto-generated if empty" />
            </div>
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-1">Name *</label>
              <input v-model="form.name" required class="input" placeholder="Warehouse name" />
            </div>
          </div>

          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Address</label>
            <textarea v-model="form.address" rows="2" class="input" placeholder="Full address"></textarea>
          </div>

          <div class="grid grid-cols-2 gap-4">
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-1">Phone</label>
              <input v-model="form.phone" class="input" placeholder="Phone number" />
            </div>
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-1">Email</label>
              <input v-model="form.email" type="email" class="input" placeholder="Email address" />
            </div>
          </div>

          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Description</label>
            <textarea v-model="form.description" rows="2" class="input" placeholder="Optional description"></textarea>
          </div>

          <div class="flex items-center space-x-6">
            <label class="flex items-center">
              <input v-model="form.is_active" type="checkbox" class="h-4 w-4 text-emerald-600 rounded" />
              <span class="ml-2 text-sm text-gray-700">Active</span>
            </label>
            <label class="flex items-center">
              <input v-model="form.is_default" type="checkbox" class="h-4 w-4 text-yellow-600 rounded" />
              <span class="ml-2 text-sm text-gray-700">Set as Default</span>
            </label>
          </div>

          <div v-if="error" class="bg-red-50 text-red-600 p-3 rounded-lg text-sm">{{ error }}</div>

          <div class="flex justify-end space-x-3 pt-4 border-t">
            <button type="button" @click="showModal = false" class="btn-secondary">Cancel</button>
            <button type="submit" :disabled="saving" class="btn-primary">{{ saving ? 'Saving...' : 'Save Warehouse' }}</button>
          </div>
        </form>
      </div>
    </div>

    <!-- View Warehouse Modal -->
    <div v-if="showViewModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
      <div class="bg-white rounded-xl p-6 w-full max-w-4xl max-h-[90vh] overflow-y-auto">
        <div class="flex justify-between items-start mb-6">
          <div>
            <h3 class="text-2xl font-bold text-gray-900">{{ selectedWarehouse?.name }}</h3>
            <p class="text-sm text-gray-500">{{ selectedWarehouse?.code }}</p>
          </div>
          <span :class="selectedWarehouse?.is_active ? 'bg-green-100 text-green-800' : 'bg-gray-100 text-gray-800'"
            class="px-3 py-1 text-sm rounded-full">
            {{ selectedWarehouse?.is_active ? 'Active' : 'Inactive' }}
          </span>
        </div>

        <!-- Warehouse Info -->
        <div class="grid grid-cols-2 gap-4 mb-6 p-4 bg-gray-50 rounded-lg">
          <div><span class="text-gray-500">Address:</span> {{ selectedWarehouse?.address || '-' }}</div>
          <div><span class="text-gray-500">Phone:</span> {{ selectedWarehouse?.phone || '-' }}</div>
          <div><span class="text-gray-500">Email:</span> {{ selectedWarehouse?.email || '-' }}</div>
          <div><span class="text-gray-500">Total Stock:</span> <strong>{{ selectedWarehouse?.stocks_sum_quantity || 0 }}</strong></div>
        </div>

        <!-- Locations Section -->
        <div class="border-t pt-4">
          <div class="flex justify-between items-center mb-4">
            <h4 class="font-semibold text-gray-800">Locations ({{ selectedWarehouse?.locations?.length || 0 }})</h4>
            <button @click="showLocationModal = true; resetLocationForm()" class="text-sm text-emerald-600 hover:text-emerald-800">+ Add Location</button>
          </div>

          <table v-if="selectedWarehouse?.locations?.length" class="min-w-full text-sm">
            <thead class="bg-gray-50">
              <tr>
                <th class="px-4 py-2 text-left">Code</th>
                <th class="px-4 py-2 text-left">Name</th>
                <th class="px-4 py-2 text-left">Zone/Aisle/Rack</th>
                <th class="px-4 py-2 text-right">Capacity</th>
                <th class="px-4 py-2 text-right">Stock</th>
                <th class="px-4 py-2 text-center">Status</th>
                <th class="px-4 py-2 text-right">Actions</th>
              </tr>
            </thead>
            <tbody class="divide-y divide-gray-200">
              <tr v-for="loc in selectedWarehouse?.locations" :key="loc.id">
                <td class="px-4 py-2 font-medium">{{ loc.code }}</td>
                <td class="px-4 py-2">{{ loc.name }}</td>
                <td class="px-4 py-2 text-gray-500">{{ [loc.zone, loc.aisle, loc.rack, loc.shelf].filter(Boolean).join('-') || '-' }}</td>
                <td class="px-4 py-2 text-right">{{ loc.capacity || '-' }}</td>
                <td class="px-4 py-2 text-right font-medium">{{ loc.stocks_sum_quantity || 0 }}</td>
                <td class="px-4 py-2 text-center">
                  <span :class="loc.is_active ? 'text-green-600' : 'text-gray-400'">{{ loc.is_active ? '●' : '○' }}</span>
                </td>
                <td class="px-4 py-2 text-right space-x-2">
                  <button @click="editLocation(loc)" class="text-blue-600 hover:text-blue-900">Edit</button>
                  <button @click="deleteLocation(loc)" class="text-red-600 hover:text-red-900">Delete</button>
                </td>
              </tr>
            </tbody>
          </table>
          <p v-else class="text-center text-gray-500 py-4">No locations defined</p>
        </div>

        <div class="flex justify-end mt-6">
          <button @click="showViewModal = false" class="btn-secondary">Close</button>
        </div>
      </div>
    </div>

    <!-- Location Modal -->
    <div v-if="showLocationModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
      <div class="bg-white rounded-xl p-6 w-full max-w-md">
        <h3 class="text-xl font-bold mb-4">{{ editingLocationId ? 'Edit Location' : 'New Location' }}</h3>
        
        <form @submit.prevent="saveLocation" class="space-y-4">
          <div class="grid grid-cols-2 gap-4">
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-1">Code</label>
              <input v-model="locationForm.code" class="input" placeholder="Auto-generated" />
            </div>
            <div>
              <label class="block text-sm font-medium text-gray-700 mb-1">Name *</label>
              <input v-model="locationForm.name" required class="input" placeholder="Location name" />
            </div>
          </div>

          <div class="grid grid-cols-4 gap-2">
            <div>
              <label class="block text-xs font-medium text-gray-700 mb-1">Zone</label>
              <input v-model="locationForm.zone" class="input" placeholder="A" />
            </div>
            <div>
              <label class="block text-xs font-medium text-gray-700 mb-1">Aisle</label>
              <input v-model="locationForm.aisle" class="input" placeholder="1" />
            </div>
            <div>
              <label class="block text-xs font-medium text-gray-700 mb-1">Rack</label>
              <input v-model="locationForm.rack" class="input" placeholder="01" />
            </div>
            <div>
              <label class="block text-xs font-medium text-gray-700 mb-1">Shelf</label>
              <input v-model="locationForm.shelf" class="input" placeholder="A" />
            </div>
          </div>

          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Capacity</label>
            <input v-model.number="locationForm.capacity" type="number" min="0" class="input" placeholder="Max items (optional)" />
          </div>

          <label class="flex items-center">
            <input v-model="locationForm.is_active" type="checkbox" class="h-4 w-4 text-emerald-600 rounded" />
            <span class="ml-2 text-sm text-gray-700">Active</span>
          </label>

          <div v-if="locationError" class="bg-red-50 text-red-600 p-3 rounded-lg text-sm">{{ locationError }}</div>

          <div class="flex justify-end space-x-3 pt-4 border-t">
            <button type="button" @click="showLocationModal = false" class="btn-secondary">Cancel</button>
            <button type="submit" :disabled="savingLocation" class="btn-primary">{{ savingLocation ? 'Saving...' : 'Save Location' }}</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import api from '../services/api';

const warehouses = ref({ data: [] });
const stats = ref({});
const loading = ref(true);
const showModal = ref(false);
const showViewModal = ref(false);
const showLocationModal = ref(false);
const selectedWarehouse = ref(null);
const editingId = ref(null);
const editingLocationId = ref(null);
const saving = ref(false);
const savingLocation = ref(false);
const error = ref('');
const locationError = ref('');

const filters = ref({ search: '', is_active: '' });

const form = ref({
  code: '',
  name: '',
  address: '',
  phone: '',
  email: '',
  description: '',
  is_active: true,
  is_default: false,
});

const locationForm = ref({
  code: '',
  name: '',
  zone: '',
  aisle: '',
  rack: '',
  shelf: '',
  capacity: null,
  is_active: true,
});

const loadWarehouses = async (page = 1) => {
  loading.value = true;
  try {
    const response = await api.get('/warehouses', { params: { page, ...filters.value } });
    warehouses.value = response.data;
  } catch (err) {
    console.error('Failed to load warehouses:', err);
  } finally {
    loading.value = false;
  }
};

const loadStats = async () => {
  try {
    const response = await api.get('/warehouses/statistics');
    stats.value = response.data;
  } catch (err) {
    console.error('Failed to load statistics:', err);
  }
};

const resetForm = () => {
  form.value = { code: '', name: '', address: '', phone: '', email: '', description: '', is_active: true, is_default: false };
  editingId.value = null;
  error.value = '';
};

const resetLocationForm = () => {
  locationForm.value = { code: '', name: '', zone: '', aisle: '', rack: '', shelf: '', capacity: null, is_active: true };
  editingLocationId.value = null;
  locationError.value = '';
};

const saveWarehouse = async () => {
  saving.value = true;
  error.value = '';
  try {
    if (editingId.value) {
      await api.put(`/warehouses/${editingId.value}`, form.value);
    } else {
      await api.post('/warehouses', form.value);
    }
    showModal.value = false;
    loadWarehouses();
    loadStats();
  } catch (err) {
    error.value = err.response?.data?.message || 'Failed to save warehouse';
  } finally {
    saving.value = false;
  }
};

const editWarehouse = (warehouse) => {
  form.value = { ...warehouse };
  editingId.value = warehouse.id;
  showModal.value = true;
  error.value = '';
};

const viewWarehouse = async (warehouse) => {
  try {
    const response = await api.get(`/warehouses/${warehouse.id}`);
    selectedWarehouse.value = response.data;
    showViewModal.value = true;
  } catch (err) {
    alert('Failed to load warehouse details');
  }
};

const deleteWarehouse = async (warehouse) => {
  if (!confirm(`Delete warehouse "${warehouse.name}"?`)) return;
  try {
    await api.delete(`/warehouses/${warehouse.id}`);
    loadWarehouses();
    loadStats();
  } catch (err) {
    alert(err.response?.data?.message || 'Failed to delete warehouse');
  }
};

const setDefault = async (warehouse) => {
  try {
    await api.post(`/warehouses/${warehouse.id}/set-default`);
    loadWarehouses();
  } catch (err) {
    alert('Failed to set default warehouse');
  }
};

const saveLocation = async () => {
  savingLocation.value = true;
  locationError.value = '';
  try {
    if (editingLocationId.value) {
      await api.put(`/warehouse-locations/${editingLocationId.value}`, locationForm.value);
    } else {
      await api.post(`/warehouses/${selectedWarehouse.value.id}/locations`, locationForm.value);
    }
    showLocationModal.value = false;
    viewWarehouse(selectedWarehouse.value); // Refresh
    loadStats();
  } catch (err) {
    locationError.value = err.response?.data?.message || 'Failed to save location';
  } finally {
    savingLocation.value = false;
  }
};

const editLocation = (location) => {
  locationForm.value = { ...location };
  editingLocationId.value = location.id;
  showLocationModal.value = true;
  locationError.value = '';
};

const deleteLocation = async (location) => {
  if (!confirm(`Delete location "${location.name}"?`)) return;
  try {
    await api.delete(`/warehouse-locations/${location.id}`);
    viewWarehouse(selectedWarehouse.value); // Refresh
    loadStats();
  } catch (err) {
    alert(err.response?.data?.message || 'Failed to delete location');
  }
};

onMounted(() => {
  loadWarehouses();
  loadStats();
});
</script>

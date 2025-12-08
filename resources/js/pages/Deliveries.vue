<template>
  <div class="space-y-6">
    <!-- Header -->
    <div class="flex justify-between items-center">
      <div>
        <h2 class="text-2xl font-bold bg-gradient-to-r from-teal-600 to-cyan-600 bg-clip-text text-transparent">Delivery Management</h2>
        <p class="text-sm text-gray-600 mt-1">Create deliveries from pending sales and track shipments</p>
      </div>
    </div>

    <!-- Filters -->
    <div class="card p-4">
      <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
        <input v-model="filters.search" @input="loadDeliveries" type="text" placeholder="Search by invoice or customer..." class="input" />
      </div>
    </div>

    <!-- Deliveries Table -->
    <div class="table-wrapper">
      <div class="card-header">
        <h3 class="text-lg font-semibold text-gray-900">All Deliveries</h3>
      </div>

      <div v-if="loading" class="p-8 text-center">
        <p class="text-gray-600">Loading deliveries...</p>
      </div>

      <table v-else class="min-w-full">
        <thead class="table-header">
          <tr>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Invoice</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Customer</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Sale Date</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Total</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Delivery Status</th>
            <th class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase">Actions</th>
          </tr>
        </thead>
        <tbody class="bg-white divide-y divide-gray-200">
          <tr v-for="delivery in deliveries.data" :key="delivery.id" class="hover:bg-gray-50">
            <td class="px-6 py-4 text-sm font-medium text-gray-900">{{ delivery.sale?.invoice_number }}</td>
            <td class="px-6 py-4">
              <div class="text-sm font-medium text-gray-900">{{ delivery.sale?.customer_name }}</div>
              <div class="text-sm text-gray-500">{{ delivery.sale?.customer_phone }}</div>
            </td>
            <td class="px-6 py-4 text-sm text-gray-500">{{ formatDate(delivery.sale?.sale_date) }}</td>
            <td class="px-6 py-4 text-sm font-bold text-gray-900">Rp {{ formatPrice(delivery.sale?.total_amount) }}</td>
            <td class="px-6 py-4">
              <span :class="getDeliveryBadge(delivery.status)">{{ formatStatus(delivery.status) }}</span>
            </td>
            <td class="px-6 py-4 text-right text-sm space-x-2">
              <button @click="updateDeliveryStatus(delivery)" class="text-blue-600 hover:text-blue-900">Update Status</button>
              <button @click="viewSale(delivery.sale)" class="text-indigo-600 hover:text-indigo-900">View</button>
            </td>
          </tr>
        </tbody>
      </table>

      <!-- Pagination -->
      <div v-if="deliveries.data?.length" class="px-6 py-4 bg-gray-50 flex justify-between">
        <p class="text-sm text-gray-700">Showing {{ deliveries.from }} to {{ deliveries.to }} of {{ deliveries.total }}</p>
        <div class="flex space-x-2">
          <button @click="loadDeliveries(deliveries.current_page - 1)" :disabled="!deliveries.prev_page_url" class="btn-secondary disabled:opacity-50">Previous</button>
          <button @click="loadDeliveries(deliveries.current_page + 1)" :disabled="!deliveries.next_page_url" class="btn-secondary disabled:opacity-50">Next</button>
        </div>
      </div>
    </div>

    <!-- Create Delivery Modal -->
    <div v-if="showModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
      <div class="bg-white rounded-xl p-6 w-full max-w-md">
        <h3 class="text-xl font-bold mb-4">Create Delivery for {{ selectedSale?.invoice_number }}</h3>
        
        <form @submit.prevent="saveDelivery" class="space-y-4">
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Courier *</label>
            <input v-model="form.courier" required class="input" placeholder="JNE, TIKI, etc" />
          </div>
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Tracking Number</label>
            <input v-model="form.tracking_number" class="input" />
          </div>
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Notes</label>
            <textarea v-model="form.notes" rows="2" class="input"></textarea>
          </div>

          <div v-if="error" class="bg-red-50 text-red-600 p-3 rounded-lg text-sm">{{ error }}</div>

          <div class="flex justify-end space-x-3 pt-4 border-t">
            <button type="button" @click="showModal = false" class="btn-secondary">Cancel</button>
            <button type="submit" :disabled="saving" class="btn-primary">{{ saving ? 'Creating...' : 'Create Delivery' }}</button>
          </div>
        </form>
      </div>
    </div>

    <!-- Update Status Modal -->
    <div v-if="statusModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
      <div class="bg-white rounded-xl p-6 w-full max-w-md">
        <h3 class="text-xl font-bold mb-4">Update Delivery Status</h3>
        
        <form @submit.prevent="saveStatus" class="space-y-4">
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Status *</label>
            <select v-model="statusForm.status" required class="input">
              <option value="preparing">Preparing</option>
              <option value="shipped">Shipped</option>
              <option value="in_transit">In Transit</option>
              <option value="delivered">Delivered</option>
              <option value="cancelled">Cancelled</option>
            </select>
          </div>
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Tracking Number</label>
            <input v-model="statusForm.tracking_number" class="input" />
          </div>
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Notes</label>
            <textarea v-model="statusForm.notes" rows="2" class="input"></textarea>
          </div>

          <div v-if="statusForm.status === 'delivered'" class="bg-green-50 p-3 rounded-lg text-sm text-green-800">
            <strong>⚠️ Note:</strong> Setting status to Delivered will automatically mark the sale as Completed.
          </div>

          <div class="flex justify-end space-x-3 pt-4 border-t">
            <button type="button" @click="statusModal = false" class="btn-secondary">Cancel</button>
            <button type="submit" :disabled="saving" class="btn-primary">{{ saving ? 'Updating...' : 'Update Status' }}</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import api from '../services/api';

const deliveries = ref({ data: [] });
const loading = ref(true);
const showModal = ref(false);
const statusModal = ref(false);
const saving = ref(false);
const error = ref('');
const selectedSale = ref(null);
const selectedDelivery = ref(null);

const filters = ref({ search: '' });

const form = ref({
  sale_id: '',
  courier: '',
  tracking_number: '',
  notes: '',
});

const statusForm = ref({
  status: '',
  tracking_number: '',
  notes: '',
});

const formatDate = (date) => new Date(date).toLocaleDateString();
const formatPrice = (price) => new Intl.NumberFormat('id-ID').format(price || 0);
const formatStatus = (status) => status.replace(/_/g, ' ').toUpperCase();

const getDeliveryBadge = (status) => {
  const badges = {
    preparing: 'badge-info',
    shipped: 'badge-warning',
    in_transit: 'badge-warning',
    delivered: 'badge-success',
    cancelled: 'badge-danger',
  };
  return badges[status] || 'badge';
};

const loadDeliveries = async (page = 1) => {
  loading.value = true;
  try {
    const response = await api.get('/deliveries', { params: { page, ...filters.value } });
    deliveries.value = response.data;
  } catch (err) {
    console.error(err);
  } finally {
    loading.value = false;
  }
};

const createDelivery = (sale) => {
  selectedSale.value = sale;
  form.value = {
    sale_id: sale.id,
    courier: '',
    tracking_number: '',
    notes: '',
  };
  showModal.value = true;
};

const saveDelivery = async () => {
  saving.value = true;
  error.value = '';
  
  try {
    await api.post('/deliveries', form.value);
    showModal.value = false;
    loadDeliveries();
  } catch (err) {
    error.value = err.response?.data?.message || 'Failed to create delivery';
  } finally {
    saving.value = false;
  }
};

const updateDeliveryStatus = (delivery) => {
  selectedDelivery.value = delivery;
  statusForm.value = {
    status: delivery.status,
    tracking_number: delivery.tracking_number || '',
    notes: '',
  };
  statusModal.value = true;
};

const saveStatus = async () => {
  saving.value = true;
  try {
    await api.put(`/deliveries/${selectedDelivery.value.id}`, statusForm.value);
    statusModal.value = false;
    loadDeliveries();
  } catch (err) {
    alert(err.response?.data?.message || 'Failed to update status');
  } finally {
    saving.value = false;
  }
};

const viewSale = (sale) => {
  const items = sale.items?.map(i => `- ${i.product?.title}: ${i.quantity} x Rp ${formatPrice(i.unit_price)}`).join('\n');
  alert(`Sale: ${sale.invoice_number}\nCustomer: ${sale.customer_name}\nAddress: ${sale.customer_address || '-'}\n\nItems:\n${items}\n\nTotal: Rp ${formatPrice(sale.total_amount)}`);
};

onMounted(() => {
  loadDeliveries();
});
</script>

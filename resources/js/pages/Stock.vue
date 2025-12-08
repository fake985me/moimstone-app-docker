<template>
  <div class="space-y-6">
    <!-- Header -->
    <div class="flex justify-between items-center">
      <h2 class="text-2xl font-bold text-gray-900">Stock Management</h2>
      <button
        @click="showTransactionModal = true"
        class="px-4 py-2 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700 transition-colors"
      >
        + Record Transaction
      </button>
    </div>

    <!-- Filters -->
    <div class="bg-white rounded-lg shadow-md p-4">
      <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
        <input
          v-model="filters.search"
          @input="loadStocks"
          type="text"
          placeholder="Search by product name or SKU..."
          class="px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500"
        />
        <div class="flex items-center">
          <input
            id="low-stock"
            v-model="filters.low_stock"
            @change="loadStocks"
            type="checkbox"
            class="h-4 w-4 text-indigo-600 focus:ring-indigo-500 border-gray-300 rounded"
          />
          <label for="low-stock" class="ml-2 text-sm text-gray-700">
            Show only low stock items
          </label>
        </div>
      </div>
    </div>

    <!-- Current Stock Table -->
    <div class="bg-white rounded-lg shadow-md overflow-hidden">
      <div class="px-6 py-4 border-b border-gray-200">
        <h3 class="text-lg font-semibold text-gray-900">Current Stock Levels</h3>
      </div>

      <div v-if="loading" class="p-8 text-center">
        <p class="text-gray-600">Loading stock data...</p>
      </div>

      <table v-else class="min-w-full">
        <thead class="bg-gray-50">
          <tr>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Product</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">SKU</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Category</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Current Stock</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Min Stock</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Last Updated</th>
          </tr>
        </thead>
        <tbody class="bg-white divide-y divide-gray-200">
          <tr v-for="stock in stocks.data" :key="stock.id" class="hover:bg-gray-50">
            <td class="px-6 py-4 whitespace-nowrap">
              <div class="text-sm font-medium text-gray-900">{{ stock.product?.title || stock.product?.name }}</div>
              <div class="text-xs text-gray-500">{{ stock.product?.brand }}</div>
            </td>
            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
              {{ stock.product?.sku }}
            </td>
            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
              {{ stock.product?.category?.name || 'N/A' }}
            </td>
            <td class="px-6 py-4 whitespace-nowrap">
              <span class="text-lg font-bold" :class="stock.quantity <= 10 ? 'text-red-600' : 'text-green-600'">
                {{ stock.quantity }}
              </span>
            </td>
            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
              10
            </td>
            <td class="px-6 py-4 whitespace-nowrap">
              <span :class="[
                'px-2 py-1 text-xs rounded-full',
                stock.quantity <= 10
                  ? 'bg-red-100 text-red-800'
                  : stock.quantity <= 20
                    ? 'bg-yellow-100 text-yellow-800'
                    : 'bg-green-100 text-green-800'
              ]">
                {{ stock.quantity <= 10 ? 'Low Stock' : stock.quantity <= 20 ? 'Medium' : 'Good' }}
              </span>
            </td>
            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
              {{ new Date(stock.last_updated).toLocaleDateString() }}
            </td>
          </tr>
        </tbody>
      </table>

      <!-- Pagination -->
      <div v-if="stocks.data?.length" class="px-6 py-4 bg-gray-50 flex justify-between items-center">
        <p class="text-sm text-gray-700">
          Showing {{ stocks.from }} to {{ stocks.to }} of {{ stocks.total }} items
        </p>
        <div class="flex space-x-2">
          <button
            @click="loadStocks(stocks.current_page - 1)"
            :disabled="!stocks.prev_page_url"
            class="px-3 py-1 bg-white border border-gray-300 rounded hover:bg-gray-50 disabled:opacity-50"
          >
            Previous
          </button>
          <button
            @click="loadStocks(stocks.current_page + 1)"
            :disabled="!stocks.next_page_url"
            class="px-3 py-1 bg-white border border-gray-300 rounded hover:bg-gray-50 disabled:opacity-50"
          >
            Next
          </button>
        </div>
      </div>
    </div>

    <!-- Transaction Modal -->
    <div v-if="showTransactionModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
      <div class="bg-white rounded-lg p-6 w-full max-w-md">
        <h3 class="text-xl font-bold mb-4">Record Stock Transaction</h3>
        
        <form @submit.prevent="saveTransaction" class="space-y-4">
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Product *</label>
            <select
              v-model="transactionForm.product_id"
              required
              class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500"
            >
              <option value="">Select Product</option>
              <option v-for="stock in allStocks" :key="stock.product.id" :value="stock.product.id">
                {{ stock.product.title || stock.product.name }} (Current: {{ stock.quantity }})
              </option>
            </select>
          </div>

          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Transaction Type *</label>
            <select
              v-model="transactionForm.transaction_type"
              required
              class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500"
            >
              <option value="">Select Type</option>
              <option value="in">Stock In</option>
              <option value="out">Stock Out</option>
            </select>
          </div>

          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Quantity *</label>
            <input
              v-model="transactionForm.quantity"
              type="number"
              min="1"
              required
              class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500"
            />
          </div>

          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Notes</label>
            <textarea
              v-model="transactionForm.notes"
              rows="3"
              class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500"
            ></textarea>
          </div>

          <div v-if="error" class="bg-red-50 text-red-600 p-3 rounded-lg text-sm">
            {{ error }}
          </div>

          <div v-if="success" class="bg-green-50 text-green-600 p-3 rounded-lg text-sm">
            {{ success }}
          </div>

          <div class="flex justify-end space-x-3">
            <button
              type="button"
              @click="showTransactionModal = false"
              class="px-4 py-2 bg-gray-200 text-gray-700 rounded-lg hover:bg-gray-300"
            >
              Cancel
            </button>
            <button
              type="submit"
              :disabled="saving"
              class="px-4 py-2 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700 disabled:opacity-50"
            >
              {{ saving ? 'Saving...' : 'Save Transaction' }}
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import api from '../services/api';

const stocks = ref({ data: [] });
const allStocks = ref([]);
const loading = ref(true);
const showTransactionModal = ref(false);
const saving = ref(false);
const error = ref('');
const success = ref('');

const filters = ref({
  search: '',
  low_stock: false,
});

const transactionForm = ref({
  product_id: '',
  transaction_type: '',
  quantity: 1,
  notes: '',
});

const loadStocks = async (page = 1) => {
  loading.value = true;
  try {
    const params = { page, ...filters.value };
    const response = await api.get('/stock', { params });
    stocks.value = response.data;
  } catch (err) {
    console.error('Failed to load stocks:', err);
  } finally {
    loading.value = false;
  }
};

const loadAllStocks = async () => {
  try {
    const response = await api.get('/stock', { params: { per_page: 1000 } });
    allStocks.value = response.data.data;
  } catch (err) {
    console.error('Failed to load all stocks:', err);
  }
};

const saveTransaction = async () => {
  saving.value = true;
  error.value = '';
  success.value = '';
  
  try {
    await api.post('/stock/transaction', transactionForm.value);
    success.value = 'Transaction recorded successfully!';
    transactionForm.value = { product_id: '', transaction_type: '', quantity: 1, notes: '' };
    loadStocks();
    loadAllStocks();
    setTimeout(() => {
      showTransactionModal.value = false;
      success.value = '';
    }, 1500);
  } catch (err) {
    error.value = err.response?.data?.message || 'Failed to record transaction';
  } finally {
    saving.value = false;
  }
};

onMounted(() => {
  loadStocks();
  loadAllStocks();
});
</script>

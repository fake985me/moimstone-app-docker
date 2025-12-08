<template>
  <div class="space-y-6">
    <!-- Header with Search -->
    <div class="flex justify-between items-center">
      <h1 class="text-3xl font-bold text-gray-900">DASHBOARD</h1>
      <div class="flex items-center space-x-4">
        <div class="relative">
          <input type="text" placeholder="Search..."
            class="pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 w-64" />
          <svg class="absolute left-3 top-2.5 w-5 h-5 text-gray-400" fill="none" stroke="currentColor"
            viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
              d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"></path>
          </svg>
        </div>
      </div>
    </div>

    <!-- Top Selling Products Chart -->
    <div class="bg-white rounded-xl shadow-lg p-6">
      <div class="flex justify-between items-center mb-6">
        <h2 class="text-xl font-bold text-gray-900">Top Selling Products</h2>
        <div class="flex items-center space-x-4">
          <!-- Category Filter -->
          <select v-model="selectedCategory" @change="loadDashboardData"
            class="px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 bg-white">
            <option :value="null">All Categories</option>
            <option v-for="category in categories" :key="category.id" :value="category.id">
              {{ category.name }}
            </option>
          </select>

          <!-- Legend -->
          <div class="flex items-center space-x-2">
            <div class="w-3 h-3 rounded-full bg-purple-500"></div>
            <span class="text-sm text-gray-600">Units Sold</span>
          </div>
        </div>
      </div>


      <VueApexCharts v-if="stockChartOptions && stockChartSeries.length" type="bar" height="300"
        :options="stockChartOptions" :series="stockChartSeries" />
    </div>

    <!-- Stock Report Table and Stock Status -->
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
      <!-- Stock Report -->
      <div class="bg-white rounded-xl shadow-lg p-6">
        <h3 class="text-lg font-bold text-gray-900 mb-1">Stock Report</h3>
        <p class="text-sm text-gray-500 mb-4">Overall Inventory</p>

        <div class="space-y-3">
          <div v-for="(item, index) in stockReports" :key="index"
            class="flex justify-between items-center p-3 bg-gray-50 rounded-lg">
            <span class="text-sm font-medium text-gray-700">{{ item.code }}</span>
            <span class="text-sm font-bold text-gray-900">{{ item.value }}</span>
            <span class="text-sm text-gray-600">{{ item.unit }}</span>
            <span class="text-xs text-gray-500">{{ item.date }}</span>
          </div>
        </div>
      </div>

      <!-- Stock Status Cards -->
      <div class="bg-gradient-to-br from-cyan-500 to-blue-600 rounded-xl shadow-lg p-6 text-white">
        <h3 class="text-2xl font-bold mb-6">Stock Status</h3>

        <div class="grid grid-cols-2 gap-4">
          <!-- Stock Needed -->
          <div class="bg-white/20 backdrop-blur-sm rounded-xl p-4 text-center hover:bg-white/30 transition-all">
            <div class="w-12 h-12 bg-blue-500 rounded-full flex items-center justify-center mx-auto mb-2">
              <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                  d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
              </svg>
            </div>
            <p class="text-sm opacity-90 mb-1">Stock Needed</p>
            <p class="text-2xl font-bold">{{ stockStatus.needed }}</p>
          </div>

          <!-- Out of Stock -->
          <div class="bg-white/20 backdrop-blur-sm rounded-xl p-4 text-center hover:bg-white/30 transition-all">
            <div class="w-12 h-12 bg-red-500 rounded-full flex items-center justify-center mx-auto mb-2">
              <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                  d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z">
                </path>
              </svg>
            </div>
            <p class="text-sm opacity-90 mb-1">Out of Stock</p>
            <p class="text-2xl font-bold">{{ stockStatus.out }}</p>
          </div>

          <!-- Restock -->
          <div class="bg-white/20 backdrop-blur-sm rounded-xl p-4 text-center hover:bg-white/30 transition-all">
            <div class="w-12 h-12 bg-orange-500 rounded-full flex items-center justify-center mx-auto mb-2">
              <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                  d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15">
                </path>
              </svg>
            </div>
            <p class="text-sm opacity-90 mb-1">Restock</p>
            <p class="text-2xl font-bold">{{ stockStatus.restock }}</p>
          </div>

          <!-- Ready Stock -->
          <div class="bg-white/20 backdrop-blur-sm rounded-xl p-4 text-center hover:bg-white/30 transition-all">
            <div class="w-12 h-12 bg-green-500 rounded-full flex items-center justify-center mx-auto mb-2">
              <svg class="w-6 h-6 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
              </svg>
            </div>
            <p class="text-sm opacity-90 mb-1">Ready Stock</p>
            <p class="text-2xl font-bold">{{ stockStatus.ready }}</p>
          </div>
        </div>
      </div>
    </div>

    <!-- Quick Stats Row -->
    <div class="grid grid-cols-1 md:grid-cols-5 gap-6">
      <div class="bg-white rounded-xl shadow-lg p-6 border-l-4 border-blue-500">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm text-gray-600 mb-1">Total Products</p>
            <p class="text-3xl font-bold text-gray-900">{{ stats.totalProducts || 0 }}</p>
          </div>
          <div class="w-12 h-12 bg-blue-100 rounded-full flex items-center justify-center">
            <span class="text-2xl">📦</span>
          </div>
        </div>
      </div>

      <div class="bg-white rounded-xl shadow-lg p-6 border-l-4 border-green-500">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm text-gray-600 mb-1">Total Sales</p>
            <p class="text-3xl font-bold text-gray-900">{{ stats.totalSales || 0 }}</p>
          </div>
          <div class="w-12 h-12 bg-green-100 rounded-full flex items-center justify-center">
            <span class="text-2xl">💰</span>
          </div>
        </div>
      </div>

      <div class="bg-white rounded-xl shadow-lg p-6 border-l-4 border-orange-500">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm text-gray-600 mb-1">Pending Sales</p>
            <p class="text-3xl font-bold text-gray-900">{{ stats.pendingSales || 0 }}</p>
          </div>
          <div class="w-12 h-12 bg-orange-100 rounded-full flex items-center justify-center">
            <span class="text-2xl">📋</span>
          </div>
        </div>
      </div>

      <div class="bg-white rounded-xl shadow-lg p-6 border-l-4 border-purple-500">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm text-gray-600 mb-1">Purchases</p>
            <p class="text-3xl font-bold text-gray-900">{{ stats.totalPurchases || 0 }}</p>
          </div>
          <div class="w-12 h-12 bg-purple-100 rounded-full flex items-center justify-center">
            <span class="text-2xl">🛒</span>
          </div>
        </div>
      </div>

      <div class="bg-white rounded-xl shadow-lg p-6 border-l-4 border-yellow-500">
        <div class="flex items-center justify-between">
          <div>
            <p class="text-sm text-gray-600 mb-1">Low Stock</p>
            <p class="text-3xl font-bold text-gray-900">{{ stats.lowStockItems || 0 }}</p>
          </div>
          <div class="w-12 h-12 bg-yellow-100 rounded-full flex items-center justify-center">
            <span class="text-2xl">⚠️</span>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, computed } from 'vue';
import api from '../services/api';
import VueApexCharts from 'vue3-apexcharts';


const stats = ref({});
const stockChartOptions = ref(null);
const stockChartSeries = ref([]);
const stockReports = ref([]); // Will be loaded from API
const categories = ref([]);
const selectedCategory = ref(null); // null = all categories

const stockSummary = computed(() => ({
  ready: stockChartSeries.value[0]?.data?.reduce((a, b) => a + b, 0) || 0,
  out: stockChartSeries.value[1]?.data?.reduce((a, b) => a + b, 0) || 0,
}));

const stockStatus = ref({
  needed: 0,
  out: 0,
  restock: 0,
  ready: 0,
});

onMounted(async () => {
  console.log('Dashboard: Starting to load...');
  try {
    await loadCategories();
    await loadDashboardData();
    console.log('Dashboard: Loaded successfully');
    console.log('Stats:', stats.value);
    console.log('Stock Status:', stockStatus.value);
    console.log('Stock Reports:', stockReports.value);
  } catch (error) {
    console.error('Dashboard: Failed to load', error);
  }
});

const loadCategories = async () => {
  try {
    const response = await api.get('/categories');
    categories.value = response.data;
    console.log('Categories loaded:', categories.value.length);
  } catch (error) {
    console.error('Failed to load categories:', error);
  }
};

const loadDashboardData = async () => {
  try {
    // Load stats (includes pending sales now)
    const statsResponse = await api.get('/dashboard/stats');
    stats.value = statsResponse.data;

    // Load stock chart with category filter
    const params = selectedCategory.value
      ? { category_id: selectedCategory.value }
      : {};
    const stockResponse = await api.get('/dashboard/stock-chart', { params });

    stockChartOptions.value = {
      chart: {
        type: 'bar',
        toolbar: { show: false },
        height: 300,
      },
      plotOptions: {
        bar: {
          horizontal: false,
          columnWidth: '60%',
          borderRadius: 4,
        },
      },
      colors: ['#8B5CF6'], // Purple for sales data
      dataLabels: {
        enabled: false,
      },
      stroke: {
        show: true,
        width: 2,
        colors: ['transparent'],
      },
      xaxis: {
        categories: stockResponse.data.categories || [],
        labels: {
          style: {
            fontSize: '11px',
          },
        },
      },
      yaxis: {
        title: {
          text: 'Units Sold',
        },
      },
      fill: {
        opacity: 1,
      },
      tooltip: {
        y: {
          formatter: function (val) {
            return val + ' units';
          },
        },
      },
      legend: {
        show: false,
      },
    };

    // Use series data from API response
    stockChartSeries.value = stockResponse.data.series || [];

    // Load real stock status data
    await loadStockStatus();
    
    // Load real stock reports
    await loadStockReports();
  } catch (error) {
    console.error('Failed to load dashboard data:', error);
  }
};

const loadStockStatus = async () => {
  try {
    const response = await api.get('/stock');
    const stocks = response.data.data || [];
    
    // Calculate real stock status
    stockStatus.value = {
      ready: stocks.filter(s => s.quantity > 10).length,
      out: stocks.filter(s => s.quantity === 0).length,
      restock: stocks.filter(s => s.quantity > 0 && s.quantity <= 5).length,
      needed: stocks.filter(s => s.quantity > 5 && s.quantity <= 10).length,
    };
  } catch (error) {
    console.error('Failed to load stock status:', error);
  }
};

const loadStockReports = async () => {
  try {
    const response = await api.get('/stock');
    const stocks = response.data.data || [];
    
    // Create stock report from top 5 products by quantity
    stockReports.value = stocks
      .sort((a, b) => b.quantity - a.quantity)
      .slice(0, 5)
      .map(stock => ({
        code: stock.product?.sku || 'N/A',
        value: stock.quantity,
        unit: stock.product?.title || stock.product?.name || 'Unknown',
        date: new Date(stock.last_updated).toLocaleDateString()
      }));
  } catch (error) {
    console.error('Failed to load stock reports:', error);
  }
};
</script>

<template>
  <div class="min-h-screen bg-gradient-to-br from-gray-50 to-gray-100">
    <!-- Sidebar -->
    <div
      :class="[
        'fixed inset-y-0 left-0 bg-gradient-to-b from-indigo-900 to-indigo-800 text-white shadow-2xl flex flex-col transition-all duration-300',
        sidebarCollapsed ? 'w-20' : 'w-64'
      ]">
      <!-- Logo & Toggle Button -->
      <div class="flex items-center justify-center h-16 bg-indigo-950 border-b border-indigo-700 flex-shrink-0 relative">
        <h1 v-show="!sidebarCollapsed" class="text-xl font-bold tracking-wide">📦 MDI Stock Management</h1>
        <h1 v-show="sidebarCollapsed" class="text-2xl">📦</h1>
        
        <!-- Toggle Button -->
        <button 
          @click="toggleSidebar"
          class="absolute -right-3 top-1/2 transform -translate-y-1/2 bg-indigo-600 hover:bg-indigo-500 text-white rounded-full p-2 shadow-lg transition-all duration-200 hover:scale-110 z-50">
          <svg v-if="!sidebarCollapsed" class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 19l-7-7 7-7m8 14l-7-7 7-7" />
          </svg>
          <svg v-else class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 5l7 7-7 7M5 5l7 7-7 7" />
          </svg>
        </button>
      </div>

      <!-- Navigation - Scrollable -->
      <nav class="flex-1 overflow-y-auto mt-6 px-4 space-y-1 pb-6">
        <router-link to="/"
          :class="[
            'flex items-center rounded-lg hover:bg-indigo-800 transition-all duration-200',
            sidebarCollapsed ? 'px-2 py-3 justify-center' : 'px-4 py-3 hover:translate-x-1'
          ]"
          active-class="bg-gradient-to-r from-indigo-700 to-indigo-600 shadow-lg"
          :title="sidebarCollapsed ? 'Home' : ''">
          <span :class="sidebarCollapsed ? 'text-2xl' : 'mr-3 text-lg'">🏠</span>
          <span v-show="!sidebarCollapsed" class="font-medium">Home</span>
        </router-link>
        <router-link to="/dashboard"
          :class="[
            'flex items-center rounded-lg hover:bg-indigo-800 transition-all duration-200',
            sidebarCollapsed ? 'px-2 py-3 justify-center' : 'px-4 py-3 hover:translate-x-1'
          ]"
          active-class="bg-gradient-to-r from-indigo-700 to-indigo-600 shadow-lg"
          :title="sidebarCollapsed ? 'Dashboard' : ''">
          <span :class="sidebarCollapsed ? 'text-2xl' : 'mr-3 text-lg'">📊</span>
          <span v-show="!sidebarCollapsed" class="font-medium">Dashboard</span>
        </router-link>

        <router-link to="/dashboard/products"
          :class="[
            'flex items-center rounded-lg hover:bg-indigo-800 transition-all duration-200',
            sidebarCollapsed ? 'px-2 py-3 justify-center' : 'px-4 py-3 hover:translate-x-1'
          ]"
          active-class="bg-gradient-to-r from-indigo-700 to-indigo-600 shadow-lg"
          :title="sidebarCollapsed ? 'Products' : ''">
          <span :class="sidebarCollapsed ? 'text-2xl' : 'mr-3 text-lg'">📦</span>
          <span v-show="!sidebarCollapsed" class="font-medium">Products</span>
        </router-link>

        <router-link to="/dashboard/categories"
          :class="[
            'flex items-center rounded-lg hover:bg-indigo-800 transition-all duration-200',
            sidebarCollapsed ? 'px-2 py-3 justify-center' : 'px-4 py-3 hover:translate-x-1'
          ]"
          active-class="bg-gradient-to-r from-indigo-700 to-indigo-600 shadow-lg"
          :title="sidebarCollapsed ? 'Categories' : ''">
          <span :class="sidebarCollapsed ? 'text-2xl' : 'mr-3 text-lg'">📑</span>
          <span v-show="!sidebarCollapsed" class="font-medium">Categories</span>
        </router-link>

        <router-link to="/dashboard/stock"
          class="flex items-center px-4 py-3 rounded-lg hover:bg-indigo-800 transition-all duration-200 hover:translate-x-1"
          active-class="bg-gradient-to-r from-indigo-700 to-indigo-600 shadow-lg">
          <span class="mr-3 text-lg">📈</span>
          <span class="font-medium">Stock Management</span>
        </router-link>

        <router-link to="/dashboard/sales"
          class="flex items-center px-4 py-3 rounded-lg hover:bg-indigo-800 transition-all duration-200 hover:translate-x-1"
          active-class="bg-gradient-to-r from-indigo-700 to-indigo-600 shadow-lg">
          <span class="mr-3 text-lg">💰</span>
          <span class="font-medium">Sales</span>
        </router-link>

        <router-link to="/dashboard/purchases"
          class="flex items-center px-4 py-3 rounded-lg hover:bg-indigo-800 transition-all duration-200 hover:translate-x-1"
          active-class="bg-gradient-to-r from-indigo-700 to-indigo-600 shadow-lg">
          <span class="mr-3 text-lg">🛒</span>
          <span class="font-medium">Purchases</span>
        </router-link>

        <router-link to="/dashboard/warranties"
          class="flex items-center px-4 py-3 rounded-lg hover:bg-indigo-800 transition-all duration-200 hover:translate-x-1"
          active-class="bg-gradient-to-r from-indigo-700 to-indigo-600 shadow-lg">
          <span class="mr-3 text-lg">🛡️</span>
          <span class="font-medium">Warranties</span>
        </router-link>

        <router-link to="/dashboard/lendings"
          class="flex items-center px-4 py-3 rounded-lg hover:bg-indigo-800 transition-all duration-200 hover:translate-x-1"
          active-class="bg-gradient-to-r from-indigo-700 to-indigo-600 shadow-lg">
          <span class="mr-3 text-lg">🔄</span>
          <span class="font-medium">Lendings</span>
        </router-link>

        <router-link to="/dashboard/rmas"
          class="flex items-center px-4 py-3 rounded-lg hover:bg-indigo-800 transition-all duration-200 hover:translate-x-1"
          active-class="bg-gradient-to-r from-indigo-700 to-indigo-600 shadow-lg">
          <span class="mr-3 text-lg">↩️</span>
          <span class="font-medium">RMA Management</span>
        </router-link>

        <router-link to="/dashboard/deliveries"
          class="flex items-center px-4 py-3 rounded-lg hover:bg-indigo-800 transition-all duration-200 hover:translate-x-1"
          active-class="bg-gradient-to-r from-indigo-700 to-indigo-600 shadow-lg">
          <span class="mr-3 text-lg">🚚</span>
          <span class="font-medium">Deliveries</span>
        </router-link>

        <router-link to="/dashboard/history"
          class="flex items-center px-4 py-3 rounded-lg hover:bg-indigo-800 transition-all duration-200 hover:translate-x-1"
          active-class="bg-gradient-to-r from-indigo-700 to-indigo-600 shadow-lg">
          <span class="mr-3 text-lg">📜</span>
          <span class="font-medium">History</span>
        </router-link>

        <router-link to="/dashboard/sales-people"
          class="flex items-center px-4 py-3 rounded-lg hover:bg-indigo-800 transition-all duration-200 hover:translate-x-1"
          active-class="bg-gradient-to-r from-indigo-700 to-indigo-600 shadow-lg">
          <span class="mr-3 text-lg">👥</span>
          <span class="font-medium">Sales Team</span>
        </router-link>

        <!-- CMS Section -->
        <div class="pt-4 mt-4 border-t border-indigo-700">
          <p v-show="!sidebarCollapsed" class="px-4 text-xs font-semibold text-indigo-300 uppercase tracking-wider mb-2">Website Content</p>

          <router-link to="/dashboard/cms/solutions"
            class="flex items-center px-4 py-3 rounded-lg hover:bg-indigo-800 transition-all duration-200 hover:translate-x-1"
            active-class="bg-gradient-to-r from-indigo-700 to-indigo-600 shadow-lg">
            <span class="mr-3 text-lg">💡</span>
            <span class="font-medium">Solutions</span>
          </router-link>

          <router-link to="/dashboard/cms/projects"
            class="flex items-center px-4 py-3 rounded-lg hover:bg-indigo-800 transition-all duration-200 hover:translate-x-1"
            active-class="bg-gradient-to-r from-indigo-700 to-indigo-600 shadow-lg">
            <span class="mr-3 text-lg">🚀</span>
            <span class="font-medium">Projects</span>
          </router-link>

          <router-link to="/dashboard/cms/settings"
            class="flex items-center px-4 py-3 rounded-lg hover:bg-indigo-800 transition-all duration-200 hover:translate-x-1"
            active-class="bg-gradient-to-r from-indigo-700 to-indigo-600 shadow-lg">
            <span class="mr-3 text-lg">🎨</span>
            <span class="font-medium">Site Settings</span>
          </router-link>

          <router-link to="/dashboard/cms/contact"
            class="flex items-center px-4 py-3 rounded-lg hover:bg-indigo-800 transition-all duration-200 hover:translate-x-1"
            active-class="bg-gradient-to-r from-indigo-700 to-indigo-600 shadow-lg">
            <span class="mr-3 text-lg">📞</span>
            <span class="font-medium">Contact Info</span>
          </router-link>

          <router-link to="/dashboard/cms/carousel"
            class="flex items-center px-4 py-3 rounded-lg hover:bg-indigo-800 transition-all duration-200 hover:translate-x-1"
            active-class="bg-gradient-to-r from-indigo-700 to-indigo-600 shadow-lg">
            <span class="mr-3 text-lg">🎠</span>
            <span class="font-medium">Carousel</span>
          </router-link>

          <router-link to="/dashboard/cms/public-products"
            class="flex items-center px-4 py-3 rounded-lg hover:bg-indigo-800 transition-all duration-200 hover:translate-x-1"
            active-class="bg-gradient-to-r from-indigo-700 to-indigo-600 shadow-lg">
            <span class="mr-3 text-lg">📦</span>
            <span class="font-medium">Public Products</span>
          </router-link>

          <router-link to="/dashboard/pages"
            class="flex items-center px-4 py-3 rounded-lg hover:bg-indigo-800 transition-all duration-200 hover:translate-x-1"
            active-class="bg-gradient-to-r from-indigo-700 to-indigo-600 shadow-lg">
            <span class="mr-3 text-lg">📄</span>
            <span class="font-medium">Pages</span>
          </router-link>
        </div>

        <router-link v-if="authStore.isSuperAdmin" to="/dashboard/users"
          class="flex items-center px-4 py-3 rounded-lg hover:bg-indigo-800 transition-all duration-200 hover:translate-x-1 mt-4"
          active-class="bg-gradient-to-r from-indigo-700 to-indigo-600 shadow-lg">
          <span class="mr-3 text-lg">⚙️</span>
          <span class="font-medium">User Management</span>
        </router-link>
      </nav>
    </div>

    <!-- Main Content Area -->
    <div :class="['transition-all duration-300', sidebarCollapsed ? 'ml-20' : 'ml-64']">
      <!-- Top Bar -->
      <header class="bg-white shadow-md h-16 flex items-center justify-between px-6 border-b border-gray-200">
        <h2 class="text-2xl font-bold bg-gradient-to-r from-indigo-600 to-purple-600 bg-clip-text text-transparent">{{
          pageTitle }}</h2>
        <div class="flex items-center space-x-4">
          <div class="flex items-center space-x-3 px-4 py-2 bg-gray-50 rounded-lg">
            <div
              class="w-8 h-8 bg-gradient-to-r from-indigo-500 to-purple-500 rounded-full flex items-center justify-center text-white font-bold text-sm">
              {{ authStore.user?.name?.charAt(0).toUpperCase() }}
            </div>
            <div class="text-sm">
              <p class="font-semibold text-gray-800">{{ authStore.user?.name }}</p>
              <p class="text-xs text-gray-500 capitalize">{{ authStore.user?.role }}</p>
            </div>
          </div>
          <button @click="handleLogout"
            class="px-4 py-2 bg-gradient-to-r from-red-600 to-red-700 text-white rounded-lg hover:from-red-700 hover:to-red-800 transition-all duration-200 shadow-md hover:shadow-lg text-sm font-medium">
            Logout
          </button>
        </div>
      </header>

      <!-- Page Content -->
      <main class="p-6 min-h-screen">
        <div class="animate-fade-in">
          <router-view />
        </div>
      </main>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';
import { useRouter, useRoute } from 'vue-router';
import { useAuthStore } from '../stores/auth';

const router = useRouter();
const route = useRoute();
const authStore = useAuthStore();

// Sidebar collapse state
const sidebarCollapsed = ref(false);

// Load from localStorage
onMounted(() => {
  const saved = localStorage.getItem('sidebar-collapsed');
  if (saved !== null) {
    sidebarCollapsed.value = JSON.parse(saved);
  }
});

// Toggle function
const toggleSidebar = () => {
  sidebarCollapsed.value = !sidebarCollapsed.value;
  localStorage.setItem('sidebar-collapsed', JSON.stringify(sidebarCollapsed.value));
};

const pageTitle = computed(() => {
  const titles = {
    'Dashboard': 'Dashboard',
    'Products': 'Product Management',
    'Categories': 'Category Management',
    'Stock': 'Stock Management',
    'Sales': 'Sales Management',
    'Purchases': 'Purchase Management',
    'Warranties': 'Warranty Management',
    'Lendings': 'Lending Management',
    'Deliveries': 'Delivery Tracking',
    'History': 'Histori Transaksi',
    'SalesPeople': 'Sales Team',
    'CmsSolutions': 'Solutions Management',
    'CmsProjects': 'Projects Management',
    'CmsSettings': 'Site Settings',
    'CmsContact': 'Contact Information',
    'CmsCarousel': 'Carousel Management',
    'PublicProducts': 'Public Products Management',
    'Pages': 'Page Builder',
    'PageCreate': 'Create Page',
    'PageEdit': 'Edit Page',
    'Users': 'User Management',
  };
  return titles[route.name] || 'Dashboard';
});

const handleLogout = async () => {
  await authStore.logout();
  router.push('/login');
};
</script>

<template>
  <div class="min-h-screen bg-gradient-to-br from-gray-50 to-gray-100">
    <!-- Sidebar Component -->
    <Sidebar 
      :collapsed="sidebarCollapsed" 
      :is-super-admin="authStore.isSuperAdmin"
      @toggle="toggleSidebar" 
    />

    <!-- Main Content Area -->
    <div :class="['transition-all duration-300', sidebarCollapsed ? 'ml-20' : 'ml-64']">
      <!-- Top Bar -->
      <header class="bg-white shadow-md h-16 flex items-center justify-between px-6 border-b border-gray-200">
        <h2 class="text-2xl font-bold bg-gradient-to-r from-indigo-600 to-purple-600 bg-clip-text text-transparent">
          {{ pageTitle }}
        </h2>
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
import Sidebar from '../components/Sidebar.vue';

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
    'RMAs': 'RMA Management',
    'ProjectInvestments': 'Project Investment',
    'MSAProjects': 'MSA Project',
    'Assets': 'Asset Management',
    'Deliveries': 'Delivery Tracking',
    'History': 'Histori Transaksi',
    'SalesPeople': 'Sales Team',
    'ProjectPlanning': 'Project Planning',
    'Accounting': 'Accounting',
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

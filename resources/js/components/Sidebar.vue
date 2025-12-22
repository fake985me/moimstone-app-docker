<template>
  <div
    :class="[
      'fixed inset-y-0 left-0 bg-gradient-to-br from-gray-50 to-gray-100 text-gray-650 shadow-2xl flex flex-col transition-all duration-300',
      collapsed ? 'w-20' : 'w-64'
    ]">
    <!-- Logo & Toggle Button -->
    <div class="flex items-center justify-center h-16 bg-white shadow-md border-b border-gray-200 flex-shrink-0 relative">
      <h1 v-show="!collapsed" class="text-base tracking-wide">📦 MDI Stock Management</h1>
      <h1 v-show="collapsed" class="text-2xl">📦</h1>
      
      <!-- Toggle Button -->
      <button 
        @click="$emit('toggle')"
        class="absolute -right-3 top-1/2 transform -translate-y-1/2 bg-gray-500 hover:bg-gray-500 text-white rounded-full p-2 shadow-lg transition-all duration-200 hover:scale-110 z-50">
        <svg v-if="!collapsed" class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 19l-7-7 7-7m8 14l-7-7 7-7" />
        </svg>
        <svg v-else class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 5l7 7-7 7M5 5l7 7-7 7" />
        </svg>
      </button>
    </div>

    <!-- Navigation - Scrollable -->
    <nav class="flex-1 overflow-y-auto mt-6 px-4 space-y-1 pb-6">
      <!-- Main Menu -->
      <SidebarLink to="/" icon="🏠" label="Home" :collapsed="collapsed" />
      <SidebarLink to="/dashboard" icon="📊" label="Dashboard" :collapsed="collapsed" />
      <SidebarLink to="/dashboard/products" icon="📦" label="Products" :collapsed="collapsed" />
      <SidebarLink to="/dashboard/categories" icon="📑" label="Categories" :collapsed="collapsed" />
      <SidebarLink to="/dashboard/stock" icon="📈" label="Stock Management" :collapsed="collapsed" />
      <SidebarLink to="/dashboard/sales" icon="💰" label="Sales" :collapsed="collapsed" />
      <SidebarLink to="/dashboard/purchases" icon="🛒" label="Purchases" :collapsed="collapsed" />
      <SidebarLink to="/dashboard/warranties" icon="🛡️" label="Warranties" :collapsed="collapsed" />
      <SidebarLink to="/dashboard/lendings" icon="🔄" label="Lendings" :collapsed="collapsed" />
      <SidebarLink to="/dashboard/rmas" icon="↩️" label="RMA Management" :collapsed="collapsed" />
      <SidebarLink to="/dashboard/project-investments" icon="📊" label="Project Investment" :collapsed="collapsed" />
      <SidebarLink to="/dashboard/msa-projects" icon="🔧" label="MSA Project" :collapsed="collapsed" />
      <SidebarLink to="/dashboard/assets" icon="🏷️" label="Asset Management" :collapsed="collapsed" />
      <SidebarLink to="/dashboard/deliveries" icon="🚚" label="Deliveries" :collapsed="collapsed" />
      <SidebarLink to="/dashboard/history" icon="📜" label="History" :collapsed="collapsed" />
      <SidebarLink to="/dashboard/sales-people" icon="👥" label="Sales Team" :collapsed="collapsed" />

      <!-- Project & Accounting Section -->
      <SidebarSection title="Project & Finance" :collapsed="collapsed">
        <SidebarLink to="/dashboard/project-planning" icon="📋" label="Project Planning" :collapsed="collapsed" />
        <SidebarLink to="/dashboard/accounting" icon="💵" label="Accounting" :collapsed="collapsed" />
      </SidebarSection>

      <!-- CMS Section -->
      <SidebarSection title="Website Content" :collapsed="collapsed">
        <SidebarLink to="/dashboard/cms/solutions" icon="💡" label="Solutions" :collapsed="collapsed" />
        <SidebarLink to="/dashboard/cms/projects" icon="🚀" label="Projects" :collapsed="collapsed" />
        <SidebarLink to="/dashboard/cms/settings" icon="🎨" label="Site Settings" :collapsed="collapsed" />
        <SidebarLink to="/dashboard/cms/contact" icon="📞" label="Contact Info" :collapsed="collapsed" />
        <SidebarLink to="/dashboard/cms/carousel" icon="🎠" label="Carousel" :collapsed="collapsed" />
        <SidebarLink to="/dashboard/cms/public-products" icon="📦" label="Public Products" :collapsed="collapsed" />
        <SidebarLink to="/dashboard/pages" icon="📄" label="Pages" :collapsed="collapsed" />
      </SidebarSection>

      <!-- Admin Only -->
      <SidebarLink v-if="isSuperAdmin" to="/dashboard/users" icon="⚙️" label="User Management" :collapsed="collapsed" class="mt-4" />
    </nav>
  </div>
</template>

<script setup>
import SidebarLink from './SidebarLink.vue';
import SidebarSection from './SidebarSection.vue';

defineProps({
  collapsed: {
    type: Boolean,
    default: false
  },
  isSuperAdmin: {
    type: Boolean,
    default: false
  }
});

defineEmits(['toggle']);
</script>

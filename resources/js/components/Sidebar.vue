<template>
  <aside :class="[
    'sidebar',
    collapsed ? 'sidebar-collapsed' : 'sidebar-expanded'
  ]">
    <!-- Logo Header -->
    <div class="sidebar-header">
      <div class="logo-container">
        <h1 v-show="!collapsed" class="logo-text">
          <span class="logo-icon">📦</span>
          <span class="logo-name">MDI Stock</span>
        </h1>
        <span v-show="collapsed" class="logo-icon-collapsed">📦</span>
      </div>
      
      <!-- Toggle Button -->
      <button class="toggle-btn" @click="$emit('toggle')">
        <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
        </svg>
      </button>
    </div>

    <!-- Navigation Menu -->
    <nav class="sidebar-nav">
      <template v-for="section in filteredMenuSections" :key="section.title">
        <SidebarSection :title="section.title" :collapsed="collapsed">
          <SidebarMenuItem
            v-for="item in section.items"
            :key="item.name"
            :item="item"
            :collapsed="collapsed"
          />
        </SidebarSection>
      </template>
    </nav>
  </aside>
</template>

<script setup>
import { computed } from 'vue'
import SidebarSection from './SidebarSection.vue'
import SidebarMenuItem from './SidebarMenuItem.vue'

const props = defineProps({
  collapsed: Boolean,
  isSuperAdmin: Boolean,
  userRole: {
    type: String,
    default: 'admin'
  }
})

defineEmits(['toggle'])

const menuSections = [
  {
    title: 'MAIN NAVIGATION',
    items: [
      { name: 'Home', icon: 'home', to: '/', roles: ['admin', 'staff', 'viewer'] },
      { name: 'Dashboard', icon: 'dashboard', to: '/dashboard', roles: ['admin', 'staff', 'viewer'] },
      { name: 'Products', icon: 'products', to: '/dashboard/products', roles: ['admin', 'staff'] }
    ]
  },
  {
    title: 'INVENTORY',
    items: [
      {
        name: 'Stock Management',
        icon: 'stock',
        roles: ['admin', 'staff'],
        children: [
          { name: 'Stock Overview', to: '/dashboard/stock', roles: ['admin', 'staff'] },
          { name: 'Categories', to: '/dashboard/categories', roles: ['admin', 'staff'] }
        ]
      },
      {
        name: 'Transactions',
        icon: 'sales',
        roles: ['admin', 'staff'],
        children: [
          { name: 'Sales', to: '/dashboard/sales', roles: ['admin', 'staff'] },
          { name: 'Purchases', to: '/dashboard/purchases', roles: ['admin', 'staff'] }
        ]
      }
    ]
  },
  {
    title: 'SERVICES',
    items: [
      { name: 'Warranties', icon: 'forms', to: '/dashboard/warranties', roles: ['admin', 'staff'] },
      { name: 'Lendings', icon: 'components', to: '/dashboard/lendings', roles: ['admin', 'staff'] },
      { name: 'RMA Management', icon: 'elements', to: '/dashboard/rmas', roles: ['admin', 'staff'] }
    ]
  },
  {
    title: 'PROJECTS',
    items: [
      { name: 'Project Investment', icon: 'chart', to: '/dashboard/project-investments', roles: ['admin', 'staff'] },
      { name: 'MSA Project', icon: 'settings', to: '/dashboard/msa-projects', roles: ['admin', 'staff'] },
      { name: 'Asset Management', icon: 'table', to: '/dashboard/assets', roles: ['admin', 'staff'] }
    ]
  },
  {
    title: 'CMS',
    items: [
      {
        name: 'Website Content',
        icon: 'pages',
        roles: ['admin'],
        children: [
          { name: 'Solutions', to: '/dashboard/cms/solutions', roles: ['admin'] },
          { name: 'Projects', to: '/dashboard/cms/projects', roles: ['admin'] },
          { name: 'Site Settings', to: '/dashboard/cms/settings', roles: ['admin'] },
          { name: 'Contact Info', to: '/dashboard/cms/contact', roles: ['admin'] },
          { name: 'Carousel', to: '/dashboard/cms/carousel', roles: ['admin'] },
          { name: 'Public Products', to: '/dashboard/cms/public-products', roles: ['admin'] },
          { name: 'Pages', to: '/dashboard/pages', roles: ['admin'] }
        ]
      }
    ]
  },
  {
    title: 'ADMINISTRATION',
    items: [
      { name: 'User Management', icon: 'users', to: '/dashboard/users', roles: ['admin'], superAdminOnly: true }
    ]
  }
]

const filteredMenuSections = computed(() => {
  return menuSections
    .map(section => ({
      ...section,
      items: section.items.filter(item => {
        if (item.superAdminOnly && !props.isSuperAdmin) return false
        if (props.isSuperAdmin) return true
        return item.roles?.includes(props.userRole)
      })
    }))
    .filter(section => section.items.length > 0)
})
</script>

<style scoped>
.sidebar {
  position: fixed;
  top: 0;
  left: 0;
  bottom: 0;
  background: linear-gradient(180deg, #ffffff 0%, #f8fafc 100%);
  border-right: 1px solid #e5e7eb;
  display: flex;
  flex-direction: column;
  transition: width 0.3s ease;
  z-index: 50;
  overflow: hidden;
}

.sidebar-expanded {
  width: 260px;
}

.sidebar-collapsed {
  width: 70px;
}

.sidebar-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 1rem;
  border-bottom: 1px solid #e5e7eb;
  background: #ffffff;
  min-height: 64px;
}

.logo-container {
  display: flex;
  align-items: center;
  overflow: hidden;
}

.logo-text {
  display: flex;
  align-items: center;
  font-size: 1.125rem;
  font-weight: 700;
  color: #1f2937;
  white-space: nowrap;
}

.logo-icon {
  font-size: 1.5rem;
  margin-right: 0.5rem;
}

.logo-icon-collapsed {
  font-size: 1.75rem;
}

.logo-name {
  background: linear-gradient(135deg, #254692 0%, #03185c 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.toggle-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 36px;
  height: 36px;
  border-radius: 8px;
  background: #f3f4f6;
  border: none;
  color: #6b7280;
  cursor: pointer;
  transition: all 0.15s ease;
  flex-shrink: 0;
}

.toggle-btn:hover {
  background: #e5e7eb;
  color: #2f62a0;
}

.sidebar-nav {
  flex: 1;
  overflow-y: auto;
  overflow-x: hidden;
  padding: 0.5rem 0;
}

/* Custom scrollbar */
.sidebar-nav::-webkit-scrollbar {
  width: 4px;
}

.sidebar-nav::-webkit-scrollbar-track {
  background: transparent;
}

.sidebar-nav::-webkit-scrollbar-thumb {
  background: #d1d5db;
  border-radius: 4px;
}

.sidebar-nav::-webkit-scrollbar-thumb:hover {
  background: #9ca3af;
}
</style>

<template>
  <div class="menu-item-container">
    <!-- Menu Item Link or Button -->
    <component
      :is="item.to && !item.children ? 'router-link' : 'button'"
      :to="item.to && !item.children ? item.to : undefined"
      :class="[
        'menu-item',
        { 'active': isActive, 'has-children': item.children }
      ]"
      :style="{ paddingLeft: `${depth * 1}rem` }"
      @click="item.children ? toggleExpand() : null"
    >
      <!-- Icon -->
      <span v-if="item.icon && depth === 0" class="menu-icon">
        <component :is="getIcon(item.icon)" />
      </span>
      
      <!-- Label -->
      <span v-if="!collapsed" class="menu-label">{{ item.name }}</span>
      
      <!-- Chevron for expandable items -->
      <span v-if="item.children && !collapsed" class="menu-chevron">
        <svg 
          :class="['chevron-icon', { 'rotated': isExpanded }]"
          viewBox="0 0 24 24" 
          fill="none" 
          stroke="currentColor"
        >
          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
        </svg>
      </span>
    </component>

    <!-- Children Items -->
    <Transition name="expand">
      <div v-if="item.children && isExpanded && !collapsed" class="menu-children">
        <SidebarMenuItem
          v-for="child in item.children"
          :key="child.name"
          :item="child"
          :collapsed="collapsed"
          :depth="depth + 1"
        />
      </div>
    </Transition>
  </div>
</template>

<script setup>
import { ref, computed, h } from 'vue'
import { useRoute } from 'vue-router'

const props = defineProps({
  item: {
    type: Object,
    required: true
  },
  collapsed: {
    type: Boolean,
    default: false
  },
  depth: {
    type: Number,
    default: 0
  }
})

const route = useRoute()
const isExpanded = ref(false)

// Check if current route matches this item or any children
const isActive = computed(() => {
  if (props.item.to) {
    return route.path === props.item.to
  }
  if (props.item.children) {
    return hasActiveChild(props.item.children)
  }
  return false
})

const hasActiveChild = (children) => {
  return children.some(child => {
    if (child.to && route.path === child.to) return true
    if (child.children) return hasActiveChild(child.children)
    return false
  })
}

// Auto-expand if has active child
if (hasActiveChild(props.item.children || [])) {
  isExpanded.value = true
}

const toggleExpand = () => {
  isExpanded.value = !isExpanded.value
}

// Simple icon components
const getIcon = (iconName) => {
  const icons = {
    home: {
      render() {
        return h('svg', { class: 'w-5 h-5', viewBox: '0 0 24 24', fill: 'none', stroke: 'currentColor' }, [
          h('path', { 'stroke-linecap': 'round', 'stroke-linejoin': 'round', 'stroke-width': '0.8', d: 'M4 9.5.5 13H3v9h7v-6h4v6h7v-9h2.5L12 1.5l-4 4V3H4zM5 4h2v3.914l5-5L21.086 12H20v9h-5v-6H9v6H4v-9H2.914L5 9.914z' })
        ])
      }
    },
    dashboard: {
      render() {
        return h('svg', { class: 'w-5 h-5', viewBox: '0 0 316.863 316.863', fill: 'gray', stroke: 'currentColor' }, [
          h('path', { 'stroke-linecap': 'round', 'stroke-linejoin': 'round', 'stroke-width': '2.1', d: 'm192.868 26.708-.046 23.781-1.249-.598-45.698 26.722-.053 26.389-2.404-1.259-45.652 26.647.057 29.321-4.763-2.79-45.513 26.592v117.82l30.061 17.529 191.709-112.381-.305-186.777L238.63 0zM85.242 295.662v-91.867l23.659-13.822.13 91.8zm50.276-29.371V150.689l23.655-13.83.135 115.507zm48-28.075V98.689l23.653-13.879.138 139.48zm70.791-41.382-23.791 13.922V48.689l23.652-13.798z' })
        ])
      }
    },
    pages: {
      render() {
        return h('svg', { class: 'w-5 h-5', viewBox: '0 0 24 24', fill: 'none', stroke: 'currentColor' }, [
          h('path', { 'stroke-linecap': 'round', 'stroke-linejoin': 'round', 'stroke-width': '1.5', d: 'M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z' })
        ])
      }
    },
    elements: {
      render() {
        return h('svg', { class: 'w-5 h-5', viewBox: '0 0 24 24', fill: 'none', stroke: 'currentColor' }, [
          h('path', { 'stroke-linecap': 'round', 'stroke-linejoin': 'round', 'stroke-width': '1.5', d: 'M12 6V4m0 2a2 2 0 100 4m0-4a2 2 0 110 4m-6 8a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4m6 6v10m6-2a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4' })
        ])
      }
    },
    components: {
      render() {
        return h('svg', { class: 'w-5 h-5', viewBox: '0 0 24 24', fill: 'none', stroke: 'currentColor' }, [
          h('path', { 'stroke-linecap': 'round', 'stroke-linejoin': 'round', 'stroke-width': '1.5', d: 'M4 5a1 1 0 011-1h4a1 1 0 011 1v4a1 1 0 01-1 1H5a1 1 0 01-1-1V5zM14 5a1 1 0 011-1h4a1 1 0 011 1v4a1 1 0 01-1 1h-4a1 1 0 01-1-1V5zM4 15a1 1 0 011-1h4a1 1 0 011 1v4a1 1 0 01-1 1H5a1 1 0 01-1-1v-4zM14 15a1 1 0 011-1h4a1 1 0 011 1v4a1 1 0 01-1 1h-4a1 1 0 01-1-1v-4z' })
        ])
      }
    },
    table: {
      render() {
        return h('svg', { class: 'w-5 h-5', viewBox: '0 0 24 24', fill: 'none', stroke: 'currentColor' }, [
          h('path', { 'stroke-linecap': 'round', 'stroke-linejoin': 'round', 'stroke-width': '1.5', d: 'M3 10h18M3 14h18m-9-4v8m-7 0h14a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v8a2 2 0 002 2z' })
        ])
      }
    },
    chart: {
      render() {
        return h('svg', { class: 'w-5 h-5', viewBox: '0 0 24 24', fill: 'none', stroke: 'currentColor' }, [
          h('path', { 'stroke-linecap': 'round', 'stroke-linejoin': 'round', 'stroke-width': '1.5', d: 'M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z' })
        ])
      }
    },
    forms: {
      render() {
        return h('svg', { class: 'w-5 h-5', viewBox: '0 0 24 24', fill: 'none', stroke: 'currentColor' }, [
          h('path', { 'stroke-linecap': 'round', 'stroke-linejoin': 'round', 'stroke-width': '1.5', d: 'M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-3 7h3m-3 4h3m-6-4h.01M9 16h.01' })
        ])
      }
    },
    products: {
      render() {
        return h('svg', { class: 'w-5 h-5', viewBox: '0 0 24 24', fill: 'none', stroke: 'currentColor' }, [
          h('path', { 'stroke-linecap': 'round', 'stroke-linejoin': 'round', 'stroke-width': '1.5', d: 'M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4' })
        ])
      }
    },
    settings: {
      render() {
        return h('svg', { class: 'w-5 h-5', viewBox: '0 0 24 24', fill: 'none', stroke: 'currentColor' }, [
          h('path', { 'stroke-linecap': 'round', 'stroke-linejoin': 'round', 'stroke-width': '1.5', d: 'M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z' }),
          h('path', { 'stroke-linecap': 'round', 'stroke-linejoin': 'round', 'stroke-width': '1.5', d: 'M15 12a3 3 0 11-6 0 3 3 0 016 0z' })
        ])
      }
    },
    stock: {
      render() {
        return h('svg', { class: 'w-5 h-5', viewBox: '0 0 64 64', fill: 'none', stroke: 'currentColor' }, [
          h('path', { 'stroke-linecap': 'round', 'stroke-linejoin': 'round', 'stroke-width': '1.5', d: 'M55.873 21.78a9 9 0 0 0-1.774-1.227c-1.31-.693-2.82-.639-4.07.015V18.14a.5.5 0 0 0-.215-.41c-.045-.031-.098-.042-.149-.057l.004-.013-21-6.14a.5.5 0 0 0-.281 0l-21 6.14.003.013c-.05.015-.104.026-.149.057a.5.5 0 0 0-.214.41v25.043c0 1.032.649 1.972 1.615 2.339l19.709 7.467a.5.5 0 0 0 .353 0l4.772-1.808c.124.564.236.923.252.972a.5.5 0 0 0 .475.346h.032c.19-.013 4.665-.333 7.776-3.018l-.01-.012c.034-.03.073-.05.099-.09l1.314-1.964 5-1.894a2.51 2.51 0 0 0 1.613-2.338V37.53l6.602-9.868c1.252-1.871.927-4.4-.757-5.881Zm-27.345-9.259 19.403 5.674-8.966 3.29-17.968-6.762zm0 12.794-19.402-7.12L19.4 15.19l18.127 6.822zm-20.5 17.87V18.856l20 7.34v25.6l-19.03-7.21a1.51 1.51 0 0 1-.97-1.403m21 8.613V26.197l20-7.34v2.422a4.6 4.6 0 0 0-.694.798L33.788 43.82c-.024.036-.017.079-.031.118l-.024-.008c-.81 2.27-.69 4.64-.442 6.252zm5.417-6.724c1.863 1.902 3.942 3.307 6.203 4.186-2.256 1.58-5.05 2.07-6.076 2.2-.253-.99-.801-3.72-.127-6.386m7.036 3.434c-2.47-.861-4.649-2.324-6.643-4.458L47.206 25.56c2.84.317 5.017 1.782 6.636 4.468zm7.547-5.324c0 .62-.39 1.184-.967 1.403l-3.688 1.396 4.655-6.958zm6.77-16.077-1.35 2.018c-1.651-2.534-3.874-4.039-6.625-4.485l1.343-2.008c.984-1.472 2.947-2 4.466-1.195.558.295 1.09.663 1.58 1.095a3.51 3.51 0 0 1 .586 4.575' })
        ])
      }
    },
    sales: {
      render() {
        return h('svg', { class: 'w-5 h-5', viewBox: '0 0 24 24', fill: 'none', stroke: 'currentColor' }, [
          h('path', { 'stroke-linecap': 'round', 'stroke-linejoin': 'round', 'stroke-width': '1.5', d: 'M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z' })
        ])
      }
    },
    users: {
      render() {
        return h('svg', { class: 'w-5 h-5', viewBox: '0 0 24 24', fill: 'none', stroke: 'currentColor' }, [
          h('path', { 'stroke-linecap': 'round', 'stroke-linejoin': 'round', 'stroke-width': '1.5', d: 'M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z' })
        ])
      }
    }
  }
  return icons[iconName] || icons.dashboard
}
</script>

<style scoped>
.menu-item-container {
  width: 100%;
}

.menu-item {
  display: flex;
  align-items: center;
  width: 100%;
  padding: 0.6rem 1.25rem;
  color: #6b7280;
  font-size: 0.875rem;
  text-decoration: none;
  border-left: 3px solid transparent;
  transition: all 0.15s ease;
  background: transparent;
  border-top: none;
  border-right: none;
  border-bottom: none;
  cursor: pointer;
  text-align: left;
}

.menu-item:hover {
  color: #689ff1;
  background: rgba(48, 182, 100, 0.05);
}

.menu-item.active {
  color: #306ab6;
  background: rgba(48, 182, 100, 0.1);
  border-left-color: #0b324d;
  font-weight: 500;
}

.menu-icon {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 1.5rem;
  height: 1.5rem;
  margin-right: 0.75rem;
  flex-shrink: 0;
}

.menu-label {
  flex: 1;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.menu-chevron {
  display: flex;
  align-items: center;
  margin-left: auto;
}

.chevron-icon {
  width: 1rem;
  height: 1rem;
  transition: transform 0.2s ease;
}

.chevron-icon.rotated {
  transform: rotate(90deg);
}

.menu-children {
  overflow: hidden;
}

/* Expand/Collapse Animation */
.expand-enter-active,
.expand-leave-active {
  transition: all 0.2s ease;
}

.expand-enter-from,
.expand-leave-to {
  opacity: 0;
  transform: translateY(-10px);
}
</style>

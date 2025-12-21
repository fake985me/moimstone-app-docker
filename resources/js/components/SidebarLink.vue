<template>
  <router-link
    :to="to"
    :class="[
      'flex items-center rounded-lg hover:bg-indigo-800 transition-all duration-200',
      collapsed ? 'px-2 py-3 justify-center' : 'px-4 py-3 hover:translate-x-1'
    ]"
    active-class="bg-gradient-to-r from-indigo-700 to-indigo-600 shadow-lg"
    :title="collapsed ? label : ''">
    <span :class="collapsed ? 'text-2xl' : 'mr-3 text-lg'">{{ icon }}</span>
    <span v-show="!collapsed" class="font-medium">{{ label }}</span>
  </router-link>
</template>

<script setup>
defineProps({
  to: {
    type: String,
    required: true
  },
  icon: {
    type: String,
    required: true
  },
  label: {
    type: String,
    required: true
  },
  collapsed: {
    type: Boolean,
    default: false
  }
});
</script>

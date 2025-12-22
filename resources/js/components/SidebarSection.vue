<template>
  <div class="pt-4 mt-4 border-t border-gray-700">
    <p v-show="!collapsed" class="px-4 text-xs font-semibold text-indigo-300 uppercase tracking-wider mb-2">
      {{ title }}
    </p>
    <slot />
  </div>
</template>

<script setup>
defineProps({
  title: {
    type: String,
    required: true
  },
  collapsed: {
    type: Boolean,
    default: false
  }
});
</script>

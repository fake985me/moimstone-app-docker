<template>
  <router-link
    :to="to"
    custom
    v-slot="{ navigate, href, isExactActive }"
  >
    <a
      :href="href"
      @click="navigate"
      :class="[
        baseClass,
        collapsed ? collapsedClass : expandedClass,
        isActive(isExactActive) ? activeClass : inactiveClass
      ]"
      :title="collapsed ? label : ''"
    >
      <span :class="collapsed ? 'text-2xl' : 'mr-3 text-lg'">
        {{ icon }}
      </span>
      <span v-show="!collapsed" class="font-medium">
        {{ label }}
      </span>
    </a>
  </router-link>
</template>

<script setup>
import { useRoute } from 'vue-router'

const props = defineProps({
  to: String,
  icon: String,
  label: String,
  collapsed: Boolean
})

const route = useRoute()

const isActive = (isExactActive) => {
  if (props.to === '/') {
    return isExactActive
  }
  return route.path === props.to || route.path.startsWith(props.to + '/')
}

const baseClass =
  'flex items-center rounded-lg transition-all duration-200 relative'

const collapsedClass = 'px-2 py-3 justify-center'
const expandedClass = 'px-4 py-3 hover:translate-x-1'

const activeClass =
  'bg-gradient-to-r from-gray-700 to-gray-800 text-white shadow-lg'

const inactiveClass =
  'text-gray-300 hover:bg-gray-800'
</script>

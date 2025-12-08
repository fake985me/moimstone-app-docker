<template>
  <!-- Mobile Top Nav - Logo Only -->
  <div class="md:hidden sticky top-0 z-40 bg-gray-800 px-4 py-2 flex items-center h-14">
    <RouterLink to="/">
      <svg xmlns="http://www.w3.org/2000/svg" fill="none" aria-hidden="true" class="w-12 h-10" width="60" height="56"
        viewBox="0 0.15 2 2">
        <path fill="#3636e0"
          d="M.892 1.548H.678v-.296q0-.034-.008-.047t-.027-.013q-.036 0-.036.061v.296H.394v-.296q0-.034-.008-.047t-.027-.014q-.036 0-.036.061v.296H.11V1.21q0-.092.064-.157T.331.988q.095 0 .17.077Q.585.988.669.988q.107 0 .172.075.051.058.051.17zM1.374.8h.214v.458q0 .126-.069.205-.04.046-.1.073t-.125.027q-.128 0-.215-.083t-.088-.202q0-.116.087-.201t.206-.085l.057.003v.227q-.026-.02-.053-.020-.033 0-.057.023t-.024.056q0 .032.024.055t.059.023q.082 0 .082-.11zm.578.199v.549h-.214V.999zM1.926.786q-.032-.03-.075-.03t-.075.03-.032.07q0 .014.003.026l.006.016q.007.016.021.028.03.028.077.028c.047 0 .057-.009.077-.028q.014-.013.021-.029l.002-.005q.006-.017.006-.037 0-.04-.032-.07m.065.016Q1.973.754 1.928.729T1.834.717q-.046.011-.068.048L1.763.77l-.001.002q.02-.036.066-.045.048-.01.092.014t.064.069q.017.042.001.077.021-.04.004-.087m.043-.02Q2.011.722 1.955.692c-.056-.03-.076-.025-.116-.015q-.056.014-.083.058l-.004.006-.001.002Q1.775.7 1.832.689q.058-.012.114.018t.078.085q.021.051.002.094.025-.049.004-.106" />
      </svg>
    </RouterLink>
  </div>


  <!-- Desktop Navbar -->
  <Disclosure as="nav" class="bg-gray-800 hidden md:block sticky top-0 z-50" v-slot="{ open }">
    <div class="mx-2 max-w-7xl px-4 sm:px-6 lg:px-8">
      <div class="flex h-16 items-center justify-between">
        <div class="flex items-center">
          <div class="ml-2 drop-shadow-xl">
            <RouterLink to="/">
              <svg xmlns="http://www.w3.org/2000/svg" fill="none" aria-hidden="true" class="w-12 h-10" width="60"
                height="56" viewBox="0 0.15 2 2">
                <path fill="#3636e0"
                  d="M.892 1.548H.678v-.296q0-.034-.008-.047t-.027-.013q-.036 0-.036.061v.296H.394v-.296q0-.034-.008-.047t-.027-.014q-.036 0-.036.061v.296H.11V1.21q0-.092.064-.157T.331.988q.095 0 .17.077Q.585.988.669.988q.107 0 .172.075.051.058.051.17zM1.374.8h.214v.458q0 .126-.069.205-.04.046-.1.073t-.125.027q-.128 0-.215-.083t-.088-.202q0-.116.087-.201t.206-.085l.057.003v.227q-.026-.020-.053-.020-.033 0-.057.023t-.024.056q0 .032.024.055t.059.023q.082 0 .082-.11zm.578.199v.549h-.214V.999zM1.926.786q-.032-.030-.075-.030t-.075.030-.032.07q0 .014.003.026l.006.016q.007.016.021.028.030.028.077.028c.047 0 .057-.009.077-.028q.014-.013.021-.029l.002-.005q.006-.017.006-.037 0-.040-.032-.07m.065.016Q1.973.754 1.928.729T1.834.717q-.046.011-.068.048L1.763.77l-.001.002q.020-.036.066-.045.048-.010.092.014t.064.069q.017.042.001.077.021-.040.004-.087m.043-.020Q2.011.722 1.955.692c-.056-.030-.076-.025-.116-.015q-.056.014-.083.058l-.004.006-.001.002Q1.775.7 1.832.689q.058-.012.114.018t.078.085q.021.051.002.094.025-.049.004-.106" />
              </svg>
            </RouterLink>
          </div>
          <div class="ml-10 flex items-baseline space-x-4">
            <template v-for="item in navigation">
              <RouterLink v-if="!item.children" :key="item.name" :to="item.href" :class="[
                isCurrent(item)
                  ? 'text-blue-600'
                  : 'text-white hover:bg-gray-700 hover:text-white',
                'rounded-md px-3 py-2 text-md font-medium'
              ]">{{ item.name }}</RouterLink>

              <Menu as="div" class="relative" v-else>
                <MenuButton @click="dropdownOpen = item.name" :class="[
                  isCurrent(item) || isAnyChildActive(item.children)
                    ? 'text-blue-600'
                    : 'text-white hover:bg-gray-700 hover:text-white',
                  'rounded-md px-3 py-2 text-md font-medium flex items-center gap-1'
                ]">
                  {{ item.name }}
                  <ChevronDownIcon class="h-2.5 w-2.5 shrink-0"
                    style="width: 10px !important; height: 10px !important; min-width: 10px; min-height: 10px; max-width: 10px; max-height: 10px;" />
                </MenuButton>
                <Transition enter="transition duration-100 ease-out" enter-from="transform scale-95 opacity-0"
                  enter-to="transform scale-100 opacity-100" leave="transition duration-75 ease-in"
                  leave-from="transform scale-100 opacity-100" leave-to="transform scale-95 opacity-0">
                  <MenuItems v-show="dropdownOpen === item.name"
                    class="absolute z-10 mt-2 w-56 origin-top-right rounded-md bg-white shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none">
                    <template v-for="child in item.children" :key="child.name">
                      <MenuItem v-if="!child.children" v-slot="{ active }">
                      <RouterLink :to="child.href" @click="resetDropdown" :class="[
                        active ? 'bg-gray-100 text-gray-900' : 'text-gray-700',
                        'block px-4 py-2 text-sm'
                      ]">{{ child.name }}</RouterLink>
                      </MenuItem>
                      <Menu v-else as="div" class="relative">
                        <MenuButton class="w-full text-left px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">
                          {{ child.name }}
                          <ChevronDownIcon class="h-2.5 w-2.5 shrink-0 inline-block float-right"
                            style="width: 10px !important; height: 10px !important; min-width: 10px; min-height: 10px; max-width: 10px; max-height: 10px;" />
                        </MenuButton>
                        <Transition enter="transition duration-100 ease-out" enter-from="transform scale-95 opacity-0"
                          enter-to="transform scale-100 opacity-100" leave="transition duration-75 ease-in"
                          leave-from="transform scale-100 opacity-100" leave-to="transform scale-95 opacity-0">
                          <MenuItems v-show="dropdownOpen === item.name"
                            class="absolute z-20 mt-1 ml-2 w-56 rounded-md bg-white shadow-lg ring-1 ring-black ring-opacity-5">
                            <MenuItem v-for="sub in child.children" :key="sub.name" v-slot="{ active }">
                            <RouterLink :to="sub.href" @click="resetDropdown" :class="[
                              active ? 'bg-gray-100 text-gray-900' : 'text-gray-700',
                              'block px-4 py-2 text-sm'
                            ]">
                              {{ sub.name }}
                            </RouterLink>
                            </MenuItem>
                          </MenuItems>
                        </Transition>
                      </Menu>
                    </template>
                  </MenuItems>
                </Transition>
              </Menu>
            </template>
          </div>
        </div>
      </div>
    </div>
  </Disclosure>

  <!-- Mobile Bottom Nav -->
  <nav class="md:hidden fixed bottom-0 left-0 right-0 bg-gray-800 z-50 shadow-md">
    <div class="flex justify-around items-center h-14">
      <template v-for="item in navigation">
        <RouterLink v-if="!item.children" :key="item.name" :to="item.href" :class="[
          isCurrent(item)
            ? 'text-white'
            : 'text-gray-400 hover:text-white',
          'flex flex-col items-center text-sm'
        ]">
          <span>{{ item.name }}</span>
        </RouterLink>

        <Menu as="div" class="relative" v-else>
          <MenuButton @click="dropdownOpen = item.name" :class="[
            isAnyChildActive(item.children)
              ? 'text-white'
              : 'text-gray-400 hover:text-white',
            'flex flex-col items-center text-sm'
          ]">
            <span>{{ item.name }}</span>
            <ChevronDownIcon class="h-2.5 w-2.5 shrink-0"
              style="width: 10px !important; height: 10px !important; min-width: 10px; min-height: 10px; max-width: 10px; max-height: 10px;" />
          </MenuButton>
          <Transition enter="transition duration-100 ease-out" enter-from="transform scale-95 opacity-0"
            enter-to="transform scale-100 opacity-100" leave="transition duration-75 ease-in"
            leave-from="transform scale-100 opacity-100" leave-to="transform scale-95 opacity-0">
            <MenuItems v-show="dropdownOpen === item.name"
              class="absolute bottom-16 z-10 w-48 origin-bottom rounded-md bg-white shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none">
              <template v-for="child in item.children" :key="child.name">
                <MenuItem v-if="!child.children" v-slot="{ active }">
                <RouterLink :to="child.href" @click="resetDropdown" :class="[
                  active ? 'bg-gray-100 text-gray-900' : 'text-gray-700',
                  'block px-4 py-2 text-sm'
                ]">
                  {{ child.name }}
                </RouterLink>
                </MenuItem>
                <Menu v-else as="div" class="relative">
                  <MenuButton class="w-full text-left px-4 py-2 text-sm text-gray-700 hover:bg-gray-100">
                    {{ child.name }}
                    <ChevronDownIcon class="h-2.5 w-2.5 shrink-0 inline-block float-right"
                      style="width: 10px !important; height: 10px !important; min-width: 10px; min-height: 10px; max-width: 10px; max-height: 10px;" />
                  </MenuButton>
                  <Transition enter="transition duration-100 ease-out" enter-from="transform scale-95 opacity-0"
                    enter-to="transform scale-100 opacity-100" leave="transition duration-75 ease-in"
                    leave-from="transform scale-100 opacity-100" leave-to="transform scale-95 opacity-0">
                    <MenuItems v-show="dropdownOpen === item.name"
                      class="absolute bottom-16 z-20 w-48 rounded-md bg-white shadow-lg ring-1 ring-black ring-opacity-5">
                      <MenuItem v-for="sub in child.children" :key="sub.name" v-slot="{ active }">
                      <RouterLink :to="sub.href" @click="resetDropdown" :class="[
                        active ? 'bg-gray-100 text-gray-900' : 'text-gray-700',
                        'block px-4 py-2 text-sm'
                      ]">
                        {{ sub.name }}
                      </RouterLink>
                      </MenuItem>
                    </MenuItems>
                  </Transition>
                </Menu>
              </template>
            </MenuItems>
          </Transition>
        </Menu>
      </template>
    </div>
  </nav>
</template>

<script setup>
import { ref, watch, onMounted, nextTick } from 'vue'
import { useRoute } from 'vue-router'
import { Disclosure } from '@headlessui/vue'
import { Menu, MenuButton, MenuItems, MenuItem } from '@headlessui/vue'
import { ChevronDownIcon } from '@heroicons/vue/20/solid'

const route = useRoute()
const dropdownOpen = ref(null)
const navigation = ref([
  { name: 'Home', href: '/' },
  {
    name: 'Product',
    href: '/product',
    children: [
      {
        name: 'XGSPON', href: '/product?category=XGSPON', children: [
          { name: 'OLT', href: '/product?category=XGSPON&sub=OLT' },
          { name: 'ONT', href: '/product?category=XGSPON&sub=ONT' },
          { name: 'ONU', href: '/product?category=XGSPON&sub=ONU' },
          { name: 'ONU PoE', href: '/product?category=XGSPON&sub=ONU+PoE' },
          { name: 'XGSPON Stick', href: '/product?category=XGSPON&sub=STICK' },
        ]
      },
      {
        name: 'GPON', href: '/product?category=GPON',
        children: [
          { name: 'OLT', href: '/product?category=GPON&sub=GPON+OLT' },
          { name: 'ONT', href: '/product?category=GPON&sub=ONT' },
          { name: 'ONU', href: '/product?category=GPON&sub=ONU' },
          { name: 'ONU PoE', href: '/product?category=GPON&sub=ONU+PoE' },
          { name: 'GPON Stick', href: '/product?category=GPON&sub=GPON+STICK' },
        ],
      },
      {
        name: 'SWITCH', href: '/product?category=Switch',
        children: [
          { name: 'Core Switch', href: '/product?category=SWITCH&sub=BACKBONE+SWITCH' },
          { name: 'L3 Switch', href: '/product?category=SWITCH&sub=L3+SWITCH' },
          { name: 'L2 Switch', href: '/product?category=SWITCH&sub=L2+SWITCH' },
          { name: 'PoE Switch', href: '/product?category=SWITCH&sub=PoE+SWITCH' },
        ],
      },
      {
        name: 'WIFI', href: '/product?category=WIRELESS',
        children: [
          { name: 'Access Point Indoor', href: '/product?category=WIRELESS&sub=Access+Point+Indoor' },
          { name: 'Access Point Outdoor', href: '/product?category=WIRELESS&sub=Access+Point+Outdoor' },
          { name: 'Controller', href: '/product?category=WIRELESS&sub=AP+Controller' },
        ],
      },
    ]
  },
  { name: 'Service & Solutions', href: '/solutions' },
  {
    name: 'Projects', href: '/projects',
    children: [
      { name: 'ISP Customer', href: '/projects?id=ispcustomer' },
      { name: 'Managed Services', href: '/projects?id=managedservices' },
      { name: 'FTTX Project', href: '/projects?id=fttxproject' },
    ]
  },
  {
    name: 'Contact',
    href: '/contact',
  },
])

const isCurrent = (item) => {
  if (!item.href) return false
  const [path, queryString] = item.href.split('?')
  if (route.path !== path) return false
  if (!queryString) return true

  const params = new URLSearchParams(queryString)
  for (const [key, value] of params) {
    if (route.query[key]?.toLowerCase() !== value.toLowerCase()) return false
  }
  return true
}

const isAnyChildActive = (children = []) => {
  return children.some(child => isCurrent(child) || isAnyChildActive(child.children))
}

const resetDropdown = () => {
  dropdownOpen.value = null
  document.activeElement?.blur()
  const openMenus = document.querySelectorAll('[data-headlessui-state="open"]')
  openMenus.forEach(menu => menu.dispatchEvent(new Event('blur')))
}

watch(() => route.fullPath, () => {
  resetDropdown()
})

function scrollToSection(id) {
  nextTick(() => {
    const el = document.getElementById(id)
    if (el) {
      el.scrollIntoView({ behavior: 'smooth' })
    }
  })
}

onMounted(() => {
  if (route.query.id) {
    scrollToSection(route.query.id)
  }
})

watch(() => route.query.id, (newId) => {
  if (newId) {
    scrollToSection(newId)
  }
})
</script>

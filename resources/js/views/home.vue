<script setup>
import Carousel from '../components/Carousel.vue'
import ProductView from '@/components/partial/ProductView.vue'
import SolutionsView from '@/components/partial/SolutionsView.vue'
import ProjectView from '@/components/partial/ProjectView.vue'
import AboutUs from '@/components/partial/AboutUs.vue'
import FirmwareModification from '@/components/partial/Firmware Modification.vue'
</script>

<template>
  <div>
    <main class="min-h-screen">
      <Carousel />
      <ProductView />
      <FirmwareModification/>
      <SolutionsView />
      <AboutUs />
      <ProjectView />
    </main>
  </div>
</template>

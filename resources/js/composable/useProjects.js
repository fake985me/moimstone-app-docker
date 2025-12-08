import { ref, onMounted } from 'vue'
import axios from 'axios'

export default function useProjects() {
  const projects = ref([])
  const loading = ref(false)
  const error = ref(null)

  const fetchProjects = async (category = null) => {
    loading.value = true
    error.value = null
    
    try {
      const params = category ? { category } : {}
      const response = await axios.get('/api/guest/projects', { params })
      projects.value = response.data
    } catch (err) {
      console.error('Failed to fetch projects:', err)
      error.value = err.message
      projects.value = []
    } finally {
      loading.value = false
    }
  }

  // Auto-fetch on mount
  onMounted(() => {
    fetchProjects()
  })

  return {
    projects,
    loading,
    error,
    fetchProjects
  }
}

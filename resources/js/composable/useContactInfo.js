import { ref, onMounted } from 'vue'
import axios from 'axios'

export default function useContactInfo() {
  const contacts = ref([])
  const loading = ref(false)
  const error = ref(null)

  const fetchContacts = async (type = null) => {
    loading.value = true
    error.value = null
    
    try {
      const params = type ? { type } : {}
      const response = await axios.get('/api/guest/contact-info', { params })
      contacts.value = response.data
    } catch (err) {
      console.error('Failed to fetch contact info:', err)
      error.value = err.message
      contacts.value = []
    } finally {
      loading.value = false
    }
  }

  const getByType = (type) => {
    return contacts.value.filter(c => c.type === type)
  }

  // Auto-fetch on mount
  onMounted(() => {
    fetchContacts()
  })

  return {
    contacts,
    loading,
    error,
    fetchContacts,
    getByType
  }
}

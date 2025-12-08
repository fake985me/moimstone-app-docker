<template>
  <div class="space-y-6">
    <!-- Header -->
    <div class="flex justify-between items-center">
      <h2 class="text-2xl font-bold text-gray-900">Category Management</h2>
      <button
        @click="showModal = true; editingCategory = null"
        class="px-4 py-2 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700 transition-colors"
      >
        + Add Category
      </button>
    </div>

    <!-- Categories Table -->
    <div class="bg-white rounded-lg shadow-md overflow-hidden">
      <div v-if="loading" class="p-8 text-center">
        <p class="text-gray-600">Loading categories...</p>
      </div>

      <table v-else class="min-w-full">
        <thead class="bg-gray-50">
          <tr>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Name</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Description</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Parent Category</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Products</th>
            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Subcategories</th>
            <th class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
          </tr>
        </thead>
        <tbody class="bg-white divide-y divide-gray-200">
          <tr v-for="category in categories" :key="category.id" class="hover:bg-gray-50">
            <td class="px-6 py-4 whitespace-nowrap">
              <div class="text-sm font-medium text-gray-900">{{ category.name }}</div>
            </td>
            <td class="px-6 py-4">
              <div class="text-sm text-gray-500">{{ category.description }}</div>
            </td>
            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
              {{ category.parent?.name || '-' }}
            </td>
            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
              {{ category.products?.length || 0 }}
            </td>
            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-900">
              {{ category.subcategories?.length || 0 }}
            </td>
            <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium space-x-2">
              <button
                @click="editCategory(category)"
                class="text-indigo-600 hover:text-indigo-900"
              >
                Edit
              </button>
              <button
                @click="deleteCategory(category.id)"
                class="text-red-600 hover:text-red-900"
              >
                Delete
              </button>
            </td>
          </tr>
        </tbody>
      </table>
    </div>

    <!-- Modal -->
    <div v-if="showModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
      <div class="bg-white rounded-lg p-6 w-full max-w-md">
        <h3 class="text-xl font-bold mb-4">{{ editingCategory ? 'Edit Category' : 'Add New Category' }}</h3>
        
        <form @submit.prevent="saveCategory" class="space-y-4">
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Category Name *</label>
            <input
              v-model="form.name"
              required
              class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500"
            />
          </div>

          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Description</label>
            <textarea
              v-model="form.description"
              rows="3"
              class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500"
            ></textarea>
          </div>

          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Parent Category</label>
            <select
              v-model="form.parent_id"
              class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500"
            >
              <option value="">None (Main Category)</option>
              <option
                v-for="category in availableParents"
                :key="category.id"
                :value="category.id"
              >
                {{ category.name }}
              </option>
            </select>
          </div>

          <div v-if="error" class="bg-red-50 text-red-600 p-3 rounded-lg text-sm">
            {{ error }}
          </div>

          <div class="flex justify-end space-x-3">
            <button
              type="button"
              @click="showModal = false"
              class="px-4 py-2 bg-gray-200 text-gray-700 rounded-lg hover:bg-gray-300"
            >
              Cancel
            </button>
            <button
              type="submit"
              :disabled="saving"
              class="px-4 py-2 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700 disabled:opacity-50"
            >
              {{ saving ? 'Saving...' : 'Save' }}
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';
import api from '../services/api';

const categories = ref([]);
const loading = ref(true);
const showModal = ref(false);
const editingCategory = ref(null);
const saving = ref(false);
const error = ref('');

const form = ref({
  name: '',
  description: '',
  parent_id: '',
});

const availableParents = computed(() => {
  return categories.value.filter(c => c.id !== editingCategory.value?.id && !c.parent_id);
});

const loadCategories = async () => {
  loading.value = true;
  try {
    const response = await api.get('/categories');
    categories.value = response.data;
  } catch (err) {
    console.error('Failed to load categories:', err);
  } finally {
    loading.value = false;
  }
};

const editCategory = (category) => {
  editingCategory.value = category;
  form.value = {
    name: category.name,
    description: category.description,
    parent_id: category.parent_id || '',
  };
  showModal.value = true;
};

const saveCategory = async () => {
  saving.value = true;
  error.value = '';
  
  try {
    if (editingCategory.value) {
      await api.put(`/categories/${editingCategory.value.id}`, form.value);
    } else {
      await api.post('/categories', form.value);
    }
    showModal.value = false;
    loadCategories();
    form.value = { name: '', description: '', parent_id: '' };
  } catch (err) {
    error.value = err.response?.data?.message || 'Failed to save category';
  } finally {
    saving.value = false;
  }
};

const deleteCategory = async (id) => {
  if (!confirm('Are you sure you want to delete this category?')) return;
  
  try {
    await api.delete(`/categories/${id}`);
    loadCategories();
  } catch (err) {
    alert(err.response?.data?.message || 'Failed to delete category');
  }
};

onMounted(() => {
  loadCategories();
});
</script>

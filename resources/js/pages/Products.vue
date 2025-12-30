<template>
    <div class="space-y-6">
        <!-- Header -->
        <div class="flex justify-between items-center">
            <h2 class="text-2xl font-bold text-gray-900">Product Management</h2>
            <div class="flex gap-3">
                <!-- Excel Buttons -->
                <button @click="downloadExcel"
                    class="px-4 py-2 bg-green-600 text-white rounded-lg hover:bg-green-700 flex items-center gap-2">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                            d="M12 10v6m0 0l-3-3m3 3l3-3m2 8H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                    </svg>
                    Download Excel
                </button>
                <button @click="downloadTemplate"
                    class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 flex items-center gap-2">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                            d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                    </svg>
                    Template
                </button>
                <label
                    class="px-4 py-2 bg-yellow-600 text-white rounded-lg hover:bg-yellow-700 cursor-pointer flex items-center gap-2">
                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                            d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12" />
                    </svg>
                    Upload Excel
                    <input type="file" @change="uploadExcel" accept=".xlsx,.xls,.csv" class="hidden" ref="fileInput" />
                </label>
                <button @click="showModal = true; editingProduct = null; resetForm()"
                    class="px-4 py-2 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700">
                    + Add Product
                </button>
            </div>
        </div>

        <!-- Search & Filter -->
        <div class="bg-white rounded-lg shadow-md p-4">
            <div class="grid grid-cols-1 md:grid-cols-5 gap-4">
                <input v-model="filters.search" @input="loadProducts" type="text"
                    placeholder="Search by title, brand..."
                    class="px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500" />
                <select v-model="filters.category_id" @change="loadProducts"
                    class="px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500">
                    <option value="">All Categories</option>
                    <option v-for="cat in categories" :key="cat.id" :value="cat.id">{{ cat.name }}</option>
                </select>
                <select v-model="filters.brand" @change="loadProducts"
                    class="px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500">
                    <option value="">All Brands</option>
                    <option v-for="brand in brands" :key="brand" :value="brand">{{ brand }}</option>
                </select>
                <button @click="resetFilters" class="px-4 py-2 bg-gray-200 rounded-lg hover:bg-gray-300">
                    Reset
                </button>
            </div>
        </div>

        <!-- Products Table -->
        <div class="bg-white rounded-lg shadow-md overflow-hidden">
            <div v-if="loading" class="p-8 text-center">
                <p class="text-gray-600">Loading products...</p>
            </div>

            <table v-else class="min-w-full">
                <thead class="bg-gray-50">
                    <tr>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">No</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">SKU</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Product</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Categories</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Brand</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Stock</th>
                        <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase">Min Stock</th>
                        <th class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase">Actions</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-gray-200">
                    <tr v-for="product in products.data" :key="product.id" class="hover:bg-gray-50">
                        <td class="px-6 py-4 text-sm">{{ product.id }}</td>
                        <td class="px-6 py-4 text-sm">{{ product.sku }}</td>
                        <td class="px-6 py-4">
                            <div class="font-medium text-gray-900">{{ product.title }}</div>
                        </td>
                        <td class="px-6 py-4">
                            <!-- Display category pairs as tags -->
                            <div class="flex flex-wrap gap-1">
                                <template v-if="product.category_pairs && product.category_pairs.length > 0">
                                    <span v-for="(pair, idx) in product.category_pairs" :key="idx"
                                        class="inline-flex items-center px-2 py-1 text-xs rounded-full bg-indigo-100 text-indigo-800">
                                        {{ pair.category_name }}
                                        <span v-if="pair.sub_category_name" class="ml-1 text-indigo-600">
                                            / {{ pair.sub_category_name }}
                                        </span>
                                    </span>
                                </template>
                                <template v-else-if="product.category">
                                    <span class="inline-flex items-center px-2 py-1 text-xs rounded-full bg-gray-100 text-gray-800">
                                        {{ product.category }}
                                        <span v-if="product.sub_category" class="ml-1 text-gray-600">
                                            / {{ product.sub_category }}
                                        </span>
                                    </span>
                                </template>
                                <span v-else class="text-gray-400 text-sm">-</span>
                            </div>
                        </td>
                        <td class="px-6 py-4 text-sm">{{ product.brand || '-' }}</td>
                        <td class="px-6 py-4">
                            <span :class="[
                                'px-2 py-1 text-xs rounded-full',
                                product.stock <= (product.minimum_stock || 0) ? 'bg-red-100 text-red-800' : 'bg-green-100 text-green-800'
                            ]">
                                {{ product.stock || 0 }}
                            </span>
                        </td>
                        <td class="px-6 py-4 text-sm text-gray-600">{{ product.minimum_stock || 0 }}</td>
                        <td class="px-6 py-4 text-right text-sm space-x-2">
                            <button @click="editProduct(product)"
                                class="text-indigo-600 hover:text-indigo-900">Edit</button>
                            <button @click="deleteProduct(product.id)"
                                class="text-red-600 hover:text-red-900">Delete</button>
                        </td>
                    </tr>
                </tbody>
            </table>

            <!-- Pagination -->
            <div v-if="products.data?.length" class="px-6 py-4 bg-gray-50 flex justify-between items-center">
                <p class="text-sm text-gray-700">
                    Showing {{ products.from }} to {{ products.to }} of {{ products.total }} products
                </p>
                <div class="flex space-x-2">
                    <button @click="loadProducts(products.current_page - 1)" :disabled="!products.prev_page_url"
                        class="px-3 py-1 bg-white border rounded hover:bg-gray-50 disabled:opacity-50">Previous</button>
                    <button @click="loadProducts(products.current_page + 1)" :disabled="!products.next_page_url"
                        class="px-3 py-1 bg-white border rounded hover:bg-gray-50 disabled:opacity-50">Next</button>
                </div>
            </div>
        </div>

        <!-- Product Form Modal -->
        <div v-if="showModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4"
            @click.self="showModal = false">
            <div class="bg-white rounded-lg p-6 w-full max-w-6xl max-h-[90vh] overflow-y-auto">
                <div class="flex justify-between items-center mb-6">
                    <h3 class="text-2xl font-bold text-gray-900">
                        {{ editingProduct ? 'Edit Product' : 'Add New Product' }}
                    </h3>
                    <button @click="showModal = false; editingProduct = null"
                        class="text-gray-400 hover:text-gray-600 text-3xl leading-none">&times;</button>
                </div>

                <form @submit.prevent="saveProduct" class="space-y-6">
                    <!-- Basic Information -->
                    <div class="bg-gray-50 p-4 rounded-lg">
                        <h4 class="text-lg font-semibold mb-4 text-gray-700">Basic Information</h4>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div>
                                <label class="block text-sm font-medium mb-1">Title *</label>
                                <input v-model="form.title" type="text" required
                                    class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500" />
                            </div>
                            <div>
                                <label class="block text-sm font-medium mb-1">SKU</label>
                                <input v-model="form.sku" type="text"
                                    class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500" />
                            </div>
                            <div>
                                <label class="block text-sm font-medium mb-1">Brand</label>
                                <input v-model="form.brand" type="text"
                                    class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500" />
                            </div>
                            <div>
                                <label class="block text-sm font-medium mb-1">Image URL</label>
                                <input v-model="form.image" type="url"
                                    class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500"
                                    placeholder="https://..." />
                            </div>
                            <div class="md:col-span-2">
                                <label class="block text-sm font-medium mb-1">Description</label>
                                <textarea v-model="form.descriptions" rows="4"
                                    class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500"></textarea>
                            </div>
                        </div>
                    </div>

                    <!-- Categories Section -->
                    <div class="bg-gray-50 p-4 rounded-lg">
                        <div class="flex justify-between items-center mb-4">
                            <h4 class="text-lg font-semibold text-gray-700">Categories & Subcategories</h4>
                            <button type="button" @click="addCategoryPair"
                                class="px-3 py-1 bg-indigo-600 text-white text-sm rounded-lg hover:bg-indigo-700">
                                + Add Category
                            </button>
                        </div>
                        
                        <div v-if="form.categories.length === 0" class="text-gray-500 text-sm mb-4">
                            No categories added. Click "Add Category" to add one.
                        </div>

                        <div class="space-y-3">
                            <div v-for="(catPair, index) in form.categories" :key="index" 
                                class="flex items-center gap-3 p-3 bg-white rounded-lg border border-gray-200">
                                <div class="flex-1">
                                    <label class="block text-xs font-medium text-gray-500 mb-1">Category</label>
                                    <select v-model="catPair.category_id" @change="onCategoryChange(index)"
                                        class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500">
                                        <option value="">Select Category</option>
                                        <option v-for="cat in categories" :key="cat.id" :value="cat.id">
                                            {{ cat.name }}
                                        </option>
                                    </select>
                                </div>
                                <div class="flex-1">
                                    <label class="block text-xs font-medium text-gray-500 mb-1">Subcategory</label>
                                    <select v-model="catPair.sub_category_id"
                                        class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500"
                                        :disabled="!catPair.category_id">
                                        <option value="">Select Subcategory</option>
                                        <option v-for="sub in getSubcategoriesForCategory(catPair.category_id)" 
                                            :key="sub.id" :value="sub.id">
                                            {{ sub.name }}
                                        </option>
                                    </select>
                                </div>
                                <button type="button" @click="removeCategoryPair(index)"
                                    class="p-2 text-red-600 hover:text-red-800 hover:bg-red-50 rounded-lg">
                                    <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                                    </svg>
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Stock Management -->
                    <div class="bg-gray-50 p-4 rounded-lg">
                        <h4 class="text-lg font-semibold mb-4 text-gray-700">Stock Management</h4>
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div>
                                <label class="block text-sm font-medium mb-1">Current Stock</label>
                                <input v-model.number="form.stock" type="number" min="0"
                                    class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500" />
                            </div>
                            <div>
                                <label class="block text-sm font-medium mb-1">Minimum Stock (Alert Threshold)</label>
                                <input v-model.number="form.minimum_stock" type="number" min="0"
                                    class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500" />
                            </div>
                        </div>
                    </div>

                    <!-- Form Actions -->
                    <div class="flex justify-end space-x-3 pt-4 border-t">
                        <button type="button" @click="showModal = false; editingProduct = null"
                            class="px-6 py-2 bg-gray-200 text-gray-700 rounded-lg hover:bg-gray-300">Cancel</button>
                        <button type="submit" :disabled="saving"
                            class="px-6 py-2 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700 disabled:opacity-50">
                            {{ saving ? 'Saving...' : 'Save Product' }}
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Upload Progress/Error Message -->
        <div v-if="uploadMessage" class="fixed bottom-4 right-4 bg-white rounded-lg shadow-lg p-4 max-w-md">
            <div class="flex items-start gap-3">
                <div v-if="uploadMessage.type === 'success'" class="text-green-500">
                    <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd"
                            d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z"
                            clip-rule="evenodd" />
                    </svg>
                </div>
                <div v-else class="text-red-500">
                    <svg class="w-6 h-6" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd"
                            d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z"
                            clip-rule="evenodd" />
                    </svg>
                </div>
                <div class="flex-1">
                    <p class="font-semibold">{{ uploadMessage.title }}</p>
                    <p class="text-sm text-gray-600">{{ uploadMessage.message }}</p>
                </div>
                <button @click="uploadMessage = null" class="text-gray-400 hover:text-gray-600">
                    <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd"
                            d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
                            clip-rule="evenodd" />
                    </svg>
                </button>
            </div>
        </div>
    </div>
</template>

<script setup>
import { ref, onMounted } from 'vue';
import api from '../services/api';

const products = ref({ data: [] });
const loading = ref(true);
const showModal = ref(false);
const editingProduct = ref(null);
const saving = ref(false);

// Upload states
const fileInput = ref(null);
const uploadMessage = ref(null);

const categories = ref([]);
const brands = ref([]);

const filters = ref({
    search: '',
    category_id: '',
    brand: ''
});

const form = ref({
    title: '',
    sku: '',
    brand: '',
    image: '',
    descriptions: '',
    stock: 0,
    minimum_stock: 0,
    categories: [] // Array of {category_id, sub_category_id}
});

const resetForm = () => {
    form.value = {
        title: '',
        sku: '',
        brand: '',
        image: '',
        descriptions: '',
        stock: 0,
        minimum_stock: 0,
        categories: []
    };
};

const addCategoryPair = () => {
    form.value.categories.push({
        category_id: '',
        sub_category_id: ''
    });
};

const removeCategoryPair = (index) => {
    form.value.categories.splice(index, 1);
};

const onCategoryChange = (index) => {
    // Reset subcategory when category changes
    form.value.categories[index].sub_category_id = '';
};

const getSubcategoriesForCategory = (categoryId) => {
    if (!categoryId) return [];
    const category = categories.value.find(c => c.id === categoryId);
    return category?.sub_categories || [];
};

const loadFilterOptions = async () => {
    try {
        const response = await api.get('/products/filter-options');
        categories.value = response.data.categories || [];
        brands.value = response.data.brands || [];
    } catch (error) {
        console.error('Failed to load filter options:', error);
    }
};

const loadProducts = async (page = 1) => {
    loading.value = true;
    try {
        const params = { page, ...filters.value };
        // Clean up empty params
        Object.keys(params).forEach(key => {
            if (params[key] === '') delete params[key];
        });
        const response = await api.get('/products', { params });
        products.value = response.data;
    } catch (error) {
        console.error('Failed to load products:', error);
    } finally {
        loading.value = false;
    }
};

const resetFilters = () => {
    filters.value = { search: '', category_id: '', brand: '' };
    loadProducts();
};

const editProduct = (product) => {
    editingProduct.value = product;
    
    // Convert category_pairs to form.categories format
    const categoryPairs = product.category_pairs || [];
    const formCategories = categoryPairs.map(pair => ({
        category_id: pair.category_id || '',
        sub_category_id: pair.sub_category_id || ''
    }));

    form.value = {
        title: product.title || '',
        sku: product.sku || '',
        brand: product.brand || '',
        image: product.image || '',
        descriptions: product.descriptions || '',
        stock: product.stock || 0,
        minimum_stock: product.minimum_stock || 0,
        categories: formCategories.length > 0 ? formCategories : []
    };
    showModal.value = true;
};

const saveProduct = async () => {
    saving.value = true;
    try {
        // Filter out empty category pairs
        const validCategories = form.value.categories.filter(c => c.category_id);
        const payload = {
            ...form.value,
            categories: validCategories
        };

        if (editingProduct.value) {
            await api.put(`/products/${editingProduct.value.id}`, payload);
        } else {
            await api.post('/products', payload);
        }
        showModal.value = false;
        editingProduct.value = null;
        resetForm();
        loadProducts();
    } catch (error) {
        console.error('Failed to save product:', error);
        alert('Failed to save product: ' + (error.response?.data?.message || 'Unknown error'));
    } finally {
        saving.value = false;
    }
};

const deleteProduct = async (id) => {
    if (!confirm('Are you sure you want to delete this product?')) return;
    try {
        await api.delete(`/products/${id}`);
        loadProducts();
    } catch (error) {
        console.error('Failed to delete product:', error);
        alert('Failed to delete product');
    }
};

// Excel functions
const downloadExcel = async () => {
    try {
        const response = await api.get('/products/export/all', {
            responseType: 'blob'
        });
        const url = window.URL.createObjectURL(new Blob([response.data]));
        const link = document.createElement('a');
        link.href = url;
        link.setAttribute('download', `products_${new Date().toISOString().split('T')[0]}.xlsx`);
        document.body.appendChild(link);
        link.click();
        link.remove();
    } catch (error) {
        console.error('Failed to download Excel:', error);
        alert('Failed to download Excel file');
    }
};

const downloadTemplate = async () => {
    try {
        const response = await api.get('/products/export/template', {
            responseType: 'blob'
        });
        const url = window.URL.createObjectURL(new Blob([response.data]));
        const link = document.createElement('a');
        link.href = url;
        link.setAttribute('download', 'products_template.xlsx');
        document.body.appendChild(link);
        link.click();
        link.remove();
    } catch (error) {
        console.error('Failed to download template:', error);
        alert('Failed to download template');
    }
};

const uploadExcel = async (event) => {
    const file = event.target.files[0];
    if (!file) return;

    const formData = new FormData();
    formData.append('file', file);

    try {
        const response = await api.post('/products/import', formData, {
            headers: {
                'Content-Type': 'multipart/form-data'
            }
        });

        uploadMessage.value = {
            type: 'success',
            title: 'Upload Successful',
            message: response.data.message
        };

        // Clear file input
        event.target.value = '';

        // Reload products
        loadProducts();

        // Auto-hide message after 5 seconds
        setTimeout(() => {
            uploadMessage.value = null;
        }, 5000);
    } catch (error) {
        console.error('Failed to upload Excel:', error);
        uploadMessage.value = {
            type: 'error',
            title: 'Upload Failed',
            message: error.response?.data?.message || 'Failed to upload file'
        };

        // Auto-hide error after 8 seconds
        setTimeout(() => {
            uploadMessage.value = null;
        }, 8000);
    }
};

onMounted(() => {
    loadFilterOptions();
    loadProducts();
});
</script>

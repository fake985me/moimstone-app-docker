<template>
    <div class="space-y-6">
        <!-- Header -->
        <div class="flex justify-between items-center">
            <div>
                <h2
                    class="text-2xl font-bold bg-gradient-to-r from-teal-600 to-cyan-600 bg-clip-text text-transparent"
                >
                    Project Planning
                </h2>
                <p class="text-sm text-gray-600 mt-1">
                    Kelola perencanaan waktu, biaya, dan material proyek
                </p>
            </div>
            <button
                @click="
                    showModal = true;
                    resetForm();
                "
                class="px-6 py-3 bg-gradient-to-r from-teal-600 to-teal-700 text-white rounded-lg hover:from-teal-700 hover:to-teal-800 transition-all duration-200 shadow-md hover:shadow-lg font-medium"
            >
                + New Project
            </button>
        </div>

        <!-- Summary Cards -->
        <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
            <div class="card p-4 bg-gradient-to-br from-blue-50 to-blue-100">
                <p class="text-sm text-blue-600 font-medium">Total Projects</p>
                <p class="text-2xl font-bold text-blue-800">
                    {{ summary.total || 0 }}
                </p>
            </div>
            <div class="card p-4 bg-gradient-to-br from-green-50 to-green-100">
                <p class="text-sm text-green-600 font-medium">In Progress</p>
                <p class="text-2xl font-bold text-green-800">
                    {{ summary.in_progress || 0 }}
                </p>
            </div>
            <div
                class="card p-4 bg-gradient-to-br from-purple-50 to-purple-100"
            >
                <p class="text-sm text-purple-600 font-medium">Completed</p>
                <p class="text-2xl font-bold text-purple-800">
                    {{ summary.completed || 0 }}
                </p>
            </div>
            <div class="card p-4 bg-gradient-to-br from-red-50 to-red-100">
                <p class="text-sm text-red-600 font-medium">Overdue</p>
                <p class="text-2xl font-bold text-red-800">
                    {{ summary.overdue || 0 }}
                </p>
            </div>
        </div>

        <!-- Filters -->
        <div class="card p-4">
            <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
                <input
                    v-model="filters.search"
                    @input="loadProjects"
                    type="text"
                    placeholder="Search projects..."
                    class="input"
                />
                <select
                    v-model="filters.status"
                    @change="loadProjects"
                    class="input"
                >
                    <option value="">All Status</option>
                    <option value="draft">Draft</option>
                    <option value="planning">Planning</option>
                    <option value="in_progress">In Progress</option>
                    <option value="on_hold">On Hold</option>
                    <option value="completed">Completed</option>
                    <option value="cancelled">Cancelled</option>
                </select>
            </div>
        </div>

        <!-- Projects Table -->
        <div class="table-wrapper">
            <div class="card-header">
                <h3 class="text-lg font-semibold text-gray-900">
                    Project List
                </h3>
            </div>

            <div v-if="loading" class="p-8 text-center">
                <p class="text-gray-600">Loading...</p>
            </div>

            <table v-else class="min-w-full">
                <thead class="table-header">
                    <tr>
                        <th
                            class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase"
                        >
                            Project
                        </th>
                        <th
                            class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase"
                        >
                            Client
                        </th>
                        <th
                            class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase"
                        >
                            Timeline
                        </th>
                        <th
                            class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase"
                        >
                            Budget
                        </th>
                        <th
                            class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase"
                        >
                            Progress
                        </th>
                        <th
                            class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase"
                        >
                            Status
                        </th>
                        <th
                            class="px-6 py-3 text-right text-xs font-medium text-gray-500 uppercase"
                        >
                            Actions
                        </th>
                    </tr>
                </thead>
                <tbody class="bg-white divide-y divide-gray-200">
                    <tr
                        v-for="project in projects.data"
                        :key="project.id"
                        class="hover:bg-gray-50"
                    >
                        <td class="px-6 py-4">
                            <div class="text-sm font-medium text-gray-900">
                                {{ project.title }}
                            </div>
                            <div class="text-xs text-gray-500">
                                {{ project.project_code }}
                            </div>
                        </td>
                        <td class="px-6 py-4">
                            <div class="text-sm text-gray-900">
                                {{ project.client_name || "-" }}
                            </div>
                        </td>
                        <td class="px-6 py-4">
                            <div class="text-sm text-gray-900">
                                {{ formatDate(project.start_date) }}
                            </div>
                            <div class="text-xs text-gray-500">
                                {{ project.remaining_days }} days remaining
                            </div>
                        </td>
                        <td class="px-6 py-4">
                            <div class="text-sm text-gray-900">
                                {{
                                    formatCurrency(project.total_estimated_cost)
                                }}
                            </div>
                            <div
                                :class="
                                    project.is_on_budget
                                        ? 'text-green-600'
                                        : 'text-red-600'
                                "
                                class="text-xs"
                            >
                                Actual:
                                {{ formatCurrency(project.total_actual_cost) }}
                            </div>
                        </td>
                        <td class="px-6 py-4">
                            <div class="w-full bg-gray-200 rounded-full h-2">
                                <div
                                    class="bg-teal-600 h-2 rounded-full"
                                    :style="{
                                        width:
                                            project.progress_percentage + '%',
                                    }"
                                ></div>
                            </div>
                            <div class="text-xs text-gray-600 mt-1">
                                {{ project.progress_percentage }}%
                            </div>
                        </td>
                        <td class="px-6 py-4">
                            <span :class="getStatusBadge(project.status)">{{
                                project.status
                            }}</span>
                        </td>
                        <td class="px-6 py-4 text-right text-sm space-x-2">
                            <button
                                v-if="project.status === 'draft'"
                                @click="startProject(project)"
                                class="text-blue-600 hover:text-blue-900"
                            >
                                Start
                            </button>
                            <button
                                v-if="project.status === 'in_progress'"
                                @click="completeProject(project)"
                                class="text-green-600 hover:text-green-900"
                            >
                                Complete
                            </button>
                            <button
                                @click="viewProject(project)"
                                class="text-indigo-600 hover:text-indigo-900"
                            >
                                View
                            </button>
                            <button
                                @click="editProject(project)"
                                class="text-blue-600 hover:text-blue-900"
                            >
                                Edit
                            </button>
                            <button
                                @click="deleteProject(project.id)"
                                class="text-red-600 hover:text-red-900"
                            >
                                Delete
                            </button>
                        </td>
                    </tr>
                </tbody>
            </table>

            <!-- Pagination -->
            <div
                v-if="projects.data?.length"
                class="px-6 py-4 bg-gray-50 flex justify-between"
            >
                <p class="text-sm text-gray-700">
                    Showing {{ projects.from }} to {{ projects.to }} of
                    {{ projects.total }}
                </p>
                <div class="flex space-x-2">
                    <button
                        @click="loadProjects(projects.current_page - 1)"
                        :disabled="!projects.prev_page_url"
                        class="btn-secondary disabled:opacity-50"
                    >
                        Previous
                    </button>
                    <button
                        @click="loadProjects(projects.current_page + 1)"
                        :disabled="!projects.next_page_url"
                        class="btn-secondary disabled:opacity-50"
                    >
                        Next
                    </button>
                </div>
            </div>
        </div>

        <!-- Create/Edit Modal -->
        <div
            v-if="showModal"
            class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4"
        >
            <div
                class="bg-white rounded-xl p-6 w-full max-w-4xl max-h-[90vh] overflow-y-auto"
            >
                <h3 class="text-2xl font-bold mb-6">
                    {{ editMode ? "Edit Project" : "New Project Plan" }}
                </h3>

                <form @submit.prevent="saveProject" class="space-y-4">
                    <!-- Basic Info -->
                    <div class="p-4 bg-gray-50 rounded-lg">
                        <h4 class="font-semibold text-gray-800 mb-3">
                            Basic Information
                        </h4>
                        <div class="grid grid-cols-2 gap-4">
                            <div>
                                <label
                                    class="block text-sm font-medium text-gray-700 mb-1"
                                    >Project Title *</label
                                >
                                <input
                                    v-model="form.title"
                                    required
                                    class="input"
                                    placeholder="Enter project title"
                                />
                            </div>
                            <div>
                                <label
                                    class="block text-sm font-medium text-gray-700 mb-1"
                                    >Client Name</label
                                >
                                <input
                                    v-model="form.client_name"
                                    class="input"
                                    placeholder="Client name"
                                />
                            </div>
                            <div>
                                <label
                                    class="block text-sm font-medium text-gray-700 mb-1"
                                    >Client Contact</label
                                >
                                <input
                                    v-model="form.client_contact"
                                    class="input"
                                    placeholder="Phone or email"
                                />
                            </div>
                            <div>
                                <label
                                    class="block text-sm font-medium text-gray-700 mb-1"
                                    >Start Date *</label
                                >
                                <input
                                    v-model="form.start_date"
                                    type="date"
                                    required
                                    class="input"
                                />
                            </div>
                            <div>
                                <label
                                    class="block text-sm font-medium text-gray-700 mb-1"
                                    >End Date</label
                                >
                                <input
                                    v-model="form.end_date"
                                    type="date"
                                    class="input"
                                />
                            </div>
                        </div>
                        <div class="mt-3">
                            <label
                                class="block text-sm font-medium text-gray-700 mb-1"
                                >Description</label
                            >
                            <textarea
                                v-model="form.description"
                                rows="2"
                                class="input"
                            ></textarea>
                        </div>
                    </div>

                    <!-- Milestones -->
                    <div class="p-4 bg-blue-50 rounded-lg">
                        <div class="flex justify-between items-center mb-3">
                            <h4 class="font-semibold text-gray-800">
                                Milestones (Timeline)
                            </h4>
                            <button
                                type="button"
                                @click="addMilestone"
                                class="text-sm text-blue-600 hover:text-blue-800"
                            >
                                + Add Milestone
                            </button>
                        </div>
                        <div
                            v-for="(m, index) in form.milestones"
                            :key="index"
                            class="grid grid-cols-4 gap-2 mb-2"
                        >
                            <input
                                v-model="m.name"
                                class="input col-span-2"
                                placeholder="Milestone name"
                            />
                            <input
                                v-model="m.target_date"
                                type="date"
                                class="input"
                            />
                            <button
                                type="button"
                                @click="form.milestones.splice(index, 1)"
                                class="text-red-500 hover:text-red-700"
                            >
                                ✕
                            </button>
                        </div>
                    </div>

                    <!-- Materials -->
                    <div class="p-4 bg-green-50 rounded-lg">
                        <div class="flex justify-between items-center mb-3">
                            <h4 class="font-semibold text-gray-800">
                                Materials
                            </h4>
                            <button
                                type="button"
                                @click="addMaterial"
                                class="text-sm text-green-600 hover:text-green-800"
                            >
                                + Add Material
                            </button>
                        </div>
                        <div
                            v-for="(m, index) in form.materials"
                            :key="index"
                            class="grid grid-cols-5 gap-2 mb-2"
                        >
                            <select
                                v-model="m.product_id"
                                @change="setMaterialPrice(index)"
                                class="input col-span-2"
                            >
                                <option value="">Select Product</option>
                                <option
                                    v-for="product in products"
                                    :key="product.id"
                                    :value="product.id"
                                >
                                    {{ product.title || product.name }}
                                </option>
                            </select>
                            <input
                                v-model.number="m.quantity_planned"
                                type="number"
                                min="1"
                                class="input"
                                placeholder="Qty"
                            />
                            <input
                                v-model.number="m.unit_price"
                                type="number"
                                step="0.01"
                                class="input"
                                placeholder="Unit Price"
                            />
                            <button
                                type="button"
                                @click="form.materials.splice(index, 1)"
                                class="text-red-500 hover:text-red-700"
                            >
                                ✕
                            </button>
                        </div>
                        <div
                            v-if="form.materials.length"
                            class="text-right text-sm font-semibold text-gray-700 mt-2"
                        >
                            Material Cost:
                            {{ formatCurrency(calculateMaterialCost()) }}
                        </div>
                    </div>

                    <!-- Other Costs -->
                    <div class="p-4 bg-yellow-50 rounded-lg">
                        <div class="flex justify-between items-center mb-3">
                            <h4 class="font-semibold text-gray-800">
                                Other Costs
                            </h4>
                            <button
                                type="button"
                                @click="addCost"
                                class="text-sm text-yellow-600 hover:text-yellow-800"
                            >
                                + Add Cost
                            </button>
                        </div>
                        <div
                            v-for="(c, index) in form.costs"
                            :key="index"
                            class="grid grid-cols-5 gap-2 mb-2"
                        >
                            <select v-model="c.category" class="input">
                                <option value="labor">Tenaga Kerja</option>
                                <option value="overhead">Overhead</option>
                                <option value="equipment">Peralatan</option>
                                <option value="transport">Transportasi</option>
                                <option value="other">Lainnya</option>
                            </select>
                            <input
                                v-model="c.description"
                                class="input col-span-2"
                                placeholder="Description"
                            />
                            <input
                                v-model.number="c.estimated_amount"
                                type="number"
                                step="0.01"
                                class="input"
                                placeholder="Estimated"
                            />
                            <button
                                type="button"
                                @click="form.costs.splice(index, 1)"
                                class="text-red-500 hover:text-red-700"
                            >
                                ✕
                            </button>
                        </div>
                        <div
                            v-if="form.costs.length"
                            class="text-right text-sm font-semibold text-gray-700 mt-2"
                        >
                            Other Costs:
                            {{ formatCurrency(calculateOtherCost()) }}
                        </div>
                    </div>

                    <!-- Total -->
                    <div
                        class="text-right text-lg font-bold text-gray-900 p-4 bg-gray-100 rounded-lg"
                    >
                        Total Estimated Cost:
                        {{
                            formatCurrency(
                                calculateMaterialCost() + calculateOtherCost()
                            )
                        }}
                    </div>

                    <div
                        v-if="error"
                        class="bg-red-50 text-red-600 p-3 rounded-lg text-sm"
                    >
                        {{ error }}
                    </div>

                    <div class="flex justify-end space-x-3 pt-4 border-t">
                        <button
                            type="button"
                            @click="showModal = false"
                            class="btn-secondary"
                        >
                            Cancel
                        </button>
                        <button
                            type="submit"
                            :disabled="saving"
                            class="btn-primary"
                        >
                            {{ saving ? "Saving..." : "Save Project" }}
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- View Modal -->
        <div
            v-if="showViewModal"
            class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4"
        >
            <div
                class="bg-white rounded-xl p-6 w-full max-w-4xl max-h-[90vh] overflow-y-auto"
            >
                <h3 class="text-2xl font-bold mb-6">
                    {{ selectedProject?.title }}
                </h3>

                <div class="grid grid-cols-3 gap-4 mb-6">
                    <div>
                        <span class="text-gray-500">Code:</span>
                        <strong>{{ selectedProject?.project_code }}</strong>
                    </div>
                    <div>
                        <span class="text-gray-500">Status:</span>
                        <span
                            :class="getStatusBadge(selectedProject?.status)"
                            >{{ selectedProject?.status }}</span
                        >
                    </div>
                    <div>
                        <span class="text-gray-500">Progress:</span>
                        {{ selectedProject?.progress_percentage }}%
                    </div>
                    <div>
                        <span class="text-gray-500">Client:</span>
                        {{ selectedProject?.client_name || "-" }}
                    </div>
                    <div>
                        <span class="text-gray-500">Start:</span>
                        {{ formatDate(selectedProject?.start_date) }}
                    </div>
                    <div>
                        <span class="text-gray-500">End:</span>
                        {{ formatDate(selectedProject?.end_date) }}
                    </div>
                </div>

                <!-- Budget Overview -->
                <div class="grid grid-cols-2 gap-4 mb-6">
                    <div class="p-4 bg-blue-50 rounded-lg">
                        <p class="text-sm text-blue-600">Estimated Cost</p>
                        <p class="text-xl font-bold text-blue-800">
                            {{
                                formatCurrency(
                                    selectedProject?.total_estimated_cost
                                )
                            }}
                        </p>
                    </div>
                    <div
                        class="p-4 rounded-lg"
                        :class="
                            selectedProject?.is_on_budget
                                ? 'bg-green-50'
                                : 'bg-red-50'
                        "
                    >
                        <p
                            class="text-sm"
                            :class="
                                selectedProject?.is_on_budget
                                    ? 'text-green-600'
                                    : 'text-red-600'
                            "
                        >
                            Actual Cost
                        </p>
                        <p
                            class="text-xl font-bold"
                            :class="
                                selectedProject?.is_on_budget
                                    ? 'text-green-800'
                                    : 'text-red-800'
                            "
                        >
                            {{
                                formatCurrency(
                                    selectedProject?.total_actual_cost
                                )
                            }}
                        </p>
                    </div>
                </div>

                <!-- Milestones -->
                <h4 class="font-semibold text-gray-800 mb-3">Milestones</h4>
                <table class="min-w-full text-sm mb-6">
                    <thead class="bg-gray-50">
                        <tr>
                            <th class="px-4 py-2 text-left">Milestone</th>
                            <th class="px-4 py-2 text-left">Target Date</th>
                            <th class="px-4 py-2 text-left">Status</th>
                            <th class="px-4 py-2 text-right">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr
                            v-for="m in selectedProject?.milestones"
                            :key="m.id"
                            class="border-b"
                        >
                            <td class="px-4 py-2">{{ m.name }}</td>
                            <td class="px-4 py-2">
                                {{ formatDate(m.target_date) }}
                            </td>
                            <td class="px-4 py-2">
                                <span :class="getStatusBadge(m.status)">{{
                                    m.status
                                }}</span>
                            </td>
                            <td class="px-4 py-2 text-right">
                                <button
                                    v-if="m.status !== 'completed'"
                                    @click="completeMilestone(m)"
                                    class="text-green-600 hover:text-green-900 text-xs"
                                >
                                    Mark Complete
                                </button>
                            </td>
                        </tr>
                    </tbody>
                </table>

                <!-- Materials -->
                <h4 class="font-semibold text-gray-800 mb-3">Materials</h4>
                <table class="min-w-full text-sm mb-6">
                    <thead class="bg-gray-50">
                        <tr>
                            <th class="px-4 py-2 text-left">Material</th>
                            <th class="px-4 py-2 text-right">Planned</th>
                            <th class="px-4 py-2 text-right">Used</th>
                            <th class="px-4 py-2 text-right">Unit Price</th>
                            <th class="px-4 py-2 text-right">Cost</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr
                            v-for="m in selectedProject?.materials"
                            :key="m.id"
                            class="border-b"
                        >
                            <td class="px-4 py-2">
                                {{ m.product?.title || m.material_name }}
                            </td>
                            <td class="px-4 py-2 text-right">
                                {{ m.quantity_planned }}
                            </td>
                            <td class="px-4 py-2 text-right">
                                {{ m.quantity_used }}
                            </td>
                            <td class="px-4 py-2 text-right">
                                {{ formatCurrency(m.unit_price) }}
                            </td>
                            <td class="px-4 py-2 text-right font-medium">
                                {{ formatCurrency(m.total_cost) }}
                            </td>
                        </tr>
                    </tbody>
                </table>

                <div class="flex justify-end mt-6">
                    <button
                        @click="showViewModal = false"
                        class="btn-secondary"
                    >
                        Close
                    </button>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import api from "../services/api";

const projects = ref({ data: [] });
const products = ref([]);
const summary = ref({});
const loading = ref(true);
const showModal = ref(false);
const showViewModal = ref(false);
const selectedProject = ref(null);
const editMode = ref(false);
const editId = ref(null);
const saving = ref(false);
const error = ref("");

const filters = ref({ search: "", status: "" });

const form = ref({
    title: "",
    description: "",
    client_name: "",
    client_contact: "",
    start_date: new Date().toISOString().split("T")[0],
    end_date: "",
    milestones: [],
    materials: [],
    costs: [],
});

const formatCurrency = (value) =>
    "Rp " + Number(value || 0).toLocaleString("id-ID");
const formatDate = (date) =>
    date ? new Date(date).toLocaleDateString("id-ID") : "-";

const getStatusBadge = (status) => {
    const badges = {
        draft: "badge",
        planning: "badge-info",
        in_progress: "badge-primary",
        on_hold: "badge-warning",
        completed: "badge-success",
        cancelled: "badge-danger",
        pending: "badge-warning",
        overdue: "badge-danger",
    };
    return badges[status] || "badge";
};

const loadProjects = async (page = 1) => {
    loading.value = true;
    try {
        const response = await api.get("/project-plans", {
            params: { page, ...filters.value },
        });
        projects.value = response.data;
    } catch (err) {
        console.error(err);
    } finally {
        loading.value = false;
    }
};

const loadSummary = async () => {
    try {
        const response = await api.get("/project-plans/summary");
        summary.value = response.data;
    } catch (err) {
        console.error(err);
    }
};

const loadProducts = async () => {
    try {
        const response = await api.get("/products", {
            params: { per_page: 1000 },
        });
        products.value = response.data.data || [];
    } catch (err) {
        console.error(err);
    }
};

const resetForm = () => {
    editMode.value = false;
    editId.value = null;
    form.value = {
        title: "",
        description: "",
        client_name: "",
        client_contact: "",
        start_date: new Date().toISOString().split("T")[0],
        end_date: "",
        milestones: [],
        materials: [],
        costs: [],
    };
    error.value = "";
};

const addMilestone = () => {
    form.value.milestones.push({ name: "", target_date: "" });
};

const addMaterial = () => {
    form.value.materials.push({
        product_id: "",
        quantity_planned: 1,
        unit_price: 0,
    });
};

const addCost = () => {
    form.value.costs.push({
        category: "other",
        description: "",
        estimated_amount: 0,
    });
};

const setMaterialPrice = (index) => {
    const m = form.value.materials[index];
    const product = products.value.find((p) => p.id === parseInt(m.product_id));
    if (product) {
        m.unit_price = product.price || product.sell_price || 0;
    }
};

const calculateMaterialCost = () => {
    return form.value.materials.reduce(
        (sum, m) => sum + m.quantity_planned * m.unit_price,
        0
    );
};

const calculateOtherCost = () => {
    return form.value.costs.reduce(
        (sum, c) => sum + (c.estimated_amount || 0),
        0
    );
};

const saveProject = async () => {
    saving.value = true;
    error.value = "";

    try {
        if (editMode.value) {
            await api.put(`/project-plans/${editId.value}`, form.value);
        } else {
            await api.post("/project-plans", form.value);
        }
        showModal.value = false;
        loadProjects();
        loadSummary();
    } catch (err) {
        error.value = err.response?.data?.message || "Failed to save project";
    } finally {
        saving.value = false;
    }
};

const viewProject = async (project) => {
    try {
        const response = await api.get(`/project-plans/${project.id}`);
        selectedProject.value = response.data;
        showViewModal.value = true;
    } catch (err) {
        alert("Failed to load project details");
    }
};

const editProject = (project) => {
    editMode.value = true;
    editId.value = project.id;
    form.value = {
        title: project.title,
        description: project.description || "",
        client_name: project.client_name || "",
        client_contact: project.client_contact || "",
        start_date: project.start_date,
        end_date: project.end_date || "",
        milestones: project.milestones || [],
        materials: project.materials || [],
        costs: project.costs || [],
    };
    showModal.value = true;
};

const startProject = async (project) => {
    try {
        await api.post(`/project-plans/${project.id}/start`);
        loadProjects();
        loadSummary();
    } catch (err) {
        alert("Failed to start project");
    }
};

const completeProject = async (project) => {
    if (!confirm("Mark this project as completed?")) return;
    try {
        await api.post(`/project-plans/${project.id}/complete`);
        loadProjects();
        loadSummary();
    } catch (err) {
        alert("Failed to complete project");
    }
};

const deleteProject = async (id) => {
    if (!confirm("Are you sure you want to delete this project?")) return;
    try {
        await api.delete(`/project-plans/${id}`);
        loadProjects();
        loadSummary();
    } catch (err) {
        alert("Failed to delete project");
    }
};

const completeMilestone = async (milestone) => {
    try {
        await api.put(
            `/project-plans/${selectedProject.value.id}/milestones/${milestone.id}`,
            {
                status: "completed",
            }
        );
        viewProject(selectedProject.value);
    } catch (err) {
        alert("Failed to update milestone");
    }
};

onMounted(() => {
    loadProjects();
    loadSummary();
    loadProducts();
});
</script>

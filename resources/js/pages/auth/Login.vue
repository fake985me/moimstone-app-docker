<template>

  <div class="min-h-screen bg-linear-to-br from-slate-800 via-sky-900 to-gray-500 flex items-center justify-center p-6">
    <!-- Animated Background -->
    <div class="absolute inset-0 overflow-hidden opacity-20">
      <div class="absolute top-1/4 left-1/4 w-96 h-96 bg-cyan-500 rounded-full filter blur-3xl animate-pulse"></div>
      <div class="absolute bottom-1/4 right-1/4 w-96 h-96 bg-pink-500 rounded-full filter blur-3xl animate-pulse" style="animation-delay: 2s;"></div>
    </div>

    

    <!-- Login Card -->
    <div class="relative z-10 w-full max-w-md">
      <!-- Logo & Title -->
      <div class="text-center mb-8 animate-fade-in">
        <div class="inline-flex items-center justify-center w-20 h-20 bg-linear-to-r from-cyan-500 to-blue-600 rounded-2xl mb-4 shadow-2xl">
          <span class="text-4xl">📦</span>
        </div>
        <h1 class="text-4xl font-bold text-white mb-2">Warehouse MDI</h1>
        <p class="text-gray-300">Sign in to your account</p>
      </div>

      <!-- Login Form -->
      <div class="bg-white/10 backdrop-blur-xl rounded-2xl shadow-2xl p-8 border border-white/20">
        <form @submit.prevent="handleLogin" class="space-y-6">
          <div>
            <label class="block text-sm font-medium text-white mb-2">Email Address</label>
            <input
              v-model="email"
              type="email"
              required
              class="w-full px-4 py-3 bg-white/20 backdrop-blur-sm border border-white/30 rounded-lg text-white placeholder-gray-300 focus:ring-2 focus:ring-cyan-500 focus:border-cyan-500 transition-all"
              placeholder="admin@warehouse.com"
            />
          </div>

          <div>
            <label class="block text-sm font-medium text-white mb-2">Password</label>
            <input
              v-model="password"
              type="password"
              required
              class="w-full px-4 py-3 bg-white/20 backdrop-blur-sm border border-white/30 rounded-lg text-white placeholder-gray-300 focus:ring-2 focus:ring-cyan-500 focus:border-cyan-500 transition-all"
              placeholder="••••••••"
            />
          </div>

          <div v-if="error" class="bg-red-500/20 backdrop-blur-sm border border-red-500/30 text-red-200 p-4 rounded-lg text-sm">
            {{ error }}
          </div>

          <button
            type="submit"
            :disabled="loading"
            class="w-full py-3 bg-linear-to-r from-cyan-500 to-blue-600 text-white font-semibold rounded-lg hover:from-cyan-600 hover:to-blue-700 transition-all duration-300 shadow-lg hover:shadow-cyan-500/50 disabled:opacity-50"
          >
            {{ loading ? 'Signing in...' : 'Sign In' }}
          </button>
        </form>

        <!-- Demo Accounts -->
        <div class="mt-8 pt-6 border-t border-white/20">
          <p class="text-sm text-gray-300 mb-3 font-medium">Demo Accounts:</p>
          <div class="space-y-2 text-sm">
            <div class="bg-white/5 backdrop-blur-sm p-3 rounded-lg border border-white/10">
              <p class="text-white font-medium">Super Admin</p>
              <p class="text-gray-300 text-xs">admin@warehouse.com / password</p>
            </div>
            <div class="bg-white/5 backdrop-blur-sm p-3 rounded-lg border border-white/10">
              <p class="text-white font-medium">Admin User</p>
              <p class="text-gray-300 text-xs">admin@example.com / password</p>
            </div>
            <div class="bg-white/5 backdrop-blur-sm p-3 rounded-lg border border-white/10">
              <p class="text-white font-medium">Sales User</p>
              <p class="text-gray-300 text-xs">sales@example.com / password</p>
            </div>
          </div>
        </div>
      </div>

      <!-- Back to Home -->
      <div class="text-center mt-6">
        <router-link to="/" class="text-gray-300 hover:text-white transition-colors">
          ← Back to Home
        </router-link>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import { useAuthStore } from '../../stores/auth';

const router = useRouter();
const authStore = useAuthStore();

const email = ref('');
const password = ref('');
const loading = ref(false);
const error = ref('');

const handleLogin = async () => {
  loading.value = true;
  error.value = '';

  try {
    await authStore.login({
      email: email.value,
      password: password.value,
    });
    router.push('/dashboard');
  } catch (err) {
    error.value = err.response?.data?.message || 'Login failed. Please check your credentials.';
  } finally {
    loading.value = false;
  }
};
</script>

<style scoped>
@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(-20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

.animate-fade-in {
  animation: fadeIn 0.8s ease-out;
}
</style>

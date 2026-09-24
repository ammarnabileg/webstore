<template>
  <transition name="splash-fade">
    <div v-if="isVisible" class="splash-screen">
      <div class="splash-content">
        <img :src="logoSrc" alt="Logo" class="splash-logo" />
        <div class="splash-spinner"></div>
      </div>
    </div>
  </transition>
</template>

<script setup>
import { ref, onMounted, defineEmits } from 'vue';

const emit = defineEmits(['finished']);
const isVisible = ref(false);
const logoSrc = window.BotbleData?.logo || '';

onMounted(() => {
  // Only on mobile, and only once per browser session (it used to block every full page load).
  let seen = false;
  try { seen = sessionStorage.getItem('splashSeen_v1') === '1'; sessionStorage.setItem('splashSeen_v1', '1'); } catch (e) {}

  if (window.innerWidth <= 768 && !seen) {
    isVisible.value = true;
    
    // Hide after 2 seconds and emit finished event
    setTimeout(() => {
      isVisible.value = false;
      // Wait for fade out animation to complete before emitting
      setTimeout(() => {
        emit('finished');
      }, 500);
    }, 2000);
  } else {
    // If desktop, just emit finished immediately
    emit('finished');
  }
});
</script>

<style scoped>
.splash-screen {
  position: fixed;
  inset: 0;
  background-color: var(--surface);
  z-index: 999999;
  display: flex;
  align-items: center;
  justify-content: center;
}

.splash-content {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 20px;
}

.splash-logo {
  max-width: 180px;
  max-height: 80px;
  object-fit: contain;
  animation: pulse 1.5s infinite alternate;
}

.splash-spinner {
  width: 40px;
  height: 40px;
  border: 3px solid var(--border, var(--line));
  border-top: 3px solid var(--primary);
  border-radius: 50%;
  animation: spin 1s linear infinite;
}

@keyframes pulse {
  0% { transform: scale(0.95); opacity: 0.8; }
  100% { transform: scale(1.05); opacity: 1; }
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}

.splash-fade-enter-active,
.splash-fade-leave-active {
  transition: opacity 0.5s ease, transform 0.5s ease;
}

.splash-fade-enter-from,
.splash-fade-leave-to {
  opacity: 0;
  transform: scale(1.05);
}
</style>

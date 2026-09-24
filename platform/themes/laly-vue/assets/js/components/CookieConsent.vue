<template>
  <transition name="cookie-slide">
    <div v-if="isVisible" class="cookie-consent">
      <div class="cookie-content">
        <div class="cookie-icon"><i class="ti ti-cookie"></i></div>
        <div class="cookie-text">
          <h4>{{ __('cookies_title') || 'ملفات تعريف الارتباط' }}</h4>
          <p>{{ __('cookies_message') || 'نحن نستخدم ملفات تعريف الارتباط لتحسين تجربتك على موقعنا.' }}</p>
        </div>
      </div>
      <button class="btn-accept" @click="acceptCookies">{{ __('accept') || 'موافق' }}</button>
    </div>
  </transition>
</template>

<script setup>
import { ref, onMounted, inject } from 'vue';

const botbleData = window?.BotbleData || {};
const __ = inject('__') || botbleData?.i18n || ((key) => key);

const isVisible = ref(false);

onMounted(() => {
  // Show mostly on mobile, but it can work on desktop too if desired.
  // The user requested for mobile version.
  if (window.innerWidth <= 768) {
    const hasAccepted = localStorage.getItem('cookiesAccepted_v1');
    if (!hasAccepted) {
      // Delay showing it slightly for better UX
      setTimeout(() => {
        isVisible.value = true;
      }, 1500);
    }
  }
});

const acceptCookies = () => {
  localStorage.setItem('cookiesAccepted_v1', 'true');
  isVisible.value = false;
};
</script>

<style scoped>
.cookie-consent {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  background-color: var(--surface, #fff);
  padding: 16px;
  box-shadow: 0 -4px 15px rgba(0, 0, 0, 0.1);
  z-index: 999990;
  display: flex;
  flex-direction: column;
  gap: 15px;
  border-top-left-radius: 16px;
  border-top-right-radius: 16px;
}

.cookie-content {
  display: flex;
  align-items: center;
  gap: 12px;
}

.cookie-icon {
  font-size: 28px;
  color: var(--primary, #172B85);
  background: var(--bg, #f5f5f5);
  width: 48px;
  height: 48px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}

.cookie-text h4 {
  margin: 0 0 4px 0;
  font-size: 15px;
  font-weight: bold;
}

.cookie-text p {
  margin: 0;
  font-size: 13px;
  color: var(--text2, #666);
  line-height: 1.4;
}

.btn-accept {
  width: 100%;
  padding: 12px;
  background-color: var(--primary, #172B85);
  color: #fff;
  border: none;
  border-radius: 8px;
  font-size: 15px;
  font-weight: bold;
  cursor: pointer;
  transition: background-color 0.2s;
}

.btn-accept:active {
  opacity: 0.8;
}

.cookie-slide-enter-active,
.cookie-slide-leave-active {
  transition: transform 0.4s cubic-bezier(0.4, 0, 0.2, 1);
}

.cookie-slide-enter-from,
.cookie-slide-leave-to {
  transform: translateY(100%);
}
</style>

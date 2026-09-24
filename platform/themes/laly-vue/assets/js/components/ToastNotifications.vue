<template>
  <div class="toast-container">
    <transition-group name="toast">
      <div 
        v-for="notification in store.notifications" 
        :key="notification.id"
        class="toast-item"
        :class="`toast-${notification.type}`"
      >
        <div class="toast-content-wrapper">
          <div class="toast-icon">
            <i v-if="notification.type === 'success'" class="ti ti-check"></i>
            <i v-else-if="notification.type === 'error'" class="ti ti-x"></i>
            <i v-else class="ti ti-info-circle"></i>
          </div>
          <div class="toast-content">{{ notification.message }}</div>
          <button class="toast-close" @click="store.removeNotification(notification.id)" :aria-label="__('close')">
            <i class="ti ti-x"></i>
          </button>
        </div>
        <!-- Progress bar that shrinks over 3 seconds -->
        <div class="toast-progress"></div>
      </div>
    </transition-group>
  </div>
</template>

<script setup>
import { useEcommerceStore } from '../stores/ecommerce';

const store = useEcommerceStore();
</script>

<style scoped>
.toast-container {
  position: fixed;
  z-index: 99999;
  display: flex;
  flex-direction: column;
  gap: 15px;
  pointer-events: none;
}

/* Desktop */
@media (min-width: 768px) {
  .toast-container {
    top: 30px;
    right: 30px;
    align-items: flex-end;
  }
  html[dir="rtl"] .toast-container {
    right: auto;
    left: 30px;
    align-items: flex-start;
  }
}

/* Mobile */
@media (max-width: 767px) {
  .toast-container {
    bottom: 90px; /* Above the bottom tabbar */
    left: 15px;
    right: 15px;
    align-items: center;
  }
}

.toast-item {
  position: relative;
  background: rgba(255, 255, 255, 0.85);
  backdrop-filter: blur(12px);
  -webkit-backdrop-filter: blur(12px);
  border-radius: 50px;
  min-width: 300px;
  max-width: 90vw;
  pointer-events: auto;
  overflow: hidden;
  box-shadow: 0 10px 30px rgba(0,0,0,0.1);
  border: 1px solid rgba(255, 255, 255, 0.5);
  transform-origin: center;
}

.toast-content-wrapper {
  display: flex;
  align-items: center;
  padding: 10px 15px 10px 10px;
  gap: 12px;
}
html[dir="rtl"] .toast-content-wrapper {
  padding: 10px 10px 10px 15px;
}

/* Colors based on type */
.toast-success {
  box-shadow: 0 10px 30px rgba(40, 167, 69, 0.2);
}
.toast-error {
  box-shadow: 0 10px 30px rgba(220, 53, 69, 0.2);
}
.toast-info {
  box-shadow: 0 10px 30px rgba(23, 43, 133, 0.2);
}

.toast-icon {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 32px;
  height: 32px;
  border-radius: 50%;
  color: #fff;
  font-size: 18px;
  flex-shrink: 0;
  animation: pulse-icon 2s infinite ease-in-out;
}

@keyframes pulse-icon {
  0% { transform: scale(0.95); box-shadow: 0 0 0 0 rgba(0,0,0,0.2); }
  70% { transform: scale(1); box-shadow: 0 0 0 10px rgba(0,0,0,0); }
  100% { transform: scale(0.95); box-shadow: 0 0 0 0 rgba(0,0,0,0); }
}

.toast-success .toast-icon {
  background: linear-gradient(135deg, var(--success), #20c997);
}
.toast-error .toast-icon {
  background: linear-gradient(135deg, var(--sale), #f8d7da);
}
.toast-info .toast-icon {
  background: linear-gradient(135deg, var(--primary-strong), var(--primary));
}

.toast-content {
  flex: 1;
  font-size: 14px;
  font-weight: 600;
  color: var(--ink);
}

.toast-close {
  background: rgba(0,0,0,0.05);
  border: none;
  color: var(--ink-2);
  cursor: pointer;
  width: 28px;
  height: 28px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.2s;
  flex-shrink: 0;
}
.toast-close:hover {
  background: rgba(0,0,0,0.1);
  color: var(--ink);
  transform: rotate(90deg);
}

/* Progress bar */
.toast-progress {
  position: absolute;
  bottom: 0;
  left: 0;
  height: 3px;
  background: var(--primary-strong);
  width: 100%;
  animation: progress-shrink 3s linear forwards;
}
html[dir="rtl"] .toast-progress {
  right: 0;
  left: auto;
  transform-origin: right;
}

.toast-success .toast-progress { background: var(--success); }
.toast-error .toast-progress { background: var(--sale); }
.toast-info .toast-progress { background: var(--primary-strong); }

@keyframes progress-shrink {
  0% { width: 100%; }
  100% { width: 0%; }
}

/* Transitions with bouncy effects */
.toast-enter-active {
  transition: all 0.5s cubic-bezier(0.68, -0.55, 0.265, 1.55);
}
.toast-leave-active {
  transition: all 0.3s ease-in;
}

/* Desktop entry animation */
@media (min-width: 768px) {
  .toast-enter-from {
    opacity: 0;
    transform: translateX(50px) scale(0.8);
  }
  html[dir="rtl"] .toast-enter-from {
    transform: translateX(-50px) scale(0.8);
  }
}

/* Mobile entry animation */
@media (max-width: 767px) {
  .toast-enter-from {
    opacity: 0;
    transform: translateY(40px) scale(0.8);
  }
}

.toast-leave-to {
  opacity: 0;
  transform: translateY(-20px) scale(0.9);
}
</style>

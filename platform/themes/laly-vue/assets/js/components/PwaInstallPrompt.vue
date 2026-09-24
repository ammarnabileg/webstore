<template>
  <transition name="pwa-slide">
    <div v-if="isVisible" class="pwa-prompt">
      <div class="pwa-header">
        <button class="pwa-close" @click="dismissPrompt"><i class="ti ti-x"></i></button>
      </div>
      <div class="pwa-content">
        <img :src="appIcon" alt="App Icon" class="pwa-icon" />
        <div class="pwa-info">
          <h4>{{ __('install_app_title') || 'أضف التطبيق للشاشة الرئيسية' }}</h4>
          <p>{{ __('install_app_desc') || 'احصل على تجربة تسوق أسرع وأفضل عبر تطبيقنا.' }}</p>
        </div>
      </div>
      
      <div v-if="isIOS" class="pwa-instructions ios-instructions">
        <p>لتثبيت التطبيق على الآيفون:</p>
        <ol>
          <li>اضغط على زر المشاركة <i class="ti ti-share-2" style="font-size: 18px; margin: 0 4px;"></i> أسفل الشاشة</li>
          <li>اختر <strong>"Add to Home Screen"</strong> <i class="ti ti-square-plus" style="font-size: 18px; margin: 0 4px;"></i></li>
        </ol>
      </div>
      
      <div v-else class="pwa-actions">
        <button class="btn-install" @click="installPwa">{{ __('install') || 'تثبيت الآن' }}</button>
      </div>
    </div>
  </transition>
</template>

<script setup>
import { ref, onMounted, inject } from 'vue';

const botbleData = window?.BotbleData || {};
const __ = inject('__') || botbleData?.i18n || ((key) => key);

const isVisible = ref(false);
const isIOS = ref(false);
const appIcon = botbleData?.logo || '/storage/logo.png';
let deferredPrompt = null;

onMounted(() => {
  if (window.innerWidth <= 768) {
    // Check if already installed
    const isStandalone = window.matchMedia('(display-mode: standalone)').matches || window.navigator.standalone === true;
    if (isStandalone) return;

    // Check if recently dismissed
    const dismissedAt = localStorage.getItem('pwaPromptDismissed_v1');
    if (dismissedAt) {
      const daysSinceDismissed = (Date.now() - parseInt(dismissedAt)) / (1000 * 60 * 60 * 24);
      if (daysSinceDismissed < 7) {
        return; // Don't show again for 7 days
      }
    }

    // Detect iOS
    const userAgent = window.navigator.userAgent.toLowerCase();
    isIOS.value = /iphone|ipad|ipod/.test(userAgent);

    if (isIOS.value) {
      // Show for iOS after a delay
      setTimeout(() => {
        isVisible.value = true;
      }, 3000);
    } else {
      // For Android, wait for the beforeinstallprompt event
      window.addEventListener('beforeinstallprompt', (e) => {
        // Prevent Chrome 67 and earlier from automatically showing the prompt
        e.preventDefault();
        // Stash the event so it can be triggered later.
        deferredPrompt = e;
        // Update UI to notify the user they can add to home screen
        setTimeout(() => {
            isVisible.value = true;
        }, 2000);
      });
      
      // Fallback if beforeinstallprompt doesn't fire (maybe they don't have a SW yet)
      // but we still want to show the banner.
      setTimeout(() => {
         if (!isVisible.value && !deferredPrompt) {
            isVisible.value = true;
         }
      }, 5000);
    }
  }
});

const installPwa = async () => {
  if (deferredPrompt) {
    // Show the install prompt
    deferredPrompt.prompt();
    // Wait for the user to respond to the prompt
    const { outcome } = await deferredPrompt.userChoice;
    if (outcome === 'accepted') {
      isVisible.value = false;
    }
    // We've used the prompt, and can't use it again, throw it away
    deferredPrompt = null;
  } else {
    // Fallback if no deferred prompt (tell them to use browser menu)
    alert(__('use_browser_menu_to_install') || 'يرجى استخدام قائمة المتصفح (Add to Home Screen) لتثبيت التطبيق.');
    isVisible.value = false;
  }
};

const dismissPrompt = () => {
  localStorage.setItem('pwaPromptDismissed_v1', Date.now().toString());
  isVisible.value = false;
};
</script>

<style scoped>
.pwa-prompt {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  background-color: var(--surface, #fff);
  padding: 16px;
  box-shadow: 0 -10px 25px rgba(0, 0, 0, 0.15);
  z-index: 999995; /* Above cookies if both appear */
  display: flex;
  flex-direction: column;
  gap: 12px;
  border-top-left-radius: 20px;
  border-top-right-radius: 20px;
}

.pwa-header {
  position: absolute;
  top: 10px;
  right: 10px;
}
[dir="ltr"] .pwa-header {
  right: auto;
  left: 10px;
}

.pwa-close {
  background: var(--bg, #f5f5f5);
  border: none;
  width: 30px;
  height: 30px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 16px;
  color: var(--text2, #666);
  cursor: pointer;
}

.pwa-content {
  display: flex;
  align-items: center;
  gap: 15px;
  margin-top: 10px;
}

.pwa-icon {
  width: 50px;
  height: 50px;
  border-radius: 12px;
  object-fit: contain;
  border: 1px solid var(--border, #eee);
  padding: 4px;
}

.pwa-info h4 {
  margin: 0 0 4px 0;
  font-size: 16px;
  font-weight: bold;
}

.pwa-info p {
  margin: 0;
  font-size: 13px;
  color: var(--text2, #666);
  line-height: 1.4;
}

.pwa-instructions {
  background: var(--bg, #f9f9f9);
  padding: 12px;
  border-radius: 10px;
  font-size: 13px;
  color: var(--text, #333);
}

.pwa-instructions p {
  margin: 0 0 8px 0;
  font-weight: bold;
}

.pwa-instructions ol {
  margin: 0;
  padding-right: 20px; /* RTL */
}
[dir="ltr"] .pwa-instructions ol {
  padding-right: 0;
  padding-left: 20px;
}
.pwa-instructions li {
  margin-bottom: 6px;
  display: flex;
  align-items: center;
}
.pwa-instructions li:last-child {
  margin-bottom: 0;
}

.pwa-actions {
  display: flex;
  justify-content: stretch;
}

.btn-install {
  flex: 1;
  padding: 12px;
  background-color: var(--primary, #172B85);
  color: #fff;
  border: none;
  border-radius: 8px;
  font-size: 15px;
  font-weight: bold;
  cursor: pointer;
}

.pwa-slide-enter-active,
.pwa-slide-leave-active {
  transition: transform 0.4s cubic-bezier(0.4, 0, 0.2, 1);
}

.pwa-slide-enter-from,
.pwa-slide-leave-to {
  transform: translateY(100%);
}
</style>

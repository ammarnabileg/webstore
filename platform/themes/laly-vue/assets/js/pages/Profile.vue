<template>
  <div class="page">
    <div class="nbar">
      <div class="nbar-title">{{ __('profile') }}</div>
    </div>
    
    <div class="scroll" style="padding: 16px;">
      
      <div class="profile-header">
        <div class="ph-avatar">
          <img loading="lazy" v-if="customer?.avatar" :src="customer.avatar" alt="User Avatar" style="width:100%; height:100%; border-radius:50%; object-fit:cover;" />
          <i v-else class="ti ti-user"></i>
        </div>
        <div class="ph-info">
          <h3>{{ customer ? customer.name : (__('guest') || 'ضيف') }}</h3>
          <p>{{ customer ? customer.email : (__('please_login') || 'يرجى تسجيل الدخول') }}</p>
        </div>
      </div>

      <div class="profile-links">
        <router-link v-if="!customer" to="/login" class="pl-item" style="text-decoration: none; color: inherit;">
          <div class="pl-icon"><i class="ti ti-login"></i></div>
          <div class="pl-text">{{ __('login_register') || 'تسجيل الدخول / إنشاء حساب' }}</div>
          <i class="ti ti-chevron-left pl-arrow" :class="{ 'ti-chevron-right': !botbleData.is_rtl }"></i>
        </router-link>
        <router-link to="/wishlist" class="pl-item" style="text-decoration: none; color: inherit;">
          <div class="pl-icon"><i class="ti ti-heart"></i></div>
          <div class="pl-text">{{ __('wishlist') || 'المفضلة' }}</div>
          <i class="ti ti-chevron-left pl-arrow" :class="{ 'ti-chevron-right': !botbleData.is_rtl }"></i>
        </router-link>
        <a v-if="customer" :href="botbleData.ordersUrl" class="pl-item" style="text-decoration: none; color: inherit;">
          <div class="pl-icon"><i class="ti ti-truck"></i></div>
          <div class="pl-text">{{ __('my_orders') || 'طلباتي' }}</div>
          <i class="ti ti-chevron-left pl-arrow" :class="{ 'ti-chevron-right': !botbleData.is_rtl }"></i>
        </a>
        <a v-if="customer" :href="botbleData.accountUrl" class="pl-item" style="text-decoration: none; color: inherit;">
          <div class="pl-icon"><i class="ti ti-settings"></i></div>
          <div class="pl-text">{{ __('settings') || 'الإعدادات' }}</div>
          <i class="ti ti-chevron-left pl-arrow" :class="{ 'ti-chevron-right': !botbleData.is_rtl }"></i>
        </a>
        <a v-if="customer && botbleData.addressesUrl" :href="botbleData.addressesUrl" class="pl-item" style="text-decoration: none; color: inherit;">
          <div class="pl-icon"><i class="ti ti-map-pin"></i></div>
          <div class="pl-text">{{ __('addresses') || 'العناوين' }}</div>
          <i class="ti ti-chevron-left pl-arrow" :class="{ 'ti-chevron-right': !botbleData.is_rtl }"></i>
        </a>
        <router-link to="/order-tracking" class="pl-item" style="text-decoration: none; color: inherit;">
          <div class="pl-icon"><i class="ti ti-map-search"></i></div>
          <div class="pl-text">{{ __('track_order') || 'تتبع الطلب' }}</div>
          <i class="ti ti-chevron-left pl-arrow" :class="{ 'ti-chevron-right': !botbleData.is_rtl }"></i>
        </router-link>
        <a v-if="customer && botbleData.reviewsUrl" :href="botbleData.reviewsUrl" class="pl-item" style="text-decoration: none; color: inherit;">
          <div class="pl-icon"><i class="ti ti-star"></i></div>
          <div class="pl-text">{{ __('my_reviews') || 'تقييماتي' }}</div>
          <i class="ti ti-chevron-left pl-arrow" :class="{ 'ti-chevron-right': !botbleData.is_rtl }"></i>
        </a>
        <a v-if="customer && botbleData.downloadsUrl" :href="botbleData.downloadsUrl" class="pl-item" style="text-decoration: none; color: inherit;">
          <div class="pl-icon"><i class="ti ti-download"></i></div>
          <div class="pl-text">{{ __('downloads') || 'التنزيلات' }}</div>
          <i class="ti ti-chevron-left pl-arrow" :class="{ 'ti-chevron-right': !botbleData.is_rtl }"></i>
        </a>
        <a v-if="customer && botbleData.changePasswordUrl" :href="botbleData.changePasswordUrl" class="pl-item" style="text-decoration: none; color: inherit;">
          <div class="pl-icon"><i class="ti ti-lock"></i></div>
          <div class="pl-text">{{ __('change_password') || 'تغيير كلمة المرور' }}</div>
          <i class="ti ti-chevron-left pl-arrow" :class="{ 'ti-chevron-right': !botbleData.is_rtl }"></i>
        </a>
        <div class="pl-item" @click="toggleDarkMode">
          <div class="pl-icon"><i :class="isDark ? 'ti ti-sun' : 'ti ti-moon'"></i></div>
          <div class="pl-text">{{ __('dark_mode') || 'الوضع الليلي' }}</div>
          <div class="toggle-switch" :class="{ active: isDark }">
            <div class="toggle-knob"></div>
          </div>
        </div>

        <div class="pl-item" v-if="otherLanguage" @click="switchLanguage(otherLanguage.url)">
          <div class="pl-icon"><i class="ti ti-language"></i></div>
          <div class="pl-text">{{ __('language') || 'اللغة' }}</div>
          <div style="font-size: 13px; font-weight: 600; color: var(--primary);">{{ otherLanguage.name }}</div>
        </div>

        <a v-if="customer" href="javascript:void(0)" @click="doLogout" class="pl-item" style="text-decoration: none; color: var(--sale);">
          <div class="pl-icon" style="color: var(--sale); background: var(--surface-2);"><i class="ti ti-logout"></i></div>
          <div class="pl-text">{{ __('logout') || 'تسجيل الخروج' }}</div>
        </a>
      </div>

      <div style="height: 80px;"></div>
    </div>
  </div>
</template>

<script setup>
import { __ } from '../utils/i18n';
import { ref, onMounted, computed, inject } from 'vue';

const botbleData = window?.BotbleData || {};
const customer = botbleData.customer;

const isDark = ref(false);

const otherLanguage = computed(() => {
    const langs = window?.BotbleData?.languages || [];
    return langs.find(lang => !lang.active);
});

const switchLanguage = (url) => {
    window.location.href = url;
};

const doLogout = async () => {
    // POST with CSRF instead of a GET anchor, so logout can't be triggered cross-site.
    try {
        const token = document.querySelector('meta[name="csrf-token"]')?.content || '';
        const res = await fetch(botbleData.logoutPostUrl || '/logout', {
            method: 'POST',
            headers: { 'X-CSRF-TOKEN': token, 'Accept': 'application/json', 'X-Requested-With': 'XMLHttpRequest' },
        });
        let redirect = botbleData.baseUrl || '/';
        try { const j = await res.json(); if (j && j.redirect) redirect = j.redirect; } catch (e) {}
        window.location.href = redirect;
    } catch (e) {
        window.location.href = botbleData.logoutUrl || '/';
    }
};

onMounted(() => {
    isDark.value = document.documentElement.getAttribute('data-theme') === 'dark';
});

const toggleDarkMode = () => {
    isDark.value = !isDark.value;
    
    const updateTheme = () => {
        if (isDark.value) {
            document.documentElement.setAttribute('data-theme', 'dark');
            localStorage.setItem('theme', 'dark');
        } else {
            document.documentElement.removeAttribute('data-theme');
            localStorage.setItem('theme', 'light');
        }
    };

    if (document.startViewTransition) {
        document.startViewTransition(updateTheme);
    } else {
        updateTheme();
    }
};
</script>

<style scoped>
.profile-header {
  display: flex;
  align-items: center;
  padding: 20px;
  background: var(--bg);
  border-radius: 15px;
  margin-bottom: 20px;
  box-shadow: 0 2px 5px rgba(0,0,0,0.02);
  border: 1px solid var(--border2);
}
.ph-avatar {
  width: 60px;
  height: 60px;
  border-radius: 50%;
  background: var(--surface);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 30px;
  color: var(--primary);
  margin-inline-end: 15px;
}
.ph-info h3 {
  margin: 0 0 5px 0;
  color: var(--text);
}
.ph-info p {
  margin: 0;
  color: var(--text2);
  font-size: 14px;
}
.profile-links {
  background: var(--bg);
  border-radius: 15px;
  padding: 10px 0;
  box-shadow: 0 2px 5px rgba(0,0,0,0.02);
  border: 1px solid var(--border2);
}
.pl-item {
  display: flex;
  align-items: center;
  padding: 15px 20px;
  border-bottom: 1px solid var(--border2);
  cursor: pointer;
}
.pl-item:last-child {
  border-bottom: none;
}
.pl-icon {
  width: 30px;
  height: 30px;
  border-radius: 8px;
  background: var(--surface);
  display: flex;
  align-items: center;
  justify-content: center;
  color: var(--primary);
  margin-inline-end: 15px;
}
.pl-text {
  flex: 1;
  font-weight: 500;
}
.pl-arrow {
  color: var(--text3);
}
.toggle-switch {
  width: 44px;
  height: 24px;
  background: var(--surface2);
  border-radius: 12px;
  position: relative;
  transition: all 0.3s;
}
.toggle-switch.active {
  background: var(--primary-strong);
}
.toggle-knob {
  width: 20px;
  height: 20px;
  background: var(--bg);
  border-radius: 50%;
  position: absolute;
  top: 2px;
  left: 2px;
  transition: all 0.3s;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}
.toggle-switch.active .toggle-knob {
  transform: translateX(20px);
}
[dir="rtl"] .toggle-switch.active .toggle-knob {
  transform: translateX(-20px);
}
[dir="rtl"] .toggle-knob {
  left: auto;
  right: 2px;
}
</style>

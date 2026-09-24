<template>
  <div class="notifications-page container my-5">
    <div class="page-header d-flex align-items-center justify-content-between mb-4">
      <div class="d-flex align-items-center gap-3">
        <div class="header-icon-box bg-primary-gradient text-white rounded-4 d-flex align-items-center justify-content-center shadow-sm" style="width: 54px; height: 54px;">
          <i class="ti ti-bell-ringing fs-2 pulse-anim"></i>
        </div>
        <div>
          <h1 class="page-title fw-bold m-0 text-dark">{{ __('notifications') || 'الإشعارات' }}</h1>
          <p class="text-muted fs-7 m-0">{{ __('notifications_subtitle') || 'تابع أحدث العروض، الخصومات والتنبيهات المخصصة لك' }}</p>
        </div>
      </div>
      <span class="badge count-badge fs-6 px-4 py-2 rounded-pill shadow-sm" v-if="notifications.length > 0">
        {{ filteredNotifications.length }} {{ __('notifications_count') || 'إشعار' }}
      </span>
    </div>

    <!-- iOS Safari Web Push Banner -->
    <div v-if="showIOSBanner" class="ios-pwa-banner d-flex align-items-center rounded-4 shadow-sm mb-4 p-4" role="alert">
      <div class="ios-icon-box flex-shrink-0 me-3">
        <i class="ti ti-device-mobile-message fs-1 text-white"></i>
      </div>
      <div class="flex-grow-1">
        <h6 class="alert-heading fw-bold mb-1 text-white">{{ __('ios_push_title') || 'تنبيه لمستخدمي آيفون (iOS)' }}</h6>
        <p class="mb-0 fs-7 text-white-50">{{ __('ios_push_desc') || 'للحصول على إشعارات العروض الفورية على هاتفك، يرجى إضافة التطبيق إلى الشاشة الرئيسية (Add to Home Screen).' }}</p>
      </div>
      <button type="button" class="btn-close btn-close-white ms-auto flex-shrink-0" @click="showIOSBanner = false"></button>
    </div>

    <!-- Filters & Search Bar -->
    <div class="filter-toolbar d-flex flex-wrap align-items-center justify-content-between gap-3 mb-4 p-3 bg-white rounded-4 shadow-sm">
      <div class="nav-tabs-custom d-flex gap-2">
        <button 
          class="btn filter-tab px-4 py-2 rounded-pill fw-semibold fs-7" 
          :class="{ 'active': activeTab === 'all' }"
          @click="activeTab = 'all'"
        >
          {{ __('all') || 'الكل' }}
        </button>
        <button 
          class="btn filter-tab px-4 py-2 rounded-pill fw-semibold fs-7" 
          :class="{ 'active': activeTab === 'recent' }"
          @click="activeTab = 'recent'"
        >
          {{ __('recent') || 'الحديثة' }}
        </button>
      </div>
      <div class="search-box flex-grow-1" style="max-width: 320px;">
        <div class="input-group input-group-custom rounded-pill overflow-hidden border">
          <span class="input-group-text bg-transparent border-0 ps-3 pe-2 text-muted">
            <i class="ti ti-search fs-5"></i>
          </span>
          <input 
            type="text" 
            class="form-control border-0 fs-7 shadow-none" 
            v-model="searchQuery" 
            :placeholder="__('search_notifications') || 'ابحث في الإشعارات...'" 
          />
          <button v-if="searchQuery" class="btn border-0 text-muted pe-3" @click="searchQuery = ''">
            <i class="ti ti-x fs-6"></i>
          </button>
        </div>
      </div>
    </div>

    <!-- Loading State -->
    <div v-if="isLoading" class="d-flex flex-column justify-content-center align-items-center my-5 py-5">
      <div class="spinner-border text-primary mb-3" role="status" style="width: 3.5rem; height: 3.5rem;"></div>
      <span class="text-muted fw-semibold fs-6">{{ __('loading') || 'جاري تحميل الإشعارات...' }}</span>
    </div>

    <!-- Empty State -->
    <div v-else-if="filteredNotifications.length === 0" class="empty-state text-center py-5 my-5 bg-white rounded-4 shadow-sm">
      <div class="empty-icon mb-4 d-inline-block p-5 bg-light rounded-circle animation-float">
        <i class="ti ti-bell-off text-muted opacity-50" style="font-size: 5rem;"></i>
      </div>
      <h3 class="fw-bold mb-2 text-dark">{{ __('no_notifications') || 'لا توجد إشعارات لعرضها' }}</h3>
      <p class="text-muted mb-4 fs-6 max-w-md mx-auto">{{ __('no_notifications_desc') || 'لم نجد أي إشعارات مطابقة للبحث أو التصفية الحالية. سنقوم بإعلامك فور توفر عروض جديدة!' }}</p>
      <button v-if="searchQuery || activeTab !== 'all'" @click="resetFilters" class="btn btn-outline-primary btn-lg rounded-pill px-5 fw-semibold">
        {{ __('reset_filters') || 'عرض كل الإشعارات' }}
      </button>
      <router-link v-else to="/products" class="btn btn-primary-gradient btn-lg rounded-pill px-5 fw-semibold shadow-sm">
        {{ __('browse_products') || 'تصفح المنتجات' }}
      </router-link>
    </div>

    <!-- Notifications List -->
    <div v-else class="notifications-list">
      <transition-group name="list" tag="div">
        <div 
          v-for="(item, index) in filteredNotifications" 
          :key="item.id || index" 
          class="notification-card bg-white rounded-4 p-4 mb-3 shadow-sm d-flex align-items-start gap-4 transition-all clickable-card"
          @click="goToTarget(item.target_url)"
          :style="`animation-delay: ${index * 0.05}s`"
        >
          <div class="notification-icon-wrapper flex-shrink-0 rounded-circle d-flex align-items-center justify-content-center shadow-sm" :class="getIconClass(item)">
            <i class="fs-2" :class="getIcon(item)"></i>
          </div>
          <div class="notification-content flex-grow-1">
            <div class="d-flex align-items-center justify-content-between mb-2">
              <div class="d-flex align-items-center gap-2">
                <h5 class="fw-bold m-0 text-dark">{{ item.title }}</h5>
                <span v-if="isRecent(item.created_at)" class="badge bg-success-subtle text-success fs-8 px-2 py-1 rounded-pill">
                  {{ __('new') || 'جديد' }}
                </span>
              </div>
              <span class="notification-time text-muted fs-7 d-flex align-items-center gap-1">
                <i class="ti ti-clock"></i>{{ item.created_at }}
              </span>
            </div>
            <p class="text-muted mb-0 fs-6 pe-md-4">{{ item.description }}</p>
          </div>
          <div class="notification-action flex-shrink-0 align-self-center">
            <button class="btn btn-light rounded-circle p-3 text-primary action-btn d-flex align-items-center justify-content-center shadow-sm">
              <i class="ti ti-arrow-left fs-5" :class="{'ti-arrow-right': !isRtl}"></i>
            </button>
          </div>
        </div>
      </transition-group>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue';
import { useRouter } from 'vue-router';

const router = useRouter();
const notifications = ref([]);
const isLoading = ref(true);
const showIOSBanner = ref(false);
const activeTab = ref('all');
const searchQuery = ref('');
const isRtl = window.BotbleData?.is_rtl !== false;

onMounted(async () => {
  checkIOS();
  await fetchNotifications();
});

const checkIOS = () => {
  const isIOS = /iPad|iPhone|iPod/.test(navigator.userAgent) && !window.MSStream;
  const isStandalone = window.navigator.standalone === true;
  if (isIOS && !isStandalone) {
    showIOSBanner.value = true;
  }
};

const fetchNotifications = async () => {
  isLoading.value = true;
  try {
    const response = await fetch('/ajax/vue/notifications');
    const data = await response.json();
    notifications.value = data.data || [];
  } catch (error) {
    console.error('Error fetching notifications:', error);
  } finally {
    isLoading.value = false;
  }
};

const resetFilters = () => {
  searchQuery.value = '';
  activeTab.value = 'all';
};

const isRecent = (dateStr) => {
  if (!dateStr) return false;
  return dateStr.includes('second') || dateStr.includes('minute') || dateStr.includes('hour') || dateStr.includes('ثانية') || dateStr.includes('دقيقة') || dateStr.includes('ساعة');
};

const filteredNotifications = computed(() => {
  let list = notifications.value;

  if (activeTab.value === 'recent') {
    list = list.filter(item => isRecent(item.created_at));
  }

  if (searchQuery.value.trim()) {
    const q = searchQuery.value.toLowerCase();
    list = list.filter(item => 
      (item.title && item.title.toLowerCase().includes(q)) || 
      (item.description && item.description.toLowerCase().includes(q))
    );
  }

  return list;
});

const getIcon = (item) => {
  const title = (item.title || '').toLowerCase();
  const desc = (item.description || '').toLowerCase();
  if (title.includes('عرض') || title.includes('sale') || title.includes('خصم') || title.includes('discount')) {
    return 'ti ti-discount-check';
  } else if (title.includes('طلب') || title.includes('order') || desc.includes('طلب')) {
    return 'ti ti-package';
  } else if (title.includes('حساب') || title.includes('account')) {
    return 'ti ti-user-shield';
  }
  return 'ti ti-bell-ringing';
};

const getIconClass = (item) => {
  const title = (item.title || '').toLowerCase();
  if (title.includes('عرض') || title.includes('sale') || title.includes('خصم') || title.includes('discount')) {
    return 'bg-warning-subtle text-warning';
  } else if (title.includes('طلب') || title.includes('order')) {
    return 'bg-success-subtle text-success';
  }
  return 'bg-primary-subtle text-primary';
};

const goToTarget = (url) => {
  if (url) {
    if (url.startsWith('http')) {
      window.location.href = url;
    } else {
      router.push(url);
    }
  }
};
</script>

<style scoped>
.notifications-page {
  max-width: 860px;
}

/* Gradients & Colors */
.bg-primary-gradient {
  background: linear-gradient(135deg, var(--primary, #172B85), var(--primary-light, #5A73EB));
}
.btn-primary-gradient {
  background: linear-gradient(135deg, var(--primary, #172B85), var(--primary-light, #5A73EB));
  color: #fff;
  border: none;
  transition: all 0.3s ease;
}
.btn-primary-gradient:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 20px rgba(23, 43, 133, 0.3);
  color: #fff;
}
.count-badge {
  background: linear-gradient(135deg, #f0f3ff, #e0e7ff);
  color: var(--primary, #172B85);
  border: 1px solid rgba(23, 43, 133, 0.1);
  font-weight: 700;
}

/* iOS Banner */
.ios-pwa-banner {
  background: linear-gradient(135deg, #2563eb, #3b82f6);
  box-shadow: 0 10px 25px rgba(37, 99, 235, 0.25);
}
.ios-icon-box {
  width: 52px;
  height: 52px;
  background: rgba(255, 255, 255, 0.2);
  border-radius: 16px;
  display: flex;
  align-items: center;
  justify-content: center;
  backdrop-filter: blur(8px);
}

/* Toolbar & Tabs */
.filter-toolbar {
  border: 1px solid rgba(0, 0, 0, 0.04);
}
.filter-tab {
  color: var(--text-color, #64748b);
  border: none;
  background: transparent;
  transition: all 0.25s ease;
}
.filter-tab:hover {
  background: rgba(0, 0, 0, 0.03);
}
.filter-tab.active {
  background: var(--primary, #172B85);
  color: #fff;
  box-shadow: 0 4px 12px rgba(23, 43, 133, 0.2);
}
.input-group-custom {
  background: var(--bg-color, #f8fafc);
  border-color: rgba(0, 0, 0, 0.08) !important;
  transition: all 0.3s ease;
}
.input-group-custom:focus-within {
  background: #fff;
  border-color: var(--primary, #172B85) !important;
  box-shadow: 0 0 0 4px rgba(23, 43, 133, 0.1);
}

/* Notification Cards */
.notification-card {
  border: 1px solid rgba(0, 0, 0, 0.04);
  cursor: pointer;
  position: relative;
  overflow: hidden;
  backdrop-filter: blur(10px);
}
.notification-card::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 3px;
  background: transparent;
  transition: all 0.3s ease;
}
.notification-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 15px 30px rgba(0, 0, 0, 0.08) !important;
  border-color: rgba(23, 43, 133, 0.15);
}
.notification-card:hover::before {
  background: linear-gradient(90deg, var(--primary, #172B85), var(--primary-light, #5A73EB));
}
.notification-card:hover .action-btn {
  background: linear-gradient(135deg, var(--primary, #172B85), var(--primary-light, #5A73EB)) !important;
  color: white !important;
  transform: scale(1.1);
}
.notification-icon-wrapper {
  width: 60px;
  height: 60px;
  transition: transform 0.3s ease;
}
.notification-card:hover .notification-icon-wrapper {
  transform: scale(1.08) rotate(5deg);
}

/* Action Button */
.action-btn {
  width: 44px;
  height: 44px;
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

/* Colors & Badges */
.bg-warning-subtle { background-color: rgba(245, 158, 11, 0.12) !important; }
.text-warning { color: #d97706 !important; }
.bg-success-subtle { background-color: rgba(16, 185, 129, 0.12) !important; }
.text-success { color: #059669 !important; }
.bg-primary-subtle { background-color: rgba(23, 43, 133, 0.1) !important; }
.text-primary { color: var(--primary, #172B85) !important; }

/* Micro-Animations */
@keyframes float {
  0% { transform: translateY(0px); }
  50% { transform: translateY(-10px); }
  100% { transform: translateY(0px); }
}
.animation-float {
  animation: float 4s ease-in-out infinite;
}
@keyframes pulse {
  0% { transform: scale(1); }
  50% { transform: scale(1.15); }
  100% { transform: scale(1); }
}
.pulse-anim {
  animation: pulse 2.5s infinite ease-in-out;
}

/* Transitions */
.transition-all {
  transition: all 0.3s ease;
}
.list-enter-active, .list-leave-active {
  transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
}
.list-enter-from {
  opacity: 0;
  transform: translateY(30px) scale(0.95);
}
.list-leave-to {
  opacity: 0;
  transform: translateY(-30px) scale(0.95);
}

.fs-7 { font-size: 0.875rem; }
.fs-8 { font-size: 0.75rem; }
.max-w-md { max-width: 480px; }
</style>

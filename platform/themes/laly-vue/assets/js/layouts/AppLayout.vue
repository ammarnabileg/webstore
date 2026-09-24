<template>
  <div class="app-wrapper" :class="{ 'sidebar-collapsed': isSidebarCollapsed }">
    <!-- Top Bar -->
    <div class="site-topbar">
      <div class="container-fluid">
        <div class="st-inner">
          <div class="st-left">
            <img :src="topbarLogo" alt="Main Company Logo" class="st-logo" v-if="topbarLogo" />
          </div>
          <div class="st-right">
            <a v-if="hotline" :href="`tel:${hotline}`" class="st-contact"><i class="ti ti-phone"></i> {{ hotline }}</a>
            <a v-if="email" :href="`mailto:${email}`" class="st-contact"><i class="ti ti-mail"></i> {{ email }}</a>
            <span v-if="address" class="st-contact"><i class="ti ti-map-pin"></i> {{ address }}</span>
          </div>
        </div>
      </div>
    </div>
    
    <!-- Desktop Header (Hidden on Mobile) -->
    <header class="desktop-header">
      <div class="container-fluid">
        <div class="dh-top">
            <div class="dh-logo" @click="$router.push('/')">
              <img :src="siteLogo" alt="">
            </div>
            
            <div class="dh-search" style="position: relative;">
              <input type="text" v-model="searchQuery" :placeholder="__('search_placeholder')" @keyup.enter="doSearch()" @input="onSearchInput" @focus="showLiveSearch = true" @blur="hideLiveSearchDelay" />
              <button @click="doSearch()"><i class="ti ti-search"></i></button>
              
              <!-- Live Search Dropdown - Tech Mega Search -->
              <div class="live-search-dropdown tech-search-dropdown" v-if="showLiveSearch && (searchQuery.length > 1)">
                <div v-if="isSearching" class="ls-loading">
                  <div class="spinner" style="width: 20px; height: 20px; border-width: 2px;"></div>
                  <span>{{ __('loading') || 'جاري معالجة البيانات...' }}</span>
                </div>
                <div v-else-if="liveSearchResults.length > 0" class="ls-mega-layout">
                  <!-- Suggested Brands / Categories Panel -->
                  <div class="ls-sidebar">
                    <div class="ls-sidebar-title"><i class="ti ti-tags"></i> ذو صلة</div>
                    <div class="ls-badges">
                       <span class="ls-badge" @click="searchQuery = 'Asus'">Asus</span>
                       <span class="ls-badge" @click="searchQuery = 'RTX 4090'">RTX 4090</span>
                       <span class="ls-badge" @click="searchQuery = 'Canon'">Canon EOS</span>
                       <span class="ls-badge" @click="searchQuery = 'DDR5'">DDR5</span>
                    </div>
                  </div>
                  <!-- Products Panel -->
                  <div class="ls-products-panel">
                    <div class="ls-item" v-for="product in liveSearchResults" :key="product.id" @click.stop="goToProduct(product.slug)">
                      <img :src="product.image || botbleData?.placeholderImage || 'https://via.placeholder.com/50'" :alt="product.name" />
                      <div class="ls-info">
                        <div class="ls-name">{{ product.name }}</div>
                        <div class="ls-specs" v-if="product.sku">SKU: {{ product.sku }}</div>
                        <div class="ls-price">{{ product.front_sale_price_format || product.price_format || product.price }}</div>
                      </div>
                    </div>
                    <div class="ls-footer" @click.stop="doSearch()">
                      {{ __('view_all_results') || 'عرض كل النتائج لـ' }} "{{ searchQuery }}" <i class="ti ti-arrow-left" :class="{'ti-arrow-right': !isRtl}"></i>
                    </div>
                  </div>
                </div>
                <div v-else class="ls-empty">
                  لا توجد نتائج مطابقة لبحثك. جرب البحث بمواصفات أخرى.
                </div>
              </div>
            </div>

            <div class="dh-actions">
              <!-- Language Switcher -->
              <div class="dh-lang" v-if="siteLanguages && siteLanguages.length > 1">
                <a 
                  v-for="lang in siteLanguages.filter(l => !l.active)" 
                  :key="lang.code" 
                  :href="lang.url"
                  class="dh-icon dh-lang-btn"
                  :title="lang.name"
                  style="text-decoration:none; display:flex; align-items:center; gap:4px; font-weight:700; font-size:14px; text-transform:uppercase;"
                >
                  <i class="ti ti-world"></i>
                  <span>{{ lang.code }}</span>
                </a>
              </div>

              <!-- Dark Mode Switcher -->
              <a href="javascript:void(0)" class="dh-icon dh-dark-btn" @click.prevent="toggleDarkMode" title="تغيير المظهر">
                <i class="ti" :class="isDarkMode ? 'ti-sun' : 'ti-moon'"></i>
              </a>

              <router-link to="/notifications" class="dh-icon dh-notification">
                <i class="ti ti-bell"></i>
                <span class="dh-badge" v-if="hasNewNotifications"></span>
              </router-link>
              <router-link to="/profile" class="dh-icon">
                <i class="ti ti-user"></i>
              </router-link>
              <router-link to="/cart" class="dh-icon dh-cart">
                <i class="ti ti-shopping-cart"></i>
                <span class="dh-badge" v-if="store.cartCount">{{ store.cartCount }}</span>
              </router-link>
            </div>
          </div>
          
          <div class="dh-bottom">
            <div class="dh-nav">
              <router-link to="/">{{ __('home') }}</router-link>
              <router-link to="/products">{{ __('products') }}</router-link>
              <router-link to="/categories">{{ __('categories') }}</router-link>
            </div>
          </div>
        </div>
      </header>

      <div class="desktop-layout">
        <!-- Desktop Sidebar (Hidden on Mobile) -->
        <aside class="desktop-sidebar-fixed">
          <MegaMenu :is-collapsed="isSidebarCollapsed" @toggle="toggleSidebar" @hover="handleSidebarHover" />
        </aside>

        <div class="app-main-content">
          <div class="page-container">
        <router-view v-slot="{ Component }">
          <transition name="fade" mode="out-in">
            <component :is="Component" :key="$route.fullPath" />
          </transition>
        </router-view>

        <!-- Bottom Navigation (Hidden on Desktop) -->
        <div class="tabbar">
          <router-link to="/" class="tb-item" active-class="active">
            <i class="ti ti-home"></i>
            <span>{{ __('home') }}</span>
          </router-link>
          <router-link to="/categories" class="tb-item" active-class="active">
            <i class="ti ti-category"></i>
            <span>{{ __('categories') }}</span>
          </router-link>
          <router-link to="/search" class="tb-item" active-class="active">
            <i class="ti ti-search"></i>
            <span>{{ __('search') }}</span>
          </router-link>
          <router-link to="/notifications" class="tb-item" active-class="active">
            <div class="tb-badge">
              <i class="ti ti-bell"></i>
              <div class="tb-badge-dot" v-if="hasNewNotifications"></div>
            </div>
            <span>{{ __('notifications') || 'الإشعارات' }}</span>
          </router-link>
          <router-link to="/cart" class="tb-item" active-class="active">
            <div class="tb-badge">
              <i class="ti ti-shopping-cart"></i>
              <div class="tb-badge-dot" v-if="store.cartCount"></div>
            </div>
            <span>{{ __('cart') }}</span>
          </router-link>
          <router-link to="/profile" class="tb-item" active-class="active">
            <i class="ti ti-user"></i>
            <span>{{ __('profile') }}</span>
          </router-link>
        </div>
        
      <footer class="desktop-footer">
        <div class="container">
          <div style="max-width: 1200px; margin: 0 auto; display: flex; justify-content: space-between; align-items: center;">
            <div>&copy; 2026 {{ siteTitle }}. {{ __('all_rights_reserved') }}</div>
            <div style="display: flex; gap: 20px;">
              <router-link to="/">{{ __('home') }}</router-link>
              <router-link to="/products">{{ __('products') }}</router-link>
              <router-link to="/categories">{{ __('categories') }}</router-link>
            </div>
          </div>
        </div>
      </footer>
    </div>
  </div>
  </div>
  <ToastNotifications />
  <QuickViewModal />
  <MobileSplashScreen @finished="handleSplashFinished" />
  <MobileOnboarding v-if="showOnboarding" @finished="handleOnboardingFinished" />
  <CookieConsent v-if="appReady" />
  <PwaInstallPrompt v-if="appReady" />
</div>
</template>

<script setup>
import { onMounted, ref, watch } from 'vue';
import { useRouter, useRoute } from 'vue-router';
import { useEcommerceStore } from '../stores/ecommerce';
import MegaMenu from '../components/MegaMenu.vue';
import ToastNotifications from '../components/ToastNotifications.vue';
import QuickViewModal from '../components/QuickViewModal.vue';
import MobileSplashScreen from '../components/MobileSplashScreen.vue';
import MobileOnboarding from '../components/MobileOnboarding.vue';
import CookieConsent from '../components/CookieConsent.vue';
import PwaInstallPrompt from '../components/PwaInstallPrompt.vue';
import { initFirebase } from '../services/firebase';

const router = useRouter();
const route = useRoute();
const store = useEcommerceStore();

const siteLogo = window.BotbleData?.logo || 'https://brilliant-kw.com/storage/logo.png';
const topbarLogo = window.BotbleData?.topbarLogo || siteLogo;
const siteTitle = window.BotbleData?.site_title || 'Laly Kuwait';
const hotline = window.BotbleData?.hotline || '';
const email = window.BotbleData?.email || '';
const address = window.BotbleData?.address || '';
const siteLanguages = window.BotbleData?.languages || [];
const isRtl = window.BotbleData?.is_rtl !== false;

const isDarkMode = ref(false);

const toggleDarkMode = () => {
    isDarkMode.value = !isDarkMode.value;
    if (isDarkMode.value) {
        document.documentElement.setAttribute('data-theme', 'dark');
        localStorage.setItem('theme', 'dark');
    } else {
        document.documentElement.removeAttribute('data-theme');
        localStorage.setItem('theme', 'light');
    }
};

const isSidebarCollapsed = ref(true);
const userToggled = ref(false);
const hasNewNotifications = ref(false);
const showOnboarding = ref(false);
const appReady = ref(false);

const handleSplashFinished = () => {
    if (window.innerWidth <= 768) {
        const hasSeenOnboarding = localStorage.getItem('hasSeenOnboarding_v1');
        if (!hasSeenOnboarding) {
            showOnboarding.value = true;
        } else {
            appReady.value = true;
        }
    } else {
        appReady.value = true;
    }
};

const handleOnboardingFinished = () => {
    showOnboarding.value = false;
    appReady.value = true;
};

onMounted(() => {
    isDarkMode.value = localStorage.getItem('theme') === 'dark';

    store.fetchCart();
    checkRoute();

    const firebaseConfig = window.BotbleData?.firebase_config || {
        apiKey: window.BotbleData?.fcm_api_key || "",
        projectId: window.BotbleData?.fcm_project_id || "",
        messagingSenderId: window.BotbleData?.fcm_sender_id || "",
        appId: window.BotbleData?.fcm_app_id || "",
        vapidKey: window.BotbleData?.fcm_vapid_key || ""
    };
    initFirebase(firebaseConfig);

    window.showToast = ({ title, message, type = 'info', duration = 4000 }) => {
        store.notify(`${title ? title + ' - ' : ''}${message}`, type, duration);
    };

    window.addEventListener('fcm-notification', (e) => {
        hasNewNotifications.value = true;
        window.showToast({ title: e.detail.title, message: e.detail.body, type: 'info' });
    });
});

watch(() => route.path, (newPath) => {
    checkRoute();
    if (newPath === '/notifications') {
        hasNewNotifications.value = false;
    }
});

const checkRoute = () => {
    if (userToggled.value) return; // Keep user preference
    
    // Always collapse on all pages by default
    isSidebarCollapsed.value = true;
};

const toggleSidebar = () => {
    userToggled.value = true;
    isSidebarCollapsed.value = !isSidebarCollapsed.value;
};

const handleSidebarHover = (shouldCollapse) => {
    if (!userToggled.value) {
        isSidebarCollapsed.value = shouldCollapse;
    }
};

const searchQuery = ref('');
const showLiveSearch = ref(false);
const liveSearchResults = ref([]);
const isSearching = ref(false);
let searchTimeout = null;

const onSearchInput = () => {
    showLiveSearch.value = true;
    if (searchTimeout) clearTimeout(searchTimeout);
    
    if (searchQuery.value.trim().length > 1) {
        isSearching.value = true;
        searchTimeout = setTimeout(async () => {
            try {
                // we can fetch a small number of products
                const response = await fetch(`/ajax/vue/products?q=${encodeURIComponent(searchQuery.value)}&per_page=5`);
                const data = await response.json();
                liveSearchResults.value = data.data || [];
            } catch (err) {
                console.error(err);
            } finally {
                isSearching.value = false;
            }
        }, 400);
    } else {
        liveSearchResults.value = [];
        isSearching.value = false;
    }
};

const hideLiveSearchDelay = () => {
    setTimeout(() => {
        showLiveSearch.value = false;
    }, 200);
};

const goToProduct = (slug) => {
    showLiveSearch.value = false;
    router.push(`/product/${slug}`);
};

const doSearch = () => {
    if (searchQuery.value) {
        showLiveSearch.value = false;
        router.push({ path: '/search', query: { q: searchQuery.value } });
    }
};
</script>

<style>
.live-search-dropdown {
  position: absolute;
  top: 100%;
  left: 0;
  right: 0;
  background: var(--bg);
  border-radius: 12px;
  box-shadow: 0 10px 30px rgba(0,0,0,0.2);
  margin-top: 10px;
  z-index: 1000;
  overflow: hidden;
  border: 1px solid var(--border);
}
.tech-search-dropdown {
  width: 150%;
  right: -25%; /* Expand wider than input for Mega effect */
  left: auto;
}
[dir="ltr"] .tech-search-dropdown {
  left: -25%;
  right: auto;
}
.ls-mega-layout {
  display: flex;
}
.ls-sidebar {
  width: 30%;
  background: var(--surface2);
  padding: 15px;
  border-inline-end: 1px solid var(--border);
}
.ls-sidebar-title {
  font-size: 13px;
  font-weight: 700;
  color: var(--text3);
  margin-bottom: 10px;
  display: flex;
  align-items: center;
  gap: 5px;
}
.ls-badges {
  display: flex;
  flex-direction: column;
  gap: 8px;
}
.ls-badge {
  font-size: 12px;
  padding: 6px 10px;
  background: var(--surface);
  border: 1px solid var(--border);
  border-radius: 6px;
  cursor: pointer;
  transition: all 0.2s;
  color: var(--text2);
}
.ls-badge:hover {
  background: var(--primary);
  color: #fff;
  border-color: var(--primary);
}
.ls-products-panel {
  flex: 1;
}
.ls-loading {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 10px;
  padding: 30px;
  color: var(--primary);
  font-size: 14px;
  font-weight: 600;
}
.ls-empty {
  padding: 30px;
  text-align: center;
  color: var(--text3);
  font-size: 14px;
}
.ls-item {
  display: flex;
  align-items: center;
  padding: 12px 15px;
  gap: 12px;
  cursor: pointer;
  border-bottom: 1px solid var(--border2);
  transition: background 0.2s;
}
.ls-item:hover {
  background: var(--surface);
}
.ls-item img {
  width: 45px;
  height: 45px;
  object-fit: contain;
  border-radius: 6px;
  background: var(--bg);
  border: 1px solid var(--border2);
}
.ls-info {
  flex: 1;
}
.ls-name {
  font-size: 14px;
  font-weight: 600;
  color: var(--text);
  margin-bottom: 2px;
  display: -webkit-box;
  -webkit-line-clamp: 1;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
.ls-specs {
  font-size: 11px;
  color: var(--text3);
  margin-bottom: 4px;
}
.ls-price {
  font-size: 14px;
  font-weight: 800;
  color: var(--primary);
}
.ls-footer {
  text-align: center;
  padding: 12px;
  background: var(--surface);
  font-size: 13px;
  font-weight: 700;
  color: var(--primary);
  cursor: pointer;
  transition: background 0.2s;
}
.ls-footer:hover {
  background: var(--surface2);
}
@media (max-width: 768px) {
  .tech-search-dropdown {
    width: 100%;
    right: 0;
    left: 0;
  }
  .ls-mega-layout {
    flex-direction: column;
  }
  .ls-sidebar {
    width: 100%;
    border-inline-end: none;
    border-bottom: 1px solid var(--border);
    display: flex;
    overflow-x: auto;
    padding: 10px;
    align-items: center;
  }
  .ls-sidebar-title { margin-bottom: 0; margin-inline-end: 10px; white-space: nowrap; }
  .ls-badges { flex-direction: row; }
}
</style>

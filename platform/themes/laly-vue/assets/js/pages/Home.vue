<template>
  <div class="page">
    <div class="nbar">
      <div class="nbar-title">
        <img :src="siteLogo" alt="Logo" style="height: 35px; max-width: 150px; object-fit: contain;">
      </div>
      <div class="nbar-actions">
        <button @click="$router.push('/search')" :aria-label="__('search') || 'بحث'"><i class="ti ti-search"></i></button>
        <button @click="$router.push('/cart')" :aria-label="__('cart') || 'السلة'"><i class="ti ti-shopping-cart"></i></button>
      </div>
    </div>
    <div class="scroll">
      
      <div v-if="loadingPage" class="prods-grid" style="padding: 20px;">
        <SkeletonLoader v-for="i in 4" :key="i" type="product" style="height: 280px;" />
      </div>

      <!-- Dynamic Blocks from CMS -->
      <template v-else-if="pageBlocks.length > 0">
        <PageBlocks :blocks="pageBlocks" @quickview="openQuickView" />
      </template>
      
      <!-- Fallback Layout if CMS Page is empty -->
      <template v-else>
        <!-- Dynamic Hero Banners -->
        <div class="hero-slider-wrapper" v-if="homeSliders && homeSliders.length">
          <div class="hero-scroll-container" ref="sliderContainer" @scroll="handleSliderScroll">
            <div 
              class="home-hero dynamic-hero" 
              v-for="(slider, index) in homeSliders" 
              :key="slider.id"
              @click="slider.link ? goToLink(slider.link) : null"
            >
              <picture>
                <source :srcset="slider.image" media="(min-width: 768px)" />
                <img loading="lazy" :src="slider.mobile_image || slider.image" :alt="slider.title || ''" class="hero-img" />
              </picture>
            </div>
          </div>
          
          <!-- Pagination Dots -->
          <div class="hero-pagination" v-if="homeSliders.length > 1">
            <span 
              v-for="(slider, index) in homeSliders" 
              :key="'dot-' + index"
              class="hero-dot"
              :class="{ 'active': currentSlide === index }"
              @click="goToSlide(index)"
            ></span>
          </div>
        </div>
      
      <!-- Fallback Hero Banner -->
      <div class="home-hero" v-else>
        <div class="home-hero-tag">{{ __('offers_week') || 'عروض الأسبوع' }}</div>
        <div class="home-hero-title" v-html="__('hero_title') || 'تقنية WiFi 6E<br>أسرع شبكة'"></div>
        <div class="home-hero-sub">{{ __('hero_sub') || 'خصومات تصل لـ 33% على الراوترات' }}</div>
        <div class="home-hero-btn" @click="$router.push('/products')">
          <span>{{ __('shop_now') || 'تسوّق الآن' }}</span>
          <i class="ti ti-arrow-left" :class="{ 'ti-arrow-right': !isRtl }" style="font-size:14px;"></i>
        </div>
        <div class="hero-circle"></div>
        <div class="hero-circle2"></div>
      </div>
      
      <!-- Tech Trust Badges -->
      <div class="tech-trust-bar">
        <div class="trust-item">
          <i class="ti ti-shield-check"></i>
          <div>
            <h4>{{ __('comprehensive_warranty') || 'ضمان شامل' }}</h4>
            <p>{{ __('warranty_desc') || 'سنتين على الأجهزة' }}</p>
          </div>
        </div>
        <div class="trust-item">
          <i class="ti ti-truck-delivery"></i>
          <div>
            <h4>{{ __('secure_delivery') || 'توصيل آمن' }}</h4>
            <p>{{ __('delivery_desc') || 'للمعدات الحساسة' }}</p>
          </div>
        </div>
        <div class="trust-item">
          <i class="ti ti-headset"></i>
          <div>
            <h4>{{ __('tech_support') || 'دعم فني' }}</h4>
            <p>{{ __('support_desc') || 'خبراء تقنيين' }}</p>
          </div>
        </div>
      </div>

      <!-- Entry point to the "Know your system" lead wizard -->
      <router-link to="/project-wizard" class="wizard-cta">
        <i class="ti ti-device-cctv" aria-hidden="true"></i>
        <span class="wizard-cta-text">
          <strong>{{ __('wizard_cta_title') }}</strong>
          <small>{{ __('wizard_cta_sub') }}</small>
        </span>
        <i class="ti ti-chevron-left wizard-cta-arrow" aria-hidden="true"></i>
      </router-link>

      <!-- Categories Hierarchy -->
      <div class="sblock home-cats">
        <div class="d-flex justify-content-between align-items-center mb-3">
          <h2 class="sec-title mb-0">{{ __('categories') }}</h2>
          <router-link to="/categories" class="text-primary text-decoration-none fw-bold" style="font-size: 14px;">{{ __('View All') || 'عرض الكل' }}</router-link>
        </div>
        
        <!-- Level 0 (Featured Root Categories) -->
        <div class="position-relative" v-if="!store.loading">
          <!-- Left Arrow -->
          <button class="cat-nav-btn cat-nav-prev" @click="scrollCats('left')" aria-label="Previous">
            <i class="ti" :class="isRtl ? 'ti-chevron-right' : 'ti-chevron-left'"></i>
          </button>

          <div class="filter-scroll cats-scroll" ref="catsScrollContainer">
            <router-link :to="`/product-categories/${cat.slug}`" class="cat-item animated-card" v-for="cat in store.featuredRootCategories" :key="cat.id" style="text-decoration: none; color: inherit;">
              <div class="cat-card-inner">
                <div class="cat-img">
                  <img loading="lazy" v-if="cat.image" :src="cat.image" :alt="cat.name">
                  <i v-else class="ti ti-category"></i>
                </div>
                <span class="cat-name">{{ cat.name }}</span>
              </div>
            </router-link>
          </div>

          <!-- Right Arrow -->
          <button class="cat-nav-btn cat-nav-next" @click="scrollCats('right')" aria-label="Next">
            <i class="ti" :class="isRtl ? 'ti-chevron-left' : 'ti-chevron-right'"></i>
          </button>
        </div>
        <div v-if="store.loading" class="filter-scroll cats-scroll">
          <SkeletonLoader v-for="i in 5" :key="i" type="category" />
        </div>
      </div>
      
      <!-- Home Banners -->
      <div class="sblock home-banners" v-if="homeBanners && homeBanners.length > 0">
        <div class="row gx-3">
          <div class="col-md-6 mb-3 mb-md-0" v-for="(banner, index) in homeBanners" :key="'banner-'+index" v-show="banner && banner.image">
             <a :href="(banner && banner.link) ? banner.link : 'javascript:void(0)'" class="banner-link banners-box">
               <img loading="lazy" :src="banner ? banner.image : ''" :alt="'Banner ' + (index + 1)" class="img-fluid banner-img">
             </a>
          </div>
        </div>
      </div>

      <!-- Cyclone Offer (Flash Sales) -->
      <div class="home-prods" v-if="flashSales.length > 0 && flashSales[0].products.length > 0">
        <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:14px;">
          <div class="sec-title" style="margin:0;font-size:17px;color:var(--danger);display:flex;align-items:center;gap:5px;">
             <i class="ti ti-bolt"></i> {{ __('flash_sale') }} 
          </div>
        </div>
        <div class="prods-grid">
          <ProductCard 
            v-for="product in flashSales[0].products.slice(0, 4)" 
            :key="'flash'+product.id" 
            :product="product" 
            @quickview="openQuickView"
          />
        </div>
      </div>

      <!-- Weekly Best Sellers -->
      <div class="home-prods" v-if="weeklyBestSellers.length > 0">
        <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:14px;">
          <div class="sec-title" style="margin:0;font-size:17px;">{{ __('newest_products') }}</div>
        </div>
        <div class="prods-grid">
          <ProductCard 
            v-for="product in weeklyBestSellers" 
            :key="'best'+product.id" 
            :product="product" 
            @quickview="openQuickView"
          />
        </div>
      </div>

      <!-- Top Products -->
      <div class="home-prods" v-if="topProducts.length > 0">
        <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:14px;">
          <div class="sec-title" style="margin:0;font-size:17px;">{{ __('top_products') }}</div>
        </div>
        <div class="prods-grid">
          <ProductCard 
            v-for="product in topProducts" 
            :key="'top'+product.id" 
            :product="product" 
            @quickview="openQuickView"
          />
        </div>
      </div>

      <!-- Featured Products -->
      <div class="home-prods" v-if="featuredProducts.length > 0">
        <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:14px;">
          <div class="sec-title" style="margin:0;font-size:17px;">{{ __('featured_products') }}</div>
          <span style="font-size:14px;color:var(--primary);cursor:pointer;" @click="$router.push('/products')">{{ __('view_all') || 'عرض الكل' }}</span>
        </div>
        <div class="prods-grid">
          <ProductCard 
            v-for="product in featuredProducts" 
            :key="'feat'+product.id" 
            :product="product" 
            @quickview="openQuickView"
          />
        </div>
      </div>

      <!-- Latest Products (Fallback) -->
      <div class="home-prods" v-if="!featuredProducts.length && !store.loading && store.products.length">
        <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:14px;">
          <div class="sec-title" style="margin:0;font-size:17px;">{{ __('latest_products') || 'أحدث المنتجات' }}</div>
          <span style="font-size:14px;color:var(--primary);cursor:pointer;" @click="$router.push('/products')">{{ __('view_all') || 'عرض الكل' }}</span>
        </div>
        
        <div class="prods-grid">
          <ProductCard 
            v-for="product in store.products" 
            :key="product.id" 
            :product="product" 
            @quickview="openQuickView"
          />
        </div>
      </div>
      </template>

    </div>
  </div>
</template>

<script setup>
import { onMounted, onUnmounted, ref } from 'vue';
import { useEcommerceStore } from '../stores/ecommerce';
import { useRouter } from 'vue-router';
import api from '../services/api';
import { parseShortcodes } from '../utils/shortcodeParser';
import ProductCard from '../components/ProductCard.vue';
import PageBlocks from '../components/PageBlocks.vue';
import SkeletonLoader from '../components/SkeletonLoader.vue';

const store = useEcommerceStore();
const router = useRouter();
const siteTitle = (window.BotbleData && window.BotbleData.site_title) ? window.BotbleData.site_title : 'Laly Kuwait';
const siteLogo = window.BotbleData?.logo || '';
const homeSliders = (window.BotbleData && window.BotbleData.homeSliders) ? window.BotbleData.homeSliders : [];
const homeBanners = (window.BotbleData && window.BotbleData.homeBanners) ? window.BotbleData.homeBanners : [];
const isRtl = (window.BotbleData && window.BotbleData.is_rtl !== undefined) ? window.BotbleData.is_rtl : true;

const catsScrollContainer = ref(null);

const scrollCats = (direction) => {
    if (catsScrollContainer.value) {
        const scrollAmount = 250;
        const scrollDirection = isRtl ? (direction === 'left' ? scrollAmount : -scrollAmount) : (direction === 'left' ? -scrollAmount : scrollAmount);
        catsScrollContainer.value.scrollBy({ left: scrollDirection, behavior: 'smooth' });
    }
};

const goToLink = (url) => {
    window.location.href = url;
};
const sliderContainer = ref(null);
let sliderInterval = null;
const currentSlide = ref(0);

const handleSliderScroll = () => {
    if (!sliderContainer.value) return;
    const scrollLeft = sliderContainer.value.scrollLeft;
    const slideWidth = sliderContainer.value.clientWidth;
    const newIndex = Math.round(Math.abs(scrollLeft) / slideWidth);
    if (newIndex !== currentSlide.value && newIndex < homeSliders.length) {
        currentSlide.value = newIndex;
    }
};

const goToSlide = (index) => {
    if (!sliderContainer.value || !sliderContainer.value.children[index]) return;
    currentSlide.value = index;
    const targetElement = sliderContainer.value.children[index];
    sliderContainer.value.scrollTo({
        left: targetElement.offsetLeft,
        behavior: 'smooth'
    });
    if (sliderInterval) {
        clearInterval(sliderInterval);
        startSliderInterval();
    }
};

const startSliderInterval = () => {
    if (homeSliders.length > 1) {
        sliderInterval = setInterval(() => {
            if (!sliderContainer.value || !sliderContainer.value.children.length) return;
            let nextIndex = currentSlide.value + 1;
            if (nextIndex >= homeSliders.length) {
                nextIndex = 0;
            }
            goToSlide(nextIndex);
        }, 6000);
    }
};

const pageBlocks = ref([]);
const loadingPage = ref(true);

const flashSales = ref([]);
const featuredProducts = ref([]);
const topProducts = ref([]);
const weeklyBestSellers = ref([]);

const loadHomeCollections = async () => {
    try {
        const collectionsRes = await api.get('/home-collections');
        
        if (collectionsRes.data?.data) {
            flashSales.value = collectionsRes.data.data.flash_sales || [];
            featuredProducts.value = collectionsRes.data.data.featured_products || [];
            topProducts.value = collectionsRes.data.data.top_products || [];
            weeklyBestSellers.value = collectionsRes.data.data.weekly_best_sellers || [];
        }
    } catch (e) {
        console.error('Error loading collections', e);
    }
};

onMounted(async () => {
    // Fetch CMS Homepage content
    try {
        const response = await api.get('/homepage');
        if (response.data && response.data.data && response.data.data.content) {
            pageBlocks.value = parseShortcodes(response.data.data.content);
        }
    } catch (e) {
        console.error('Failed to load CMS homepage', e);
    } finally {
        loadingPage.value = false;
    }

    store.fetchCategories();
    store.fetchProducts({ per_page: 4 });
    loadHomeCollections();
    
    startSliderInterval();
});

onUnmounted(() => {
    if (sliderInterval) clearInterval(sliderInterval);
});

const selectedCategories = ref([]);

const selectCategory = (cat, level) => {
    if (selectedCategories.value[level] === cat.id) {
        selectedCategories.value = selectedCategories.value.slice(0, level);
        const parentId = level > 0 ? selectedCategories.value[level - 1] : null;
        store.fetchProducts({ category: parentId });
    } else {
        selectedCategories.value = selectedCategories.value.slice(0, level);
        selectedCategories.value.push(cat.id);
        store.fetchProducts({ category: cat.id });
    }
};

const openQuickView = (slug) => {
    router.push(`/product/${slug}`);
};
</script>

<style scoped>
.cms-html-block {
  padding: 15px;
}
.cms-html-block :deep(img) {
  max-width: 100%;
  height: auto;
  border-radius: 8px;
}
.hero-scroll-container {
  display: flex;
  overflow-x: auto;
  scroll-snap-type: x mandatory;
  -webkit-overflow-scrolling: touch;
  gap: 16px;
  padding: 0 16px;
  margin-top: 14px;
}
.hero-scroll-container::-webkit-scrollbar {
  display: none;
}
.dynamic-hero {
  flex: 0 0 calc(100% - 24px); /* Make it slightly smaller than 100% so the next banner peeks out */
  scroll-snap-align: center;
  margin: 0 !important; /* Overriding default home-hero margin for flex gap */
  padding: 0 !important;
  min-height: auto !important;
  height: auto !important;
  background: transparent !important;
  display: block;
}
.hero-img {
  width: 100%;
  height: auto;
  display: block;
  border-radius: var(--r20);
}
.tech-trust-bar {
  display: flex;
  justify-content: space-between;
  padding: 16px;
  background: var(--surface);
  margin: 16px;
  border-radius: var(--r12);
  border: 1px solid var(--border);
  gap: 10px;
}
.trust-item {
  display: flex;
  align-items: center;
  gap: 8px;
  flex: 1;
}
.trust-item i {
  font-size: 24px;
  color: var(--primary);
}
.trust-item h4 {
  font-size: 11px;
  font-weight: 700;
  color: var(--text);
  margin: 0 0 2px 0;
}
.banners-box {
  background: var(--bg);
  border-radius: var(--r12);
  border: 1px solid var(--border2);
  box-shadow: 0 2px 8px rgba(0,0,0,0.02);
  transition: all 0.2s;
  display: block;
  overflow: hidden;
}
.banners-box:hover {
  border-color: var(--primary);
  box-shadow: 0 4px 15px rgba(0,0,0,0.05);
}
.banner-img {
  width: 100%;
  object-fit: cover;
  transition: transform 0.3s;
  display: block;
}
.banners-box:hover .banner-img {
  transform: scale(1.02);
}
.hero-slider-wrapper {
  position: relative;
}
.hero-pagination {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 8px;
  position: absolute;
  bottom: 12px;
  left: 0;
  width: 100%;
  z-index: 10;
}
@media (min-width: 992px) {
  .hero-pagination {
    bottom: 25px;
  }
}
.hero-dot {
  width: 8px;
  height: 8px;
  border-radius: 50%;
  background-color: rgba(255, 255, 255, 0.5);
  cursor: pointer;
  transition: all 0.3s ease;
}
.hero-dot.active {
  width: 24px;
  border-radius: 4px;
  background-color: var(--surface);
}
.trust-item p {
  font-size: 9px;
  color: var(--text3);
  margin: 0;
}
@media (min-width: 992px) {
  .hero-scroll-container {
    padding: 0;
    gap: 0;
    margin-top: 0 !important;
  }
  .dynamic-hero {
    flex: 0 0 100%;
    border-radius: 0;
    margin: 0 !important;
  }
  .hero-img {
    border-radius: 0;
  }
  .tech-trust-bar {
    max-width: 1200px;
    margin: 30px auto;
    padding: 24px 30px;
  }
  .trust-item {
    gap: 15px;
    justify-content: center;
  }
  .trust-item i { font-size: 36px; }
  .trust-item h4 { font-size: 15px; }
  .trust-item p { font-size: 13px; }
}

.cat-nav-btn {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  width: 36px;
  height: 36px;
  border-radius: 50%;
  background: var(--surface);
  border: 1px solid var(--border2);
  color: var(--text);
  display: flex;
  align-items: center;
  justify-content: center;
  box-shadow: 0 4px 12px rgba(0,0,0,0.08);
  z-index: 10;
  transition: all 0.2s ease;
  opacity: 0.8;
}
.cat-nav-btn:hover {
  background: var(--primary-strong);
  color: var(--on-primary);
  opacity: 1;
  border-color: var(--primary);
}
.cat-nav-prev {
  left: -10px;
}
.cat-nav-next {
  right: -10px;
}
/* Hide scrollbar for the cats container to make it cleaner */
.cats-scroll::-webkit-scrollbar {
  display: none;
}
.cats-scroll {
  -ms-overflow-style: none;  /* IE and Edge */
  scrollbar-width: none;  /* Firefox */
}

/* RTL Adjustments */
html[dir="rtl"] .cat-nav-prev {
  right: -10px;
  left: auto;
}
html[dir="rtl"] .cat-nav-next {
  left: -10px;
  right: auto;
}

/* Only show on desktop since mobile relies on touch scrolling */
@media (max-width: 767px) {
  .cat-nav-btn {
    display: none !important;
  }
}
.wizard-cta {
  display: flex;
  align-items: center;
  gap: var(--space-3);
  margin: var(--space-4);
  padding: var(--space-4);
  border-radius: var(--radius-lg);
  background: var(--primary-soft);
  border: 1px solid var(--line);
  color: var(--ink);
  text-decoration: none;
}
.wizard-cta > .ti-device-cctv {
  font-size: 28px;
  color: var(--primary-strong);
}
.wizard-cta-text {
  display: grid;
  gap: 2px;
  flex: 1;
}
.wizard-cta-text small {
  color: var(--ink-2);
}
.wizard-cta-arrow {
  color: var(--primary-strong);
}
[dir="ltr"] .wizard-cta-arrow {
  transform: scaleX(-1);
}
</style>

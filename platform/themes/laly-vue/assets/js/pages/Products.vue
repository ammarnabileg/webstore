<template>
  <div class="page">
    <div class="nbar">
      <button class="nbar-back" @click="$router.back()"><i class="ti ti-arrow-right" :class="{ 'ti-arrow-left': !botbleData?.is_rtl }"></i></button>
      <div class="nbar-title">{{ __('products') || 'المنتجات' }}</div>
      <div class="nbar-actions">
        <button @click="viewMode = viewMode === 'grid' ? 'list' : 'grid'">
          <i :class="viewMode === 'grid' ? 'ti ti-list' : 'ti ti-layout-grid'"></i>
        </button>
        <button @click="showFilters = true"><i class="ti ti-filter"></i></button>
        <button @click="$router.push('/search')"><i class="ti ti-search"></i></button>
      </div>
    </div>
    
    <div class="scroll" style="padding: 16px;">
      
      <div v-if="(store.loading || initializing) && store.products.length === 0" class="loading-state">
        <div class="spinner"></div>
        <p>{{ __('loading') }}</p>
      </div>
      
      <div v-else>
        <!-- Desktop Toolbar (visible only on desktop, or we can just make it responsive) -->
        <div class="desktop-toolbar" style="max-width: 1200px; margin: 0 auto 20px auto; display: flex; justify-content: flex-end; align-items: center; padding: 0 16px;">
          <div class="toolbar-actions desktop-only">
            <button class="btn-icon" @click="viewMode = viewMode === 'grid' ? 'list' : 'grid'" :title="__('view_mode')">
              <i :class="viewMode === 'grid' ? 'ti ti-list' : 'ti ti-layout-grid'"></i>
            </button>
            <button class="btn-icon" @click="showFilters = true" :title="__('filters')">
              <i class="ti ti-filter"></i> {{ __('filters') }}
            </button>
          </div>
        </div>

        <div class="plist" :class="{ 'plist-list': viewMode === 'list' }">
          <ProductCard 
            v-for="product in store.products" 
            :key="product.id" 
            :product="product" 
          />
        </div>

        <div v-if="hasMore" class="load-more-wrap">
          <button class="load-more-btn" :disabled="store.loadingMore" @click="loadMore">
            {{ store.loadingMore ? __('loading') : __('load_more') }}
          </button>
        </div>

        <div v-if="store.products.length === 0" class="empty-state" style="text-align: center; margin-top: 50px;">
          <img v-if="botbleData?.logo" :src="botbleData.logo" alt="Logo" style="max-height: 60px; margin-bottom: 20px; opacity: 0.6;" />
          <i v-else class="ti ti-package-off" style="font-size: 40px; color: #ccc;"></i>
          <p>{{ __('no_products') || 'لا توجد منتجات حالياً' }}</p>
        </div>
      </div>
      
      <div style="height: 20px;"></div>
    </div>

    <!-- Filter Drawer -->
    <div class="filter-overlay" v-if="showFilters" @click="showFilters = false"></div>
    <div class="filter-drawer" :class="{ 'open': showFilters, 'rtl': botbleData?.is_rtl }">
      <div class="drawer-header">
        <h3>{{ __('filters') || 'الفلاتر' }}</h3>
        <button class="close-btn" @click="showFilters = false"><i class="ti ti-x"></i></button>
      </div>
      <div class="drawer-body">
        <!-- Categories Filter -->
        <div class="filter-section">
          <h4>{{ __('categories') || 'الأقسام' }}</h4>
          <div class="filter-options">
            <label v-for="cat in store.rootCategories" :key="cat.id" class="filter-label">
              <input type="checkbox" :value="cat.id" v-model="selectedCategories">
              <span>{{ cat.name }}</span>
            </label>
          </div>
        </div>
        
        <!-- Collections Filter -->
        <div v-if="store.filters?.collections?.length" class="filter-section">
          <h4>{{ __('collections') || 'المجموعات' }}</h4>
          <div class="filter-options">
            <label v-for="col in store.filters.collections" :key="col.id" class="filter-label">
              <input type="checkbox" :value="col.id" v-model="selectedCollections">
              <span>{{ col.title }}</span>
            </label>
          </div>
        </div>

        <!-- Attributes Filter -->
        <div v-for="filterSet in store.filters?.attributes" :key="filterSet.id" class="filter-section">
          <h4>{{ filterSet.title }}</h4>
          <div class="filter-options" style="display:flex; flex-wrap:wrap; gap:10px;">
            <label v-for="attr in filterSet.attributes" :key="attr.id" class="filter-label" style="display:inline-flex; align-items:center; gap: 5px;">
              <input type="checkbox" :value="attr.id" v-model="selectedAttributes">
              <span v-if="attr.color" :style="{ backgroundColor: attr.color, width: '24px', height: '24px', borderRadius: '50%', display: 'inline-block', border: '1px solid #ddd' }" :title="attr.title"></span>
              <span v-else>{{ attr.title }}</span>
            </label>
          </div>
        </div>
        
        <!-- Tags Filter -->
        <div v-if="store.filters?.tags?.length" class="filter-section">
          <h4>{{ __('tags') || 'الوسوم' }}</h4>
          <div class="filter-options" style="display:flex; flex-wrap:wrap; gap:8px;">
            <label v-for="tag in store.filters.tags" :key="tag.id" class="filter-label tag-label">
              <input type="checkbox" :value="tag.id" v-model="selectedTags" style="display:none;">
              <span class="tag-chip" :class="{'active': selectedTags.includes(tag.id)}">{{ tag.title }}</span>
            </label>
          </div>
        </div>

        <button class="apply-filters-btn" @click="applyFilters">
          {{ __('apply') || 'تطبيق الفلاتر' }}
        </button>
      </div>
    </div>

  </div>
</template>

<script setup>
import { __ } from '../utils/i18n';
import { onMounted, watch, ref, computed } from 'vue';
import { useRoute } from 'vue-router';
import { useEcommerceStore } from '../stores/ecommerce';
import ProductCard from '../components/ProductCard.vue';

const route = useRoute();
const store = useEcommerceStore();
const viewMode = ref('grid');
const showFilters = ref(false);
const selectedCategories = ref([]);
const selectedAttributes = ref([]);
const selectedCollections = ref([]);
const selectedTags = ref([]);
const initializing = ref(true);
const botbleData = window?.BotbleData || {};

const getRouteCategoryIds = async () => {
    let catIds = [...selectedCategories.value];
    
    if (store.categories.length === 0) {
        await store.fetchCategories();
    }
    
    // /products?category=<id> links come from home-page shortcodes.
    if (catIds.length === 0 && route.query.category) {
        catIds = String(route.query.category).split(',').map(Number).filter(Boolean);
    }

    if (route.name === 'CategoryProducts' && route.params.slug && catIds.length === 0) {
        const cat = store.categories.find(c => c.slug === route.params.slug);
        if (cat) {
             const getChildIds = (id) => {
                 let ids = [id];
                 const children = store.categories.filter(c => c.parent_id === id);
                 for (let child of children) {
                     ids = ids.concat(getChildIds(child.id));
                 }
                 return ids;
             };
             catIds = getChildIds(cat.id);
        }
    }
    return catIds;
};

const PER_PAGE = 20;
const currentParams = ref({});
const hasMore = computed(() => {
    const meta = store.productsMeta;
    return !!meta && meta.current_page < meta.last_page;
});

const loadMore = async () => {
    if (!hasMore.value || store.loadingMore) return;
    await store.fetchProducts(
        { ...currentParams.value, page: store.productsMeta.current_page + 1 },
        { append: true }
    );
};

const applyFilters = async () => {
    showFilters.value = false;
    let params = { per_page: PER_PAGE };
    
    let catIds = await getRouteCategoryIds();
    
    if (catIds.length > 0) {
        params.category = catIds.join(',');
    }
    
    if (selectedAttributes.value.length > 0) {
        params.attributes = selectedAttributes.value.join(',');
    }
    if (selectedCollections.value.length > 0) {
        params.collections = selectedCollections.value.join(',');
    }
    if (selectedTags.value.length > 0) {
        params.tags = selectedTags.value.join(',');
    }
    
    currentParams.value = params;
    await store.fetchProducts(params);
    initializing.value = false;
};

const refreshFilters = async () => {
    let catIds = await getRouteCategoryIds();
    let params = {};
    if (catIds.length > 0) {
        params.category = catIds.join(',');
    }
    await store.fetchFilters(params);
};

onMounted(() => {
    refreshFilters();
    applyFilters();
});

watch(() => [route.params.slug, route.query.category], () => {
    // Clear selection when navigating to a different category
    selectedCategories.value = [];
    selectedAttributes.value = [];
    refreshFilters();
    applyFilters();
});

watch(() => selectedCategories.value, () => {
    // Dynamically update available attributes when user selects categories in the drawer
    refreshFilters();
});

</script>

<style scoped>
.filter-btn {
  padding: 8px 16px;
  border-radius: 20px;
  border: 1px solid #ddd;
  background: #fff;
  white-space: nowrap;
  font-family: inherit;
  cursor: pointer;
}
.filter-btn.active {
  background: var(--primary);
  color: #fff;
  border-color: var(--primary);
}

.desktop-only {
  display: none;
}
.btn-icon {
  background: var(--surface);
  border: 1px solid var(--border);
  border-radius: 8px;
  padding: 8px 12px;
  color: var(--text);
  cursor: pointer;
  display: inline-flex;
  align-items: center;
  gap: 6px;
  margin-right: 8px; /* RTL margin */
  font-family: inherit;
}
[dir="ltr"] .btn-icon {
  margin-right: 0;
  margin-left: 8px;
}
@media (min-width: 768px) {
  .desktop-only {
    display: flex;
  }
}

.plist {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 12px;
}
@media (min-width: 768px) {
  .plist {
    grid-template-columns: repeat(4, 1fr);
    gap: 20px;
  }
}

.loading-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 200px;
  color: #666;
}
.spinner {
  border: 3px solid #f3f3f3;
  border-top: 3px solid #172B85;
  border-radius: 50%;
  width: 30px;
  height: 30px;
  animation: spin 1s linear infinite;
  margin-bottom: 10px;
}
@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}
.old-price {
  text-decoration: line-through;
  color: #999;
  font-size: 12px;
  margin-left: 5px;
}

/* List View Styles */
.plist-list {
  display: flex !important;
  flex-direction: column;
  gap: 16px;
}
.plist-list .pcard {
  display: flex;
  flex-direction: row;
  height: 120px;
  align-items: center;
}
.plist-list .pcard-img {
  width: 120px;
  height: 100%;
  flex-shrink: 0;
  border-bottom: none;
  border-left: 1px solid var(--border); /* RTL adjusted below if needed */
}
.plist-list .pcard-img img {
  height: 100%;
  width: 100%;
  object-fit: contain;
}
.plist-list .pcard-info {
  flex: 1;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: flex-start;
  padding: 10px 16px;
}
.plist-list .pcard-add {
  margin-top: auto;
  align-items: center;
}

/* Card Stabilization */
.pcard {
  display: flex;
  flex-direction: column;
  height: 100%;
  position: relative;
}
.pcard-info {
  flex: 1;
  display: flex;
  flex-direction: column;
}
.pcard-title {
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
  text-overflow: ellipsis;
  min-height: 40px; /* Force 2 lines height */
  line-height: 1.3;
  margin-bottom: 8px;
}
.pcard-bottom {
  margin-top: auto;
}

/* Badges & Actions */
.pcard-img {
  position: relative;
  overflow: hidden;
}
.pcard-badges {
  position: absolute;
  top: 10px;
  right: 10px; /* LTR left */
  display: flex;
  flex-direction: column;
  gap: 5px;
  z-index: 2;
}
[dir="ltr"] .pcard-badges {
  right: auto;
  left: 10px;
}
.pcard-badge {
  font-size: 10px;
  padding: 3px 8px;
  border-radius: 4px;
  color: #fff;
  font-weight: bold;
}
.sale-badge { background: var(--danger); }

.pcard-floating-actions {
  position: absolute;
  bottom: -40px; /* Hide initially */
  left: 0;
  right: 0;
  display: flex;
  justify-content: center;
  gap: 8px;
  transition: bottom 0.3s ease;
  z-index: 2;
}
.pcard-img:hover .pcard-floating-actions {
  bottom: 10px;
}
.pcard-floating-actions button {
  width: 35px;
  height: 35px;
  border-radius: 50%;
  background: #fff;
  border: none;
  box-shadow: 0 2px 5px rgba(0,0,0,0.2);
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 16px;
  color: var(--text2);
  cursor: pointer;
  transition: all 0.2s;
}
.pcard-floating-actions button:hover {
  background: var(--primary);
  color: #fff;
}
.pcard-floating-actions button.active {
  color: var(--danger);
}

.pcard-meta {
  font-size: 11px;
  color: var(--primary);
  margin-bottom: 4px;
}

/* Tag Chips */
.tag-chip {
  display: inline-block;
  padding: 5px 12px;
  background: var(--surface);
  border: 1px solid var(--border);
  border-radius: 20px;
  font-size: 12px;
  cursor: pointer;
  transition: all 0.2s;
}
.tag-chip.active {
  background: var(--primary);
  color: #fff;
  border-color: var(--primary);
}

/* Quick View Modal */
.quick-view-overlay {
  position: fixed;
  inset: 0;
  background: rgba(0,0,0,0.5);
  z-index: 1000;
  backdrop-filter: blur(2px);
}
.quick-view-modal {
  position: fixed;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 90%;
  max-width: 800px;
  background: var(--bg);
  border-radius: var(--r12);
  z-index: 1001;
  padding: 20px;
  box-shadow: 0 10px 30px rgba(0,0,0,0.2);
}
.close-qv {
  position: absolute;
  top: 15px;
  right: 15px; /* RTL left */
  background: var(--surface);
  border: none;
  width: 30px;
  height: 30px;
  border-radius: 50%;
  font-size: 16px;
  cursor: pointer;
  z-index: 10;
}
[dir="ltr"] .close-qv { right: auto; left: 15px; }
.qv-body {
  display: flex;
  flex-direction: column;
  gap: 20px;
}
@media (min-width: 768px) {
  .qv-body { flex-direction: row; }
  .qv-img { flex: 1; }
  .qv-info { flex: 1.5; }
}
.qv-img img {
  width: 100%;
  border-radius: 8px;
  object-fit: contain;
  background: var(--surface);
}
.qv-info h3 { font-size: 20px; margin-bottom: 10px; line-height: 1.3; }
.qv-price { font-size: 22px; font-weight: bold; color: var(--primary); margin-bottom: 15px; display: flex; gap: 10px; align-items: center; }
.qv-desc { font-size: 14px; color: var(--text2); line-height: 1.6; margin-bottom: 20px; display: -webkit-box; -webkit-line-clamp: 4; -webkit-box-orient: vertical; overflow: hidden; }
.qv-add-btn {
  background: var(--primary);
  color: #fff;
  border: none;
  width: 100%;
  padding: 12px;
  border-radius: 8px;
  font-size: 16px;
  font-weight: bold;
  cursor: pointer;
  display: flex;
  justify-content: center;
  gap: 10px;
  margin-bottom: 15px;
}
.qv-more { display: block; text-align: center; color: var(--text2); font-size: 14px; cursor: pointer; text-decoration: underline; }
.qv-loading { height: 300px; display: flex; align-items: center; justify-content: center; }

/* Filter Drawer Styles */
.filter-overlay {
  position: fixed;
  top: 0; left: 0; right: 0; bottom: 0;
  background: rgba(0,0,0,0.5);
  z-index: 99998;
  backdrop-filter: blur(4px);
}
.filter-drawer {
  position: fixed;
  top: 0;
  bottom: 0;
  width: 280px;
  background: var(--bg);
  z-index: 99999;
  transform: translateX(-100%);
  transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  display: flex;
  flex-direction: column;
  box-shadow: 0 0 20px rgba(0,0,0,0.1);
  left: 0; /* Default LTR */
}
.filter-drawer.rtl {
  left: auto;
  right: 0;
  transform: translateX(100%);
}
.filter-drawer.open {
  transform: translateX(0) !important;
}
.drawer-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 16px;
  border-bottom: 1px solid var(--border);
}
.drawer-header h3 {
  margin: 0;
  font-size: 18px;
  font-weight: 700;
}
.close-btn {
  background: none;
  border: none;
  font-size: 20px;
  cursor: pointer;
  color: var(--text);
  padding: 4px;
}
.drawer-body {
  padding: 16px;
  overflow-y: auto;
  flex: 1;
}
.filter-section {
  margin-bottom: 24px;
}
.filter-section h4 {
  margin: 0 0 12px 0;
  font-size: 15px;
  font-weight: 600;
  color: var(--text2);
}
.filter-options {
  display: flex;
  flex-direction: column;
  gap: 10px;
}
.filter-label {
  display: flex;
  align-items: center;
  gap: 10px;
  font-size: 14px;
  cursor: pointer;
}
.filter-label input[type="checkbox"] {
  width: 18px;
  height: 18px;
  accent-color: var(--primary);
}
.apply-filters-btn {
  width: 100%;
  padding: 12px;
  background: var(--primary);
  color: #fff;
  border: none;
  border-radius: 8px;
  font-weight: 700;
  font-size: 16px;
  cursor: pointer;
  margin-top: 10px;
}
.load-more-wrap {
    display: flex;
    justify-content: center;
    padding: 16px 0 8px;
}
.load-more-btn {
    min-width: 180px;
    padding: 12px 24px;
    border-radius: 12px;
    border: 1px solid var(--primary);
    background: transparent;
    color: var(--primary);
    font-weight: 700;
    cursor: pointer;
}
.load-more-btn:disabled {
    opacity: .6;
    cursor: default;
}
</style>

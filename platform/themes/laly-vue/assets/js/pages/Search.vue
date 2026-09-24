<template>
  <div class="page">
    <div class="nbar">
      <button class="nbar-back" @click="$router.back()" style="margin-inline-end: 10px;" :aria-label="__('back')"><i class="ti ti-arrow-right" :class="{ 'ti-arrow-left': !botbleData?.is_rtl }"></i></button>
      <div class="search-input-wrapper">
        <input 
          type="text" 
          v-model="query" 
          @keyup.enter="doSearch" 
          :placeholder="__('search_placeholder') || 'ابحث عن المنتجات...'" 
          autofocus 
        />
        <button v-if="query" @click="query = ''; store.searchResults = []" class="clear-btn" style="margin-inline-end: 10px;" :aria-label="__('close')">
          <i class="ti ti-x"></i>
        </button>
        <button class="search-btn" @click="doSearch" :aria-label="__('search')">
          <i class="ti ti-search"></i>
        </button>
      </div>
    </div>
    
    <div class="scroll" style="padding: 16px;">
      <div v-if="store.loading" class="loading-state">
        <div class="spinner"></div>
      </div>
      
      <div v-else-if="store.searchResults.length > 0" class="plist">
        <ProductCard 
          v-for="product in store.searchResults" 
          :key="product.id" 
          :product="product" 
          @quick-view="openQuickView" 
        />
      </div>
      
      <div v-else-if="query && !store.loading" class="empty-state">
        <i class="ti ti-search" style="font-size: 40px; color: var(--line);"></i>
        <p>{{ __('no_results') }}</p>
      </div>
      
      <div v-else class="empty-state">
        <p>{{ __('search_empty') || 'اكتب اسم المنتج للبحث عنه...' }}</p>
      </div>

      <div style="height: 80px;"></div>
    </div>
  </div>
</template>

<script setup>
import { __ } from '../utils/i18n';
import { ref, watch, inject } from 'vue';
import { useRoute } from 'vue-router';
import { useEcommerceStore } from '../stores/ecommerce';
import ProductCard from '../components/ProductCard.vue';

const route = useRoute();
const store = useEcommerceStore();
const query = ref(route.query.q || '');
const botbleData = window?.BotbleData || {};

const openQuickView = async (slug) => {
    store.currentProduct = null;
    // For search page, if quick view is needed, we could implement a simplified version
    // or route to the detail page for now since Search.vue doesn't have the quick view modal markup
    // A better approach is to add the Quick View modal to AppLayout so it's global.
    // For now, redirect to product details to keep it simple and robust.
    window.location.href = `/product/${slug}`;
};

// Debounce search
let timeout = null;
watch(query, (newVal) => {
    if (timeout) clearTimeout(timeout);
    timeout = setTimeout(() => {
        if (newVal.trim().length > 1) {
            store.searchProducts(newVal);
        } else {
            store.searchResults = [];
        }
    }, 500);
});

const doSearch = () => {
    if (query.value.trim()) {
        store.searchProducts(query.value);
    }
};

// Initial search if query param exists
if (query.value) {
    doSearch();
}
</script>

<style scoped>
.search-input-wrapper {
  display: flex;
  align-items: center;
  background: var(--surface-2);
  border-radius: 50px;
  padding: 4px 4px 4px 15px;
  flex: 1;
  margin-inline-start: 10px;
}
.search-input-wrapper i.ti-search {
  color: var(--text2);
  margin-inline-end: 10px;
  display: none; /* Hide default icon since we add a button */
}
.search-input-wrapper input {
  flex: 1;
  border: none;
  background: transparent;
  outline: none;
  font-family: inherit;
  font-size: 15px;
  color: var(--text);
  padding: 8px 5px;
}
.search-input-wrapper .search-btn {
  width: 36px;
  height: 36px;
  border-radius: 50%;
  background: var(--primary-strong);
  border: none;
  color: var(--on-primary);
  display: flex;
  align-items: center;
  justify-content: center;
  flex-shrink: 0;
}
.search-input-wrapper .search-btn i {
  font-size: 18px;
  color: #fff;
  margin: 0;
  display: block;
}
.clear-btn {
  background: none;
  border: none;
  color: var(--text3);
  cursor: pointer;
}
.empty-state {
  text-align: center;
  padding: 50px 20px;
  color: var(--text2);
}
.empty-state i {
  color: var(--border2);
}
</style>

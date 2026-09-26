<template>
  <div class="page">
    <div class="nbar">
      <button class="nbar-back" @click="$router.back()" :aria-label="__('back')"><i class="ti ti-arrow-right" :class="{ 'ti-arrow-left': !botbleData?.is_rtl }"></i></button>
      <div class="nbar-title">{{ __('wishlist') || 'المفضلة' }}</div>
    </div>
    
    <div class="scroll" style="padding: 16px;">
      
      <div v-if="store.wishlist.length > 0" class="plist">
        <ProductCard 
          v-for="product in store.wishlist" 
          :key="product.id" 
          :product="product" 
        />
      </div>
      
      <div v-else class="empty-state" style="text-align: center; padding: 50px 20px;">
        <i class="ti ti-heart-broken" style="font-size: 60px; color: var(--line); margin-bottom: 20px; display: block;"></i>
        <h3 style="margin-bottom: 10px;">{{ __('wishlist_empty') || 'قائمة المفضلة فارغة!' }}</h3>
        <p style="color: var(--ink-2); margin-bottom: 20px;">{{ __('wishlist_empty_sub') }}</p>
        <button class="btn btn-primary" @click="$router.push('/products')" style="padding: 12px 25px; border-radius: 25px; background: var(--primary-strong); color: var(--on-primary); border: none; cursor: pointer;">
          {{ __('shop_now') || 'تسوّق الآن' }}
        </button>
      </div>

      <div style="height: 80px;"></div>
    </div>
  </div>
</template>

<script setup>
import { __ } from '../utils/i18n';
import { inject, onMounted } from 'vue';
import { useEcommerceStore } from '../stores/ecommerce';
import ProductCard from '../components/ProductCard.vue';

const store = useEcommerceStore();
const botbleData = window?.BotbleData || {};

// Reconcile the wishlist with the server (and migrate any local-only items) on open.
onMounted(() => {
    store.fetchWishlist();
});
</script>

<style scoped>
.empty-state {
  background: var(--surface);
  border-radius: 15px;
  box-shadow: 0 2px 10px rgba(0,0,0,0.02);
}
</style>

<template>
  <div class="home-prods sblock">
    <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:14px;">
      <div class="sec-title" style="margin:0;font-size:17px;">{{ attributes.title || __('latest_products') }}</div>
      <span style="font-size:14px;color:var(--primary);cursor:pointer;" @click="$router.push('/products')">{{ __('view_all') || 'عرض الكل' }}</span>
    </div>
    
    <div v-if="loading" style="text-align: center; color: var(--text3); padding: 20px;">
      {{ __('loading_products') || 'جاري تحميل المنتجات...' }}
    </div>
    
    <div class="prods-grid" v-else>
      <ProductCard 
        v-for="product in products" 
        :key="product.id" 
        :product="product" 
        @quickview="$emit('quickview', $event)"
      />
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, inject } from 'vue';
import api from '../../services/api';
import ProductCard from '../ProductCard.vue';

const props = defineProps({
  attributes: {
    type: Object,
    default: () => ({})
  }
});

defineEmits(['quickview']);

const __ = inject('__') || window?.BotbleData?.i18n || ((key) => key);
const products = ref([]);
const loading = ref(true);

onMounted(async () => {
  const limit = props.attributes.limit || 8;
  
  try {
    // For now, we fetch latest/featured products. You could add an endpoint specifically for featured products if needed.
    const response = await api.get('/products', { params: { per_page: limit } });
    products.value = response.data.data || [];
  } catch (err) {
    console.error('Error fetching featured products:', err);
  } finally {
    loading.value = false;
  }
});
</script>

<style scoped>
.home-prods {
  margin-top: 20px;
}
.prods-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 15px;
}
@media (min-width: 768px) {
  .prods-grid {
    grid-template-columns: repeat(4, 1fr);
  }
}
@media (min-width: 1200px) {
  .prods-grid {
    grid-template-columns: repeat(5, 1fr);
  }
}
</style>

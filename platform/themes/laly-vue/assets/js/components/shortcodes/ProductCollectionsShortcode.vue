<template>
  <div class="collections-prods sblock">
    <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:14px;" v-if="attributes.title">
      <div class="sec-title" style="margin:0;font-size:17px;">{{ attributes.title }}</div>
    </div>
    
    <!-- Tabs -->
    <div class="collection-tabs" v-if="collections.length > 0">
      <div 
        class="tab-item" 
        v-for="collection in collections" 
        :key="collection.id"
        :class="{ active: activeCollection === collection.id }"
        @click="selectCollection(collection.id)"
      >
        {{ collection.title || collection.name }}
      </div>
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
import { __ } from '../../utils/i18n';
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

const collections = ref([]);
const activeCollection = ref(null);
const products = ref([]);
const loading = ref(true);

onMounted(async () => {
  // Try fetching collections
  try {
    const filtersRes = await api.get('/filters');
    if (filtersRes.data && filtersRes.data.data && filtersRes.data.data.collections) {
      collections.value = filtersRes.data.data.collections;
      if (collections.value.length > 0) {
        selectCollection(collections.value[0].id);
      } else {
        loading.value = false;
      }
    } else {
        loading.value = false;
    }
  } catch (err) {
    console.error('Error fetching collections:', err);
    loading.value = false;
  }
});

const selectCollection = async (collectionId) => {
  activeCollection.value = collectionId;
  loading.value = true;
  const limit = props.attributes.limit || 8;
  
  try {
    // We would pass collection parameter to API. Note: the API must support filtering by collection
    const response = await api.get('/products', { params: { collection_id: collectionId, per_page: limit } });
    products.value = response.data.data || [];
  } catch (err) {
    console.error('Error fetching collection products:', err);
  } finally {
    loading.value = false;
  }
};
</script>

<style scoped>
.collections-prods {
  margin-top: 20px;
}
.collection-tabs {
  display: flex;
  overflow-x: auto;
  gap: 15px;
  margin-bottom: 20px;
  border-bottom: 1px solid var(--line);
  padding-bottom: 5px;
}
.collection-tabs::-webkit-scrollbar {
  display: none;
}
.tab-item {
  font-size: 15px;
  font-weight: 500;
  color: var(--ink-2);
  cursor: pointer;
  padding: 5px 0;
  white-space: nowrap;
  position: relative;
  transition: all 0.2s;
}
.tab-item.active {
  color: var(--primary);
}
.tab-item.active::after {
  content: '';
  position: absolute;
  bottom: -6px;
  left: 0;
  width: 100%;
  height: 2px;
  background: var(--primary-strong);
  border-radius: 2px;
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

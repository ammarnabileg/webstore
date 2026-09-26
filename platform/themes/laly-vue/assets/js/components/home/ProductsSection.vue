<template>
  <section class="home-prods" v-if="products.length">
    <SectionHeader :title="title" :subtitle="section.subtitle" :view-all="section.view_all" />
    <div :class="section.layout === 'scroll' ? 'prods-scroll' : 'prods-grid'">
      <ProductCard
        v-for="product in products"
        :key="section.id + '-' + product.id"
        :product="product"
        @quickview="$emit('quickview', $event)"
      />
    </div>
  </section>
</template>

<script setup>
import { computed } from 'vue';
import { __ } from '../../utils/i18n';
import ProductCard from '../ProductCard.vue';
import SectionHeader from './SectionHeader.vue';

const props = defineProps({ section: { type: Object, required: true } });
defineEmits(['quickview']);

const products = computed(() => props.section.data?.products || []);

const defaultTitles = { featured: 'featured_products', latest: 'latest_products', best_selling: 'best_sellers' };
const title = computed(() => {
  if (props.section.title) return props.section.title;
  const key = defaultTitles[props.section.source];
  return key ? __(key) : '';
});
</script>

<style scoped>
.prods-scroll {
  display: flex;
  gap: 10px;
  overflow-x: auto;
  scroll-snap-type: x mandatory;
  -webkit-overflow-scrolling: touch;
  scrollbar-width: none;
  padding-bottom: 4px;
}
.prods-scroll::-webkit-scrollbar { display: none; }
.prods-scroll > * {
  flex: 0 0 calc(50% - 5px);
  scroll-snap-align: start;
}
@media (min-width: 768px) {
  .prods-scroll { gap: 20px; }
  .prods-scroll > * { flex-basis: 260px; }
}
</style>

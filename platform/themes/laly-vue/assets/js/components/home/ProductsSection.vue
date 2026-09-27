<template>
  <section class="home-prods" v-if="products.length">
    <SectionHeader :title="title" :subtitle="section.subtitle" :view-all="section.view_all" />
    <div v-if="section.layout === 'scroll'" class="track-wrap">
      <div class="prods-track" ref="track">
        <ProductCard
          v-for="product in products"
          :key="section.id + '-' + product.id"
          :product="product"
          @quickview="$emit('quickview', $event)"
        />
      </div>
      <button type="button" class="track-next" @click="scrollTrack" :aria-label="__('next')">
        <i class="ti" :class="isRtl ? 'ti-chevron-left' : 'ti-chevron-right'"></i>
      </button>
    </div>
    <div v-else class="prods-grid">
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
import { computed, ref } from 'vue';
import { __ } from '../../utils/i18n';
import ProductCard from '../ProductCard.vue';
import SectionHeader from './SectionHeader.vue';

const props = defineProps({ section: { type: Object, required: true } });
defineEmits(['quickview']);

const products = computed(() => props.section.data?.products || []);
const isRtl = window.BotbleData?.is_rtl !== false;
const track = ref(null);

const defaultTitles = { featured: 'featured_products', latest: 'latest_products', best_selling: 'best_sellers' };
const title = computed(() => {
  if (props.section.title) return props.section.title;
  const key = defaultTitles[props.section.source];
  return key ? __(key) : '';
});

const scrollTrack = () => {
  const el = track.value;
  if (!el) return;
  const step = el.clientWidth * 0.8 * (isRtl ? -1 : 1);
  const atEnd = Math.abs(el.scrollLeft) + el.clientWidth >= el.scrollWidth - 8;
  el.scrollBy({ left: atEnd ? -el.scrollLeft : step, behavior: 'smooth' });
};
</script>

<style scoped>
.track-wrap { position: relative; }
.prods-track {
  display: grid;
  grid-auto-flow: column;
  grid-auto-columns: calc(50% - 5px);
  gap: 10px;
  overflow-x: auto;
  scroll-snap-type: x mandatory;
  -webkit-overflow-scrolling: touch;
  scrollbar-width: none;
  padding: 4px 2px 12px;
}
.prods-track::-webkit-scrollbar { display: none; }
.prods-track > * { scroll-snap-align: start; }
.track-next {
  display: none;
  position: absolute; inset-inline-end: -14px; top: 40%;
  width: 44px; height: 44px; border-radius: 50%;
  background: var(--surface); border: 1px solid var(--line); color: var(--ink);
  box-shadow: var(--shadow-card); z-index: 3; font-size: 18px;
  align-items: center; justify-content: center; transition: all .2s;
}
.track-next:hover { color: var(--primary-strong); border-color: var(--primary-strong); }
@media (max-width: 767px) {
  .prods-track { grid-auto-columns: 172px; gap: 11px; margin: 0 -14px; padding: 4px 14px 10px; scroll-snap-type: x proximity; }
  .prods-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 11px; padding: 0; }
}
@media (min-width: 768px) {
  .prods-track { grid-auto-columns: 238px; gap: 14px; scrollbar-width: thin; scrollbar-color: var(--line) transparent; }
  .prods-track::-webkit-scrollbar { display: block; height: 6px; }
  .prods-track::-webkit-scrollbar-thumb { background: var(--line); border-radius: 99px; }
  .track-next { display: flex; }
}
</style>

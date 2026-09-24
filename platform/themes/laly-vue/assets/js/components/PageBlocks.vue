<template>
  <div class="page-blocks">
    <template v-for="(block, index) in blocks" :key="index">
      <SimpleSliderShortcode v-if="block.name === 'simple-slider'" :attributes="block.attributes" />
      <SiteFeaturesShortcode v-else-if="block.name === 'site-features'" :attributes="block.attributes" />
      <FeaturedProductCategoriesShortcode v-else-if="block.name === 'featured-product-categories'" :attributes="block.attributes" />
      <FeaturedProductsShortcode v-else-if="block.name === 'featured-products'" :attributes="block.attributes" @quickview="openQuickView" />
      <ProductCategoryProductsShortcode v-else-if="block.name === 'product-category-products'" :attributes="block.attributes" @quickview="openQuickView" />
      <ProductCollectionsShortcode v-else-if="block.name === 'product-collections'" :attributes="block.attributes" @quickview="openQuickView" />
      <ThemeAdsShortcode v-else-if="block.name === 'theme-ads'" :attributes="block.attributes" />
      <div v-else-if="block.type === 'html'" class="cms-html-block sblock" v-html="block.content"></div>
    </template>
  </div>
</template>

<script setup>
import { inject } from 'vue';

// Dynamic Shortcode Components
import SimpleSliderShortcode from './shortcodes/SimpleSliderShortcode.vue';
import SiteFeaturesShortcode from './shortcodes/SiteFeaturesShortcode.vue';
import FeaturedProductCategoriesShortcode from './shortcodes/FeaturedProductCategoriesShortcode.vue';
import FeaturedProductsShortcode from './shortcodes/FeaturedProductsShortcode.vue';
import ProductCategoryProductsShortcode from './shortcodes/ProductCategoryProductsShortcode.vue';
import ProductCollectionsShortcode from './shortcodes/ProductCollectionsShortcode.vue';
import ThemeAdsShortcode from './shortcodes/ThemeAdsShortcode.vue';

const props = defineProps({
  blocks: {
    type: Array,
    required: true,
    default: () => []
  }
});

const emit = defineEmits(['quickview']);

const openQuickView = (slug) => {
    emit('quickview', slug);
};
</script>

<style scoped>
.page-blocks {
  display: flex;
  flex-direction: column;
}
</style>

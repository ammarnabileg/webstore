<template>
  <template v-for="section in sections" :key="section.id">
    <component
      :is="registry[section.type]"
      v-if="registry[section.type]"
      :section="section"
      @quickview="$emit('quickview', $event)"
    />
  </template>
</template>

<script setup>
// Renders the ordered section list from `GET /home-sections`. Adding a section type on the
// server only needs a matching entry here; unknown types are skipped rather than breaking the page.
import HeroSlider from './HeroSlider.vue';
import HeroFallback from './HeroFallback.vue';
import FeaturesBar from './FeaturesBar.vue';
import WizardCta from './WizardCta.vue';
import CategoriesRow from './CategoriesRow.vue';
import HomeBanners from './HomeBanners.vue';
import FlashSaleSection from './FlashSaleSection.vue';
import ProductsSection from './ProductsSection.vue';
import StatsBand from './StatsBand.vue';
import BrandsStrip from './BrandsStrip.vue';

defineProps({
  sections: { type: Array, default: () => [] }
});
defineEmits(['quickview']);

const registry = {
  slider: HeroSlider,
  hero: HeroFallback,
  features: FeaturesBar,
  wizard_cta: WizardCta,
  categories: CategoriesRow,
  banners: HomeBanners,
  flash_sale: FlashSaleSection,
  products: ProductsSection,
  stats: StatsBand,
  brands: BrandsStrip,
};
</script>

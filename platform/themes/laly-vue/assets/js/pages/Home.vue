<template>
  <div class="page">
    <div class="nbar">
      <div class="nbar-title">
        <img :src="siteLogo" :alt="siteTitle" style="height: 35px; max-width: 150px; object-fit: contain;">
      </div>
      <div class="nbar-actions">
        <button @click="$router.push('/search')" :aria-label="__('search')"><i class="ti ti-search"></i></button>
        <button @click="$router.push('/cart')" :aria-label="__('cart')"><i class="ti ti-shopping-cart"></i></button>
      </div>
    </div>
    <div class="scroll">
      <div v-if="loading" class="prods-grid" style="padding: 20px;">
        <SkeletonLoader v-for="i in 4" :key="i" type="product" style="height: 280px;" />
      </div>

      <!-- CMS homepage (Theme options → homepage_id): built from shortcodes -->
      <PageBlocks v-else-if="pageBlocks.length > 0" :blocks="pageBlocks" @quickview="openQuickView" />

      <!-- Dashboard-managed sections (Theme options → Homepage: Sections) -->
      <HomeSections v-else :sections="sections" @quickview="openQuickView" />

      <SiteFooter class="mobile-footer" />
    </div>
  </div>
</template>

<script setup>
import { onMounted, ref } from 'vue';
import { useRouter } from 'vue-router';
import { useEcommerceStore } from '../stores/ecommerce';
import api from '../services/api';
import { parseShortcodes } from '../utils/shortcodeParser';
import PageBlocks from '../components/PageBlocks.vue';
import HomeSections from '../components/home/HomeSections.vue';
import SiteFooter from '../components/SiteFooter.vue';
import SkeletonLoader from '../components/SkeletonLoader.vue';

const store = useEcommerceStore();
const router = useRouter();
const siteTitle = window.BotbleData?.site_title || '';
const siteLogo = window.BotbleData?.logo || '';

const loading = ref(true);
const pageBlocks = ref([]);
const sections = ref([]);

onMounted(async () => {
    try {
        const page = await api.get('/homepage');
        if (page.data?.data?.content) {
            pageBlocks.value = parseShortcodes(page.data.data.content);
        }
        if (!pageBlocks.value.length) {
            const res = await api.get('/home-sections');
            sections.value = res.data?.data || [];
        }
    } catch (e) {
        console.error('Failed to load homepage', e);
    } finally {
        loading.value = false;
    }
    store.fetchCategories();
});

const openQuickView = (slug) => {
    router.push(`/product/${slug}`);
};
</script>

<style scoped>
.mobile-footer { display: block; }
/* The layout's desktop footer takes over from 768px (see app.scss .desktop-footer). */
@media (min-width: 768px) {
  .mobile-footer { display: none; }
}
</style>

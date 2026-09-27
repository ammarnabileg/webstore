<template>
  <div class="page">
    <!-- Phone app header (mockup "index_1"): logo, language, notifications, search -->
    <div class="nbar home-bar">
      <router-link to="/" class="home-logo" :aria-label="siteTitle">
        <img :src="siteLogo" :alt="siteTitle">
      </router-link>
      <div class="home-actions">
        <a
          v-for="lang in otherLanguages"
          :key="lang.code"
          :href="lang.url"
          class="home-lang"
          :title="lang.name"
        >{{ lang.code === 'ar' ? 'عربي' : lang.code.toUpperCase() }}</a>
        <router-link to="/notifications" class="home-hbtn" :aria-label="__('notifications')">
          <i class="ti ti-bell"></i><span v-if="hasNewNotifications" class="home-dot"></span>
        </router-link>
        <router-link to="/search" class="home-hbtn" :aria-label="__('search')"><i class="ti ti-search"></i></router-link>
      </div>
    </div>
    <div class="scroll">
      <router-link to="/search" class="home-search">
        <i class="ti ti-search" aria-hidden="true"></i><span>{{ __('search_placeholder') }}</span>
      </router-link>
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
import { inject, onMounted, ref } from 'vue';
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
const otherLanguages = (window.BotbleData?.languages || []).filter((l) => !l.active);
const hasNewNotifications = inject('hasNewNotifications', ref(false));

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
.home-bar {
  background: linear-gradient(150deg, var(--deep), var(--deep-2));
  border-bottom: 0; backdrop-filter: none; -webkit-backdrop-filter: none;
  padding: 0 12px; gap: 8px;
}
.home-logo { display: flex; align-items: center; min-width: 0; }
/* The uploaded logo is dark-on-transparent; render it white on the dark bar. */
.home-logo img { height: 26px; max-width: 150px; object-fit: contain; filter: brightness(0) invert(1); }
.home-actions { display: flex; align-items: center; gap: 4px; }
.home-lang {
  height: 30px; padding: 0 11px; border-radius: 999px; border: 1.4px solid rgba(255,255,255,.35);
  color: #fff; font-size: 11.5px; font-weight: 800; display: inline-flex; align-items: center; text-decoration: none;
  margin-inline-end: 4px;
}
.home-hbtn {
  position: relative; width: 40px; height: 40px; border-radius: 12px; display: grid; place-items: center;
  color: #fff; font-size: 21px; text-decoration: none;
}
.home-hbtn:active { background: rgba(255,255,255,.12); }
.home-dot { position: absolute; top: 9px; inset-inline-end: 10px; width: 8px; height: 8px; border-radius: 50%; background: var(--sale); box-shadow: 0 0 0 2px var(--deep); }
.home-search {
  display: flex; align-items: center; gap: 9px; margin: 12px 14px 0; height: 46px; padding-inline: 13px;
  background: var(--surface); border: 1.5px solid var(--line); border-radius: 14px; box-shadow: var(--shadow-card);
  color: var(--ink-2); font-size: 13px; font-weight: 700; text-decoration: none;
}
.home-search i { color: var(--primary-strong); font-size: 18px; }
@media (min-width: 768px) { .home-search { display: none; } }
.mobile-footer { display: block; }
/* The layout's desktop footer takes over from 768px (see app.scss .desktop-footer). */
@media (min-width: 768px) {
  .mobile-footer { display: none; }
}
</style>

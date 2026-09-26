<template>
  <div class="page">
    <div class="nbar">
      <button class="nbar-back" @click="$router.back()" :aria-label="__('back')"><i class="ti ti-arrow-right" :class="{ 'ti-arrow-left': !botbleData?.is_rtl }"></i></button>
      <div class="nbar-title">{{ pageData ? pageData.name : (loading ? __('loading') : __('page_not_found')) }}</div>
    </div>
    
    <div class="scroll" style="padding: 16px;">
      <div v-if="loading" class="loading-state">
        <div class="spinner"></div>
      </div>
      
      <div v-else-if="pageData && pageBlocks.length > 0" class="cms-blocks-container">
        <PageBlocks :blocks="pageBlocks" />
      </div>

      <div v-else-if="pageData" class="cms-content">
        <h1 class="page-title">{{ pageData.name }}</h1>
        <div class="page-body">
          <div v-html="pageData.content"></div>
        </div>
      </div>
      
      <NotFound v-else />
    </div>
  </div>
</template>

<script setup>
import NotFound from './NotFound.vue';
import { __ } from '../utils/i18n';
import { ref, onMounted, inject, watch } from 'vue';
import { useRoute } from 'vue-router';
import api from '../services/api';
import { parseShortcodes } from '../utils/shortcodeParser';
import PageBlocks from '../components/PageBlocks.vue';

const route = useRoute();
const botbleData = window?.BotbleData || {};

const pageData = ref(null);
const pageBlocks = ref([]);
const loading = ref(true);

const fetchPage = async () => {
    loading.value = true;
    
    // Check if it's visual builder preview mode
    if (window.VisualBuilderPage && (route.query.visual_builder || route.path.includes('/preview'))) {
        pageData.value = window.VisualBuilderPage;
        if (pageData.value.content) {
            pageBlocks.value = parseShortcodes(pageData.value.content);
        }
        loading.value = false;
        return;
    }
    
    // Check if path is single segment (e.g. /about-us)
    const slug = route.params.slug || route.path.replace(/^\/(en|ar)\//, '').replace(/^\//, '');
    
    try {
        const response = await api.get(`/pages/${slug}`);
        if (response.data && response.data.data) {
            pageData.value = response.data.data;
            const SITE_NAME = window.BotbleData?.site_title || 'Laly Kuwait';
            document.title = `${pageData.value.name} - ${SITE_NAME}`;
            
            if (pageData.value.content) {
                pageBlocks.value = parseShortcodes(pageData.value.content);
            }
        } else {
            pageData.value = null;
        }
    } catch (e) {
        pageData.value = null;
    } finally {
        loading.value = false;
    }
};

onMounted(() => {
    fetchPage();
});

watch(() => route.path, () => {
    fetchPage();
});
</script>

<style scoped>
.cms-content {
  background: var(--surface);
  border-radius: 15px;
  padding: 30px;
  box-shadow: 0 2px 10px rgba(0,0,0,0.02);
}
.page-title {
  margin-top: 0;
  margin-bottom: 20px;
  font-size: 24px;
  color: var(--primary);
  border-bottom: 1px solid var(--line);
  padding-bottom: 15px;
}
.page-body {
  font-size: 15px;
  line-height: 1.8;
  color: var(--ink);
}
.page-body :deep(img) {
  max-width: 100%;
  height: auto;
  border-radius: 8px;
}
</style>

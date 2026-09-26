<template>
  <div class="home-hero">
    <div class="home-hero-tag" v-if="tag">{{ tag }}</div>
    <div class="home-hero-title">{{ title }}</div>
    <div class="home-hero-sub" v-if="description">{{ description }}</div>
    <router-link v-if="d.internal" :to="toRouterPath(d.button_url || '/products')" class="home-hero-btn">
      <span>{{ buttonText }}</span>
      <i class="ti ti-arrow-left" :class="{ 'ti-arrow-right': !isRtl }" style="font-size:14px;"></i>
    </router-link>
    <a v-else :href="d.button_url" class="home-hero-btn" target="_blank" rel="noopener">
      <span>{{ buttonText }}</span>
      <i class="ti ti-arrow-left" :class="{ 'ti-arrow-right': !isRtl }" style="font-size:14px;"></i>
    </a>
    <div class="hero-circle"></div>
    <div class="hero-circle2"></div>
  </div>
</template>

<script setup>
// Static hero shown only when no "home-slider" exists. Texts come from Theme options
// (Homepage: Hero fallback) and fall back to the translated defaults.
import { computed } from 'vue';
import { __ } from '../../utils/i18n';
import { toRouterPath } from '../../utils/links';

const props = defineProps({ section: { type: Object, required: true } });
const d = computed(() => props.section.data || {});
const isRtl = window.BotbleData?.is_rtl !== false;

const tag = computed(() => d.value.tag || __('offers_week'));
const title = computed(() => d.value.title || __('hero_title'));
const description = computed(() => d.value.description || __('hero_sub'));
const buttonText = computed(() => d.value.button_text || __('shop_now'));
</script>

<style scoped>
.home-hero-btn { text-decoration: none; }
</style>

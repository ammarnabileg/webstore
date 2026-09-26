<template>
  <section class="sblock home-banners" v-if="items.length">
    <div class="banners-row" :class="{ single: items.length === 1 }">
      <template v-for="(banner, index) in items" :key="'banner-' + index">
        <router-link v-if="banner.internal" :to="toRouterPath(banner.link)" class="banners-box">
          <img loading="lazy" :src="banner.image" :alt="section.title || ('Banner ' + (index + 1))" class="banner-img">
        </router-link>
        <a v-else-if="banner.link" :href="banner.link" target="_blank" rel="noopener" class="banners-box">
          <img loading="lazy" :src="banner.image" :alt="section.title || ('Banner ' + (index + 1))" class="banner-img">
        </a>
        <div v-else class="banners-box">
          <img loading="lazy" :src="banner.image" :alt="section.title || ('Banner ' + (index + 1))" class="banner-img">
        </div>
      </template>
    </div>
  </section>
</template>

<script setup>
import { computed } from 'vue';
import { toRouterPath } from '../../utils/links';

const props = defineProps({ section: { type: Object, required: true } });
const items = computed(() => (props.section.data?.items || []).filter(b => b && b.image));
</script>

<style scoped>
.banners-row {
  display: grid;
  grid-template-columns: 1fr;
  gap: 12px;
}
.banners-box {
  display: block;
  overflow: hidden;
  border-radius: var(--radius-md, 12px);
  border: 1px solid var(--line);
  background: var(--surface);
  transition: border-color .2s, box-shadow .2s;
}
.banners-box:hover { border-color: var(--primary); box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
.banner-img {
  width: 100%;
  display: block;
  object-fit: cover;
  transition: transform .3s;
}
.banners-box:hover .banner-img { transform: scale(1.02); }
@media (min-width: 768px) {
  .banners-row { grid-template-columns: 1fr 1fr; gap: 20px; }
  .banners-row.single { grid-template-columns: 1fr; }
}
</style>

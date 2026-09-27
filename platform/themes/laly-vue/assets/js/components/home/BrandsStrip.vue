<template>
  <div class="brands" v-if="items.length">
    <div class="brands-l">{{ section.title || __('trusted_brands') }}</div>
    <div class="marquee" :style="{ '--n': items.length }">
      <div class="mrow" v-for="copy in 2" :key="copy" :aria-hidden="copy === 2">
        <router-link v-for="b in items" :key="copy + '-' + b.id" :to="{ path: '/products', query: { brands: b.id } }" class="brand" :title="b.name">
          <img v-if="b.logo" loading="lazy" :src="b.logo" :alt="b.name">
          <span v-else>{{ b.name }}</span>
        </router-link>
      </div>
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue';
import { __ } from '../../utils/i18n';

const props = defineProps({ section: { type: Object, required: true } });
const items = computed(() => props.section.data?.items || []);
</script>

<style scoped>
.brands { margin-top: 32px; border-block: 1px solid var(--line); background: var(--surface); padding: 18px 0; overflow: hidden; }
.brands-l { text-align: center; font-size: 12px; font-weight: 800; color: var(--ink-2); letter-spacing: 1.2px; margin-bottom: 14px; }
.marquee { display: flex; width: max-content; gap: 56px; direction: ltr; animation: brands-mq calc(var(--n, 8) * 3.2s) linear infinite; }
.brands:hover .marquee { animation-play-state: paused; }
.mrow { display: flex; gap: 56px; align-items: center; }
.brand { font-size: 19px; font-weight: 700; color: var(--ink-2); opacity: .55; white-space: nowrap; text-decoration: none; transition: color .2s, filter .2s; display: flex; align-items: center; }
.brand img { height: 28px; width: auto; max-width: 120px; object-fit: contain; filter: grayscale(1); opacity: .65; transition: filter .2s, opacity .2s; }
.brand:hover { color: var(--primary-strong); }
.brand:hover img { filter: none; opacity: 1; }
@keyframes brands-mq { from { transform: translateX(0) } to { transform: translateX(-50%) } }
/* Phone: static wrapped pills (mockup "index_1") instead of the marquee. */
@media (max-width: 767px) {
  .brands { margin-top: 22px; border: 0; background: none; padding: 0 14px 4px; }
  .brands-l { font-size: 13px; letter-spacing: 0; text-align: start; margin-bottom: 10px; }
  .marquee { animation: none; width: auto; direction: inherit; }
  .mrow { flex-wrap: wrap; justify-content: center; gap: 8px; }
  .mrow[aria-hidden="true"] { display: none; }
  .brand {
    font-size: 11px; font-weight: 800; color: var(--ink-2); background: var(--surface);
    border: 1px solid var(--line); border-radius: 999px; padding: 7px 14px;
  }
  .brand img { height: 16px; max-width: 70px; }
}
@media (prefers-reduced-motion: reduce) { .marquee { animation: none; flex-wrap: wrap; width: auto; justify-content: center; } .mrow[aria-hidden="true"] { display: none; } }
</style>

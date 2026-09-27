<template>
  <section class="home-prods flash-wrap" v-if="!expired && products.length">
    <div class="deals">
      <div class="deals-head">
        <div class="deals-title">
          <span class="flame"><i class="ti ti-bolt" aria-hidden="true"></i></span>
          <div>
            <h2>{{ section.title || __('flash_sale') }}</h2>
            <div class="deals-sub">{{ section.subtitle || section.data.name }}</div>
          </div>
        </div>
        <span class="cdchip" aria-hidden="true">
          <i class="ti ti-clock"></i><b>{{ remaining.days ? remaining.days + ':' : '' }}{{ pad(remaining.hours) }}:{{ pad(remaining.minutes) }}:{{ pad(remaining.seconds) }}</b>
        </span>
        <div class="count" role="timer" :aria-label="__('ends_in')">
          <template v-if="remaining.days">
            <div class="cd"><span class="v">{{ remaining.days }}</span><span class="l">{{ __('days') }}</span></div>
            <span class="csep">:</span>
          </template>
          <div class="cd"><span class="v">{{ pad(remaining.hours) }}</span><span class="l">{{ __('hours') }}</span></div>
          <span class="csep">:</span>
          <div class="cd"><span class="v">{{ pad(remaining.minutes) }}</span><span class="l">{{ __('minutes') }}</span></div>
          <span class="csep">:</span>
          <div class="cd"><span class="v">{{ pad(remaining.seconds) }}</span><span class="l">{{ __('seconds') }}</span></div>
        </div>
      </div>
      <div class="deals-grid" :class="{ few: products.length < 4 }">
        <ProductCard
          v-for="product in products"
          :key="'flash-' + product.id"
          :product="product"
          @quickview="$emit('quickview', $event)"
        />
      </div>
    </div>
  </section>
</template>

<script setup>
import { computed, onMounted, onUnmounted, ref } from 'vue';
import { __ } from '../../utils/i18n';
import ProductCard from '../ProductCard.vue';

const props = defineProps({ section: { type: Object, required: true } });
defineEmits(['quickview']);

const products = computed(() => props.section.data?.products || []);
const endsAt = new Date(props.section.data?.ends_at || 0).getTime();
const now = ref(Date.now());
let timer = null;

// The section unmounts itself the second the sale ends; no "00:00:00" left behind.
const expired = computed(() => !endsAt || now.value >= endsAt);
const remaining = computed(() => {
  const diff = Math.max(0, endsAt - now.value);
  return {
    days: Math.floor(diff / 86400000),
    hours: Math.floor((diff % 86400000) / 3600000),
    minutes: Math.floor((diff % 3600000) / 60000),
    seconds: Math.floor((diff % 60000) / 1000),
  };
});
const pad = (n) => String(n).padStart(2, '0');

onMounted(() => { timer = setInterval(() => { now.value = Date.now(); }, 1000); });
onUnmounted(() => clearInterval(timer));
</script>

<style scoped>
.deals {
  background: linear-gradient(150deg, #fff9ec, #fdf3da 60%, #fbedc9);
  border: 1px solid #f0dfae;
  border-radius: 22px;
  padding: 18px 14px;
  position: relative;
  overflow: hidden;
}
:root[data-theme="dark"] .deals { background: linear-gradient(150deg, #2b2510, #221d0c); border-color: #4a3d16; }
.deals::before {
  content: ""; position: absolute; inset-inline-end: -70px; top: -70px; width: 230px; height: 230px; border-radius: 50%;
  background: radial-gradient(circle, rgba(233,184,76,.35), transparent 65%); pointer-events: none;
}
.deals-head { display: flex; align-items: center; justify-content: space-between; gap: 14px; flex-wrap: wrap; margin-bottom: 16px; position: relative; }
.deals-title { display: flex; align-items: center; gap: 12px; }
.flame {
  width: 44px; height: 44px; border-radius: 14px; flex: none;
  background: var(--sand); color: var(--on-sand); display: grid; place-items: center; font-size: 22px;
  animation: flame-pulse 2.2s ease-in-out infinite;
}
@keyframes flame-pulse { 0%, 100% { box-shadow: 0 0 0 0 rgba(233,184,76,.55) } 55% { box-shadow: 0 0 0 14px rgba(233,184,76,0) } }
.deals-title h2 { font-size: 20px; font-weight: 800; margin: 0; color: var(--ink); }
.deals-sub { font-size: 12.5px; color: #8a7434; font-weight: 700; }
.count { display: flex; align-items: center; gap: 6px; direction: ltr; }
.cd {
  background: var(--deep); color: #fff; border-radius: 12px; min-width: 50px; padding: 7px 6px; text-align: center;
  box-shadow: 0 10px 22px -14px rgba(11,51,59,.7);
}
.cd .v { display: block; font-size: 18px; font-weight: 800; font-variant-numeric: tabular-nums; line-height: 1.1; }
.cd .l { font-size: 10px; color: #9fbdc3; font-weight: 700; }
.csep { font-size: 20px; font-weight: 800; color: var(--sand-strong); }
.deals-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; position: relative; }
.cdchip { display: none; }
/* Phone: plain section with a compact countdown chip and a swipeable row of cards (mockup "index_1"). */
@media (max-width: 767px) {
  .deals { background: none; border: 0; border-radius: 0; padding: 0; overflow: visible; }
  :root[data-theme="dark"] .deals { background: none; }
  .deals::before, .flame, .deals-sub, .count { display: none; }
  .deals-head { flex-wrap: nowrap; margin-bottom: 12px; }
  .deals-title h2 { font-size: 17px; }
  .cdchip {
    display: inline-flex; align-items: center; gap: 5px; flex: none;
    background: var(--deep); color: #fff; border-radius: 10px; padding: 5px 9px; font-size: 12px;
  }
  .cdchip b { color: var(--sand); font-size: 11.5px; font-weight: 800; letter-spacing: .5px; font-variant-numeric: tabular-nums; direction: ltr; }
  .deals-grid {
    display: grid; grid-auto-flow: column; grid-template-columns: none; grid-auto-columns: 172px; gap: 11px;
    overflow-x: auto; scroll-snap-type: x proximity; margin: 0 -14px; padding: 4px 14px 10px; scrollbar-width: none;
  }
  .deals-grid::-webkit-scrollbar { display: none; }
  .deals-grid > * { scroll-snap-align: start; }
}
@media (min-width: 768px) {
  .deals { padding: 28px; }
  .deals-grid { grid-template-columns: repeat(4, 1fr); gap: 14px; }
  .deals-grid.few { grid-template-columns: repeat(auto-fit, minmax(230px, 280px)); }
  .deals-title h2 { font-size: 24px; }
  .cd { min-width: 58px; padding: 9px 8px; }
  .cd .v { font-size: 20px; }
}
</style>

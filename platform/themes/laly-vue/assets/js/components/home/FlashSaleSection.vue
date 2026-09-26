<template>
  <section class="home-prods flash-sale" v-if="!expired && products.length">
    <div class="flash-head">
      <div class="flash-title">
        <i class="ti ti-bolt"></i>
        <span>{{ section.title || __('flash_sale') }}</span>
        <small v-if="section.subtitle || section.data.name">{{ section.subtitle || section.data.name }}</small>
      </div>
      <div class="flash-timer" :aria-label="__('ends_in')">
        <span class="flash-ends">{{ __('ends_in') }}</span>
        <span class="flash-unit" v-if="remaining.days"><b>{{ remaining.days }}</b><i>{{ __('days') }}</i></span>
        <span class="flash-unit"><b>{{ pad(remaining.hours) }}</b><i>{{ __('hours') }}</i></span>
        <span class="flash-unit"><b>{{ pad(remaining.minutes) }}</b><i>{{ __('minutes') }}</i></span>
        <span class="flash-unit"><b>{{ pad(remaining.seconds) }}</b><i>{{ __('seconds') }}</i></span>
      </div>
    </div>
    <div class="prods-grid">
      <ProductCard
        v-for="product in products"
        :key="'flash-' + product.id"
        :product="product"
        @quickview="$emit('quickview', $event)"
      />
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
.flash-head {
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  gap: 8px 12px;
  margin-bottom: 14px;
}
.flash-title {
  display: flex;
  align-items: center;
  gap: 6px;
  font-size: 17px;
  font-weight: 800;
  color: var(--sale);
}
.flash-title small {
  font-size: 12px;
  font-weight: 500;
  color: var(--ink-2);
}
.flash-timer {
  display: flex;
  align-items: center;
  gap: 6px;
  direction: ltr;
}
.flash-ends {
  font-size: 12px;
  color: var(--ink-2);
  margin-inline-end: 4px;
}
.flash-unit {
  display: grid;
  justify-items: center;
  min-width: 34px;
  padding: 3px 4px;
  border-radius: var(--radius-sm, 8px);
  background: var(--sale);
  color: #fff;
  line-height: 1.1;
}
.flash-unit b { font-size: 14px; font-variant-numeric: tabular-nums; }
.flash-unit i { font-style: normal; font-size: 9px; opacity: .85; }
@media (min-width: 992px) {
  .flash-title { font-size: 22px; }
  .flash-unit { min-width: 44px; padding: 5px 6px; }
  .flash-unit b { font-size: 18px; }
  .flash-unit i { font-size: 11px; }
}
</style>

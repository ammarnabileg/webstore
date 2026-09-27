<template>
  <div class="trust-wrap" v-if="items.length">
    <div class="trust-strip" :style="{ '--cols': Math.min(items.length, 5) }">
      <div class="trust-item" v-for="(item, i) in items" :key="i">
        <span class="trust-ic"><i :class="item.icon" aria-hidden="true"></i></span>
        <div>
          <div class="trust-t">{{ item.title }}</div>
          <div class="trust-s" v-if="item.description">{{ item.description }}</div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { computed } from 'vue';

const props = defineProps({ section: { type: Object, required: true } });
const items = computed(() => props.section.data?.items || []);
</script>

<style scoped>
/* Overlaps the hero's bottom edge (negative margin) like a card resting on it. */
.trust-wrap { padding: 0 16px; position: relative; z-index: 5; margin-top: -34px; }
.trust-strip {
  display: grid;
  grid-template-columns: 1fr 1fr;
  background: var(--surface);
  border: 1px solid var(--line);
  border-radius: 18px;
  box-shadow: var(--shadow-card);
  overflow: hidden;
}
.trust-item { display: flex; align-items: center; gap: 11px; padding: 14px 14px; min-width: 0; }
.trust-ic {
  width: 40px; height: 40px; border-radius: 12px; flex: none;
  background: var(--primary-soft); color: var(--primary-strong);
  display: grid; place-items: center; font-size: 20px;
  transition: transform .3s var(--ease);
}
.trust-item:hover .trust-ic { transform: translateY(-4px) rotate(-6deg); }
.trust-t { font-size: 13px; font-weight: 800; color: var(--ink); line-height: 1.25; }
.trust-s { font-size: 11.5px; color: var(--ink-2); line-height: 1.3; }
/* Phone: a single scrollable row of compact chips under the hero card (mockup "index_1"). */
@media (max-width: 767px) {
  .trust-wrap { margin-top: 0; padding: 0; }
  .trust-strip {
    display: grid; grid-auto-flow: column; grid-template-columns: none; gap: 8px;
    overflow-x: auto; padding: 12px 14px 2px; background: none; border: 0; border-radius: 0; box-shadow: none;
    scrollbar-width: none;
  }
  .trust-strip::-webkit-scrollbar { display: none; }
  .trust-item {
    gap: 6px; padding: 8px 13px; background: var(--surface); border: 1px solid var(--line); border-radius: 999px;
    white-space: nowrap;
  }
  .trust-ic { width: auto; height: auto; background: none; font-size: 14px; color: var(--primary-strong); border-radius: 0; }
  .trust-t { font-size: 11px; color: var(--ink-2); }
  .trust-s { display: none; }
}
@media (min-width: 992px) {
  .trust-wrap { max-width: 1240px; margin: -58px auto 0; padding: 0 26px; }
  .trust-strip { grid-template-columns: repeat(var(--cols, 5), 1fr); }
  .trust-item { padding: 20px 22px; gap: 12px; }
  .trust-item + .trust-item { border-inline-start: 1px solid var(--line); }
  .trust-ic { width: 44px; height: 44px; font-size: 22px; }
  .trust-t { font-size: 13.5px; }
}
</style>

<template>
  <div class="tech-trust-bar" v-if="items.length">
    <div class="trust-item" v-for="(item, i) in items" :key="i">
      <i :class="item.icon" aria-hidden="true"></i>
      <div>
        <h4>{{ item.title }}</h4>
        <p v-if="item.description">{{ item.description }}</p>
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
.tech-trust-bar {
  display: flex;
  justify-content: space-between;
  gap: 10px;
  padding: 16px;
  margin: 16px;
  background: var(--surface);
  border: 1px solid var(--line);
  border-radius: var(--radius-md, 12px);
  overflow-x: auto;
  scrollbar-width: none;
}
.tech-trust-bar::-webkit-scrollbar { display: none; }
.trust-item {
  display: flex;
  align-items: center;
  gap: 8px;
  flex: 1 0 auto;
  min-width: 0;
}
.trust-item i { font-size: 24px; color: var(--primary); }
.trust-item h4 { font-size: 11px; font-weight: 700; color: var(--ink); margin: 0 0 2px; }
.trust-item p { font-size: 9px; color: var(--ink-2); margin: 0; }
@media (min-width: 992px) {
  .tech-trust-bar { max-width: 1200px; margin: 30px auto; padding: 24px 30px; }
  .trust-item { gap: 15px; justify-content: center; flex: 1 1 0; }
  .trust-item i { font-size: 36px; }
  .trust-item h4 { font-size: 15px; }
  .trust-item p { font-size: 13px; }
}
</style>

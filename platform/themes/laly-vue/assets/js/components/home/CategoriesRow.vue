<template>
  <section class="sblock home-cats" v-if="items.length">
    <SectionHeader :title="section.title || __('categories')" :subtitle="section.subtitle || __('browse_store')" view-all="/categories" />
    <div class="tiles">
      <router-link
        v-for="cat in items"
        :key="cat.id"
        :to="`/product-categories/${cat.slug}`"
        class="tile"
      >
        <span class="tile-ic">
          <img v-if="cat.image" loading="lazy" :src="cat.image" :alt="cat.name">
          <i v-else :class="cat.icon || 'ti ti-category'" aria-hidden="true"></i>
        </span>
        <span class="tile-l">{{ cat.name }}</span>
      </router-link>
      <router-link to="/categories" class="tile tile-all">
        <span class="tile-ic"><i class="ti ti-layout-grid" aria-hidden="true"></i></span>
        <span class="tile-l">{{ __('view_all') }}</span>
      </router-link>
    </div>
  </section>
</template>

<script setup>
import { computed } from 'vue';
import { __ } from '../../utils/i18n';
import SectionHeader from './SectionHeader.vue';

const props = defineProps({ section: { type: Object, required: true } });
const items = computed(() => props.section.data?.items || []);
</script>

<style scoped>
.tiles { display: grid; grid-template-columns: repeat(3, 1fr); gap: 10px; }
.tile {
  background: var(--surface); border: 1px solid var(--line); border-radius: 16px;
  padding: 18px 8px 14px; display: flex; flex-direction: column; align-items: center; gap: 10px;
  text-align: center; text-decoration: none; color: var(--ink);
  transition: transform .25s var(--ease), border-color .2s, box-shadow .3s;
}
.tile-ic {
  width: 52px; height: 52px; border-radius: 16px; overflow: hidden;
  background: var(--primary-soft); color: var(--primary-strong);
  display: grid; place-items: center; font-size: 25px;
  transition: transform .3s var(--ease), background .2s, color .2s;
}
.tile-ic img { width: 100%; height: 100%; object-fit: cover; }
.tile-l { font-size: 12.5px; font-weight: 700; line-height: 1.35; }
.tile:hover { transform: translateY(-5px); border-color: var(--primary); box-shadow: var(--shadow-card); }
.tile:hover .tile-ic { background: var(--primary-strong); color: #fff; transform: rotate(-8deg) scale(1.06); }
.tile:hover .tile-ic img { opacity: .9; }
/* Phone: one horizontal row of rounded icon squares; "view all" lives in the section header. */
@media (max-width: 767px) {
  .tiles {
    display: grid; grid-auto-flow: column; grid-template-columns: none; gap: 14px;
    overflow-x: auto; padding: 4px 2px 10px; margin: 0 -14px; padding-inline: 14px; scrollbar-width: none;
  }
  .tiles::-webkit-scrollbar { display: none; }
  .tile { width: 68px; padding: 0; gap: 7px; background: none; border: 0; border-radius: 0; }
  .tile-ic {
    width: 60px; height: 60px; border-radius: 20px; background: var(--surface); border: 1.5px solid var(--line);
    box-shadow: var(--shadow-card); font-size: 24px; color: var(--primary-strong);
  }
  .tile-l { font-size: 10.5px; font-weight: 800; color: var(--ink-2); line-height: 1.3; }
  .tile:hover { transform: none; box-shadow: none; }
  .tile:active .tile-ic { transform: scale(.93); border-color: var(--primary); }
  .tile-all { display: none; }
}
@media (min-width: 768px) { .tiles { grid-template-columns: repeat(4, 1fr); gap: 14px; } }
@media (min-width: 992px) { .tiles { grid-template-columns: repeat(8, 1fr); } .tile { padding: 22px 8px 18px; gap: 12px; } }
</style>

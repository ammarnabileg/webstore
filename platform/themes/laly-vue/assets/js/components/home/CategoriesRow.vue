<template>
  <section class="sblock home-cats" v-if="items.length">
    <SectionHeader :title="section.title || __('categories')" :subtitle="section.subtitle" view-all="/categories" />
    <div class="position-relative">
      <button class="cat-nav-btn cat-nav-prev" @click="scroll('prev')" :aria-label="__('back')">
        <i class="ti" :class="isRtl ? 'ti-chevron-right' : 'ti-chevron-left'"></i>
      </button>
      <div class="filter-scroll cats-scroll" ref="container">
        <router-link
          v-for="cat in items"
          :key="cat.id"
          :to="`/product-categories/${cat.slug}`"
          class="cat-item animated-card"
        >
          <div class="cat-card-inner">
            <div class="cat-img">
              <img v-if="cat.image" loading="lazy" :src="cat.image" :alt="cat.name">
              <i v-else :class="cat.icon || 'ti ti-category'"></i>
            </div>
            <span class="cat-name">{{ cat.name }}</span>
          </div>
        </router-link>
      </div>
      <button class="cat-nav-btn cat-nav-next" @click="scroll('next')" :aria-label="__('next')">
        <i class="ti" :class="isRtl ? 'ti-chevron-left' : 'ti-chevron-right'"></i>
      </button>
    </div>
  </section>
</template>

<script setup>
import { computed, ref } from 'vue';
import { __ } from '../../utils/i18n';
import SectionHeader from './SectionHeader.vue';

const props = defineProps({ section: { type: Object, required: true } });
const items = computed(() => props.section.data?.items || []);
const isRtl = window.BotbleData?.is_rtl !== false;
const container = ref(null);

const scroll = (dir) => {
  if (!container.value) return;
  // scrollBy works in the document's writing direction: "next" is always further along the row.
  const step = (dir === 'next' ? 1 : -1) * (isRtl ? -250 : 250);
  container.value.scrollBy({ left: step, behavior: 'smooth' });
};
</script>

<style scoped>
.cat-item { text-decoration: none; color: inherit; }
.cat-nav-btn {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  width: 36px;
  height: 36px;
  border-radius: 50%;
  background: var(--surface);
  border: 1px solid var(--line);
  color: var(--ink);
  display: none;
  align-items: center;
  justify-content: center;
  box-shadow: 0 4px 12px rgba(0,0,0,0.08);
  z-index: 10;
  opacity: 0.85;
}
.cat-nav-btn:hover { background: var(--primary-strong); color: var(--on-primary); opacity: 1; }
.cat-nav-prev { inset-inline-start: -10px; }
.cat-nav-next { inset-inline-end: -10px; }
.cats-scroll { scrollbar-width: none; }
.cats-scroll::-webkit-scrollbar { display: none; }
@media (min-width: 768px) {
  .cat-nav-btn { display: flex; }
}
</style>

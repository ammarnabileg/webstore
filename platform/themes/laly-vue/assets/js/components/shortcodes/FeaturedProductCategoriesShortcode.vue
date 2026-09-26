<template>
  <div class="sblock">
    <h2 class="sec-title" v-if="attributes.title">{{ attributes.title }}</h2>
    
    <div class="filter-scroll cats-scroll" v-if="!store.loading">
      <div class="cat-item animated-card" v-for="cat in store.featuredRootCategories" :key="cat.id" @click="goToCategory(cat)">
        <div class="cat-card-inner">
          <div class="cat-img">
            <img loading="lazy" v-if="cat.image" :src="cat.image" :alt="cat.name">
            <i v-else class="ti ti-category"></i>
          </div>
          <span class="cat-name">{{ cat.name }}</span>
        </div>
      </div>
    </div>
    
    <div v-if="store.loading" style="text-align: center; color: var(--text3); font-size: 13px; padding: 10px;">
      {{ __('loading') || 'جاري التحميل...' }}
    </div>
  </div>
</template>

<script setup>
import { __ } from '../../utils/i18n';
import { inject } from 'vue';
import { useRouter } from 'vue-router';
import { useEcommerceStore } from '../../stores/ecommerce';

const props = defineProps({
  attributes: {
    type: Object,
    default: () => ({})
  }
});

const store = useEcommerceStore();
const router = useRouter();

const goToCategory = (cat) => {
  router.push(`/products?category=${cat.id}`);
};
</script>

<style scoped>
.cats-scroll {
  display: flex;
  overflow-x: auto;
  gap: 12px;
  padding-bottom: 8px;
  -webkit-overflow-scrolling: touch;
}
.cats-scroll::-webkit-scrollbar {
  height: 4px;
}
.cats-scroll::-webkit-scrollbar-thumb {
  background: var(--line);
  border-radius: 4px;
}
.cat-item {
  flex: 0 0 auto;
  cursor: pointer;
}
.cat-card-inner {
  display: flex;
  flex-direction: column;
  align-items: center;
  background: var(--surface);
  border: 1px solid var(--line);
  padding: 15px 20px;
  border-radius: 12px;
  min-width: 100px;
  transition: all 0.2s;
}
.cat-card-inner:hover {
  border-color: var(--primary);
  background: var(--primary-light, rgba(0, 102, 204, 0.05));
}
.cat-img {
  width: 50px;
  height: 50px;
  margin-bottom: 10px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: 50%;
  background: var(--surface-2);
}
.cat-img img {
  max-width: 30px;
  max-height: 30px;
  object-fit: contain;
}
.cat-img i {
  font-size: 24px;
  color: var(--primary);
}
.cat-name {
  font-size: 13px;
  font-weight: 500;
  text-align: center;
  color: var(--ink);
}
</style>

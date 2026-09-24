<template>
  <div class="page">
    <div class="nbar">
      <div class="nbar-title">{{ __('categories') || 'الأقسام' }}</div>
      <div class="nbar-actions">
        <button @click="$router.push('/search')" :aria-label="__('search')"><i class="ti ti-search"></i></button>
      </div>
    </div>
    
    <div class="scroll" style="padding: 16px;">
      <div v-if="store.loading && store.categories.length === 0" class="loading-state">
        <div class="spinner"></div>
      </div>
      
      <div v-else>
        <!-- Loop over root categories (Level 1) -->
        <div v-for="mainCat in store.rootCategories" :key="mainCat.id" class="main-cat-section">
          
          <a :href="mainCat.url || `/product-categories/${mainCat.slug}`" class="main-cat-header" style="text-decoration:none">
            <div class="mc-icon">
              <img loading="lazy" v-if="mainCat.image" :src="mainCat.image" :alt="mainCat.name">
              <i v-else class="ti ti-category"></i>
            </div>
            <h2>{{ mainCat.name }}</h2>
            <i class="ti ti-chevron-left" :class="{ 'ti-chevron-right': !isRtl }"></i>
          </a>

          <!-- Loop over subcategories (Level 2) -->
          <div class="sub-cats-container" v-if="store.getChildren(mainCat.id).length > 0">
            <div v-for="subCat in store.getChildren(mainCat.id)" :key="subCat.id" class="sub-cat-group">
              
              <a :href="subCat.url || `/product-categories/${subCat.slug}`" class="sub-cat-header" style="text-decoration:none">
                <h3>{{ subCat.name }}</h3>
                <span class="view-all">{{ __('view_all') || 'عرض الكل' }}</span>
              </a>

              <!-- Loop over children (Level 3) -->
              <div class="children-grid" v-if="store.getChildren(subCat.id).length > 0">
                <a :href="child.url || `/product-categories/${child.slug}`" v-for="child in store.getChildren(subCat.id)" :key="child.id" class="child-item" style="text-decoration:none">
                  <div class="child-img">
                    <img loading="lazy" v-if="child.image" :src="child.image" :alt="child.name">
                    <i v-else class="ti ti-tag"></i>
                  </div>
                  <span>{{ child.name }}</span>
                </a>
              </div>

            </div>
          </div>
          
        </div>
      </div>

      <div style="height: 80px;"></div>
    </div>
  </div>
</template>

<script setup>
import { onMounted } from 'vue';
import { useEcommerceStore } from '../stores/ecommerce';

const store = useEcommerceStore();
const isRtl = window?.BotbleData?.is_rtl;

onMounted(() => {
    if (store.categories.length === 0) {
        store.fetchCategories();
    }
});
</script>

<style scoped>
.main-cat-section {
  margin-bottom: 24px;
  background: var(--surface);
  border-radius: var(--r14);
  border: 1px solid var(--border2);
  overflow: hidden;
}
.main-cat-header {
  display: flex;
  align-items: center;
  padding: 16px;
  background: var(--surface2);
  cursor: pointer;
  transition: background 0.2s;
}
.main-cat-header:active { background: var(--border); }
.mc-icon {
  width: 44px;
  height: 44px;
  background: var(--bg);
  border-radius: var(--r10);
  display: flex;
  align-items: center;
  justify-content: center;
  margin-inline-end: 12px;
}
.mc-icon img { max-width: 30px; max-height: 30px; object-fit: contain; }
.mc-icon i { font-size: 22px; color: var(--primary); }
.main-cat-header h2 {
  flex: 1;
  font-size: 16px;
  font-weight: 800;
  color: var(--text);
  margin: 0;
}
.main-cat-header > i { font-size: 18px; color: var(--text3); }

.sub-cats-container {
  padding: 16px;
  display: flex;
  flex-direction: column;
  gap: 20px;
}
.sub-cat-group {
  display: flex;
  flex-direction: column;
  gap: 12px;
}
.sub-cat-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  cursor: pointer;
}
.sub-cat-header h3 {
  font-size: 14.5px;
  font-weight: 700;
  color: var(--text);
  margin: 0;
}
.sub-cat-header .view-all {
  font-size: 12px;
  font-weight: 600;
  color: var(--primary);
}

.children-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 10px;
}
@media (min-width: 768px) {
  .children-grid { grid-template-columns: repeat(5, 1fr); gap: 15px; }
  .main-cat-section { margin-bottom: 30px; }
}
.child-item {
  background: var(--bg);
  border: 1px solid var(--border2);
  border-radius: var(--r10);
  padding: 10px;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 6px;
  text-align: center;
  cursor: pointer;
  transition: border-color 0.2s, transform 0.2s;
}
.child-item:hover, .child-item:active {
  border-color: var(--primary);
  transform: translateY(-2px);
}
.child-img {
  width: 40px;
  height: 40px;
  display: flex;
  align-items: center;
  justify-content: center;
}
.child-img img { max-width: 100%; max-height: 100%; object-fit: contain; }
.child-img i { font-size: 20px; color: var(--text3); }
.child-item span {
  font-size: 11px;
  font-weight: 600;
  color: var(--text2);
  line-height: 1.2;
}
</style>

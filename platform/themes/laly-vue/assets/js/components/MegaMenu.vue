<template>
  <div class="mega-menu" :class="{ 'is-collapsed': isCollapsed }" @mouseenter="handleHover(true)" @mouseleave="handleHover(false)">
    <button class="mm-toggle" @click="toggleMenu">
      <i class="ti ti-layout-grid"></i>
      <span class="mm-toggle-text" v-show="!isCollapsed">{{ __('All Categories') || 'All Categories' }}</span>
    </button>

    <div class="mm-panel">
      <ul class="mm-list">
        <li 
          v-for="cat in displayedCategories" 
          :key="cat.id" 
          class="mm-item"
          @mouseenter="activeCategory = cat.id"
          @click="$router.push(`/product-categories/${cat.slug}`)"
        >
          <div class="mm-item-inner">
            <div class="mm-item-left">
              <template v-if="cat.icon_image">
                <img loading="lazy" :src="cat.icon_image" alt="" class="mm-icon-img">
              </template>
              <i v-else-if="cat.icon" :class="[cat.icon, 'mm-icon']"></i>
              <i v-else class="ti ti-category mm-icon"></i>
              <span class="mm-label" v-show="!isCollapsed">{{ cat.name }}</span>
            </div>
            <i class="ti mm-chevron" :class="isRtl ? 'ti-chevron-left' : 'ti-chevron-right'" v-if="store.getChildren(cat.id).length > 0" v-show="!isCollapsed"></i>
          </div>

          <!-- Flyout Panel -->
          <div class="mm-flyout" v-show="activeCategory === cat.id && store.getChildren(cat.id).length > 0">
             <div class="mm-flyout-content">
                <div 
                  v-for="child in store.getChildren(cat.id)" 
                  :key="child.id" 
                  class="mm-sub-item"
                  @click.stop="$router.push(`/product-categories/${child.slug}`)"
                >
                  <span class="mm-sub-label">{{ child.name }}</span>
                </div>
             </div>
          </div>
        </li>
      </ul>

    </div>
  </div>
</template>

<script setup>
const isRtl = window.BotbleData?.is_rtl !== false;
import { ref, computed, watch, onMounted } from 'vue';
import { useRoute, useRouter } from 'vue-router';
import { useEcommerceStore } from '../stores/ecommerce';

const props = defineProps({
  isCollapsed: {
    type: Boolean,
    default: false
  }
});

const emit = defineEmits(['toggle', 'hover']);

const route = useRoute();
const router = useRouter();
const store = useEcommerceStore();

const showMore = ref(false);
const activeCategory = ref(null);

const rootCategories = computed(() => store.rootCategories);

const displayedCategories = computed(() => {
    return rootCategories.value;
});

const toggleMenu = () => {
    emit('toggle');
};

const handleHover = (state) => {
    if (state) {
        emit('hover', false); // force open on hover
    } else {
        activeCategory.value = null;
        emit('hover', true); // revert to closed (parent will check route)
    }
};

onMounted(() => {
    if (!store.categories.length) {
        store.fetchCategories();
    }
});
</script>

<style scoped>
.mega-menu {
    display: none; /* Hidden on mobile */
    height: 100%;
    background: var(--bg);
    border-right: 1px solid rgba(0,0,0,0.05);
    overflow-y: auto;
    overflow-x: visible;
    transition: width 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    width: 260px;
    position: relative;
    z-index: 1000;
}
html[dir="rtl"] .mega-menu {
    border-right: none;
    border-left: 1px solid rgba(0,0,0,0.05);
}
@media (min-width: 992px) {
    .mega-menu {
        display: flex;
        flex-direction: column;
    }
}
.mega-menu::-webkit-scrollbar {
    width: 0; /* Hide scrollbar for a cleaner look */
}

.mega-menu.is-collapsed {
    width: 80px;
}

.mm-toggle {
    display: flex;
    align-items: center;
    gap: 15px;
    padding: 20px;
    background: transparent;
    color: var(--text);
    border: none;
    font-size: 16px;
    font-weight: 700;
    cursor: pointer;
    transition: all 0.3s;
    width: 100%;
    justify-content: flex-start;
    border-bottom: 1px solid rgba(0,0,0,0.05);
}
.mm-toggle i {
    font-size: 24px;
    color: var(--primary);
}
.mm-toggle:hover {
    color: var(--primary);
}
.mega-menu.is-collapsed .mm-toggle {
    justify-content: center;
    padding: 20px 0;
}
.mega-menu.is-collapsed .mm-toggle-text {
    display: none;
}

.mm-panel {
    flex: 1;
    width: 100%;
    background: var(--bg);
}

.mm-list {
    list-style: none;
    margin: 0;
    padding: 10px 0;
}
.mm-item {
    position: relative; /* relative for the flyout to attach properly */
}
.mm-item-inner {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 12px 20px;
    cursor: pointer;
    transition: all 0.2s;
}
.mm-item-inner:hover {
    background: rgba(0,0,0,0.02);
    color: var(--primary);
}

.mega-menu.is-collapsed .mm-item-inner {
    justify-content: center;
    padding: 15px 0;
}

.mm-item-left {
    display: flex;
    align-items: center;
    gap: 15px;
}
.mm-icon {
    width: 28px;
    height: 28px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 26px;
    color: var(--ink-2); 
    flex-shrink: 0;
}
.mm-icon-img {
    width: 28px;
    height: 28px;
    object-fit: contain;
    filter: grayscale(100%) opacity(60%); 
    flex-shrink: 0;
}
.mm-item-inner:hover .mm-icon {
    color: var(--primary);
}
.mm-item-inner:hover .mm-icon-img {
    filter: none; 
}

.mm-label {
    font-size: 15px;
    font-weight: 500;
    color: var(--text);
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    max-width: 150px;
}
.mega-menu.is-collapsed .mm-label {
    display: none;
}

.mm-chevron {
    font-size: 14px;
    color: var(--text3);
}
html[dir="ltr"] .mm-chevron {
    transform: rotate(180deg);
}
.mega-menu.is-collapsed .mm-chevron {
    display: none;
}

.mm-show-more {
    display: flex;
    align-items: center;
    gap: 15px;
    padding: 15px 20px;
    cursor: pointer;
    font-size: 14px;
    font-weight: 600;
    color: var(--primary);
    border-top: 1px solid rgba(0,0,0,0.05);
}
.mm-show-more:hover {
    background: rgba(0,0,0,0.02);
}
.mega-menu.is-collapsed .mm-show-more {
    justify-content: center;
    padding: 15px 0;
}
.mega-menu.is-collapsed .mm-show-more-text {
    display: none;
}

/* FLYOUT */
.mm-flyout {
    position: fixed; 
    top: 120px; 
    right: 260px; /* RTL expanded */
    width: max-content;
    min-width: 400px;
    max-width: 800px;
    height: calc(100vh - 120px);
    background: var(--bg);
    border-radius: 0 0 0 var(--r14);
    box-shadow: 10px 10px 30px rgba(0,0,0,0.08);
    border: 1px solid rgba(0,0,0,0.05);
    padding: 30px;
    z-index: 1001;
    overflow-y: auto;
}
html[dir="ltr"] .mm-flyout {
    right: auto;
    left: 260px;
    box-shadow: -10px 10px 30px rgba(0,0,0,0.08);
    border-radius: 0 0 var(--r14) 0;
}

/* Adjust flyout position if collapsed */
.mega-menu.is-collapsed .mm-flyout {
    right: 80px; 
}
html[dir="ltr"] .mega-menu.is-collapsed .mm-flyout {
    left: 80px;
}

.mm-flyout-content {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
    gap: 15px;
    align-content: flex-start;
}
.mm-sub-item {
    display: flex;
    align-items: center;
    cursor: pointer;
    transition: all 0.2s;
    padding: 6px 0;
}
.mm-sub-item:hover .mm-sub-label {
    color: var(--primary);
}
.mm-sub-label {
    font-size: 14px;
    font-weight: 500;
    color: var(--ink-2);
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}
</style>

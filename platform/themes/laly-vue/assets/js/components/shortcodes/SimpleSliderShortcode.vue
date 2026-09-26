<template>
  <div class="simple-slider-wrapper">
    <div class="hero-scroll-container" v-if="slides.length">
      <div 
        class="home-hero dynamic-hero" 
        v-for="slider in slides" 
        :key="slider.id"
        @click="slider.link ? window.location.href = slider.link : null"
      >
        <picture>
          <img loading="lazy" :src="slider.image" :alt="slider.title || 'banner'" class="hero-img" />
        </picture>
        <div class="hero-content" v-if="slider.title || slider.description">
          <h2 v-if="slider.title">{{ slider.title }}</h2>
          <p v-if="slider.description">{{ slider.description }}</p>
        </div>
      </div>
    </div>
    <div v-else-if="loading" class="slider-loading">
      {{ __('loading') || 'جاري التحميل...' }}
    </div>
  </div>
</template>

<script setup>
import { __ } from '../../utils/i18n';
import { ref, onMounted, inject } from 'vue';
import api from '../../services/api';

const props = defineProps({
  attributes: {
    type: Object,
    default: () => ({})
  }
});

const slides = ref([]);
const loading = ref(true);

onMounted(async () => {
  const key = props.attributes.key || 'home-slider';
  
  // Use preloaded data if available
  if (key === 'home-slider' && window?.BotbleData?.home_sliders?.length) {
    slides.value = window.BotbleData.home_sliders;
    loading.value = false;
    return;
  }
  
  try {
    const response = await api.get(`/sliders/${key}`);
    slides.value = response.data.data || [];
  } catch (error) {
    console.error('Error fetching slider:', error);
  } finally {
    loading.value = false;
  }
});
</script>

<style scoped>
.simple-slider-wrapper {
  margin-bottom: 20px;
}
.hero-scroll-container {
  display: flex;
  overflow-x: auto;
  scroll-snap-type: x mandatory;
  -webkit-overflow-scrolling: touch;
  gap: 15px;
  padding-bottom: 10px;
}
.hero-scroll-container::-webkit-scrollbar {
  display: none;
}
.dynamic-hero {
  flex: 0 0 100%;
  scroll-snap-align: center;
  position: relative;
  border-radius: 12px;
  overflow: hidden;
  min-height: 200px;
  cursor: pointer;
}
.hero-img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  position: absolute;
  top: 0;
  left: 0;
  z-index: 1;
}
.hero-content {
  position: absolute;
  top: 50%;
  left: 30px;
  transform: translateY(-50%);
  z-index: 2;
  color: #fff;
  background: rgba(0,0,0,0.4);
  padding: 15px 20px;
  border-radius: 8px;
}
.slider-loading {
  height: 200px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: var(--surface-2);
  border-radius: 12px;
  color: var(--ink-2);
}

@media (min-width: 768px) {
  .dynamic-hero {
    min-height: 400px;
  }
}
</style>

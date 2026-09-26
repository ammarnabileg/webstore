<template>
  <div class="hero-slider-wrapper" v-if="slides.length">
    <div class="hero-scroll-container" ref="container" @scroll="onScroll">
      <div
        class="hero-slide"
        v-for="slide in slides"
        :key="slide.id"
        :class="{ clickable: !!slide.link }"
        role="link"
        :tabindex="slide.link ? 0 : -1"
        @click="open(slide)"
        @keydown.enter="open(slide)"
      >
        <picture>
          <source :srcset="slide.image" media="(min-width: 768px)" />
          <img loading="lazy" :src="slide.mobile_image || slide.image" :alt="slide.title || ''" class="hero-img" />
        </picture>
        <div class="hero-caption" v-if="slide.title || slide.description || slide.button_text">
          <h2 v-if="slide.title">{{ slide.title }}</h2>
          <p v-if="slide.description">{{ slide.description }}</p>
          <span class="hero-btn" v-if="slide.button_text && slide.link">{{ slide.button_text }}</span>
        </div>
      </div>
    </div>
    <div class="hero-pagination" v-if="slides.length > 1">
      <button
        v-for="(slide, index) in slides"
        :key="'dot-' + slide.id"
        type="button"
        class="hero-dot"
        :class="{ active: current === index }"
        :aria-label="String(index + 1)"
        @click="goTo(index)"
      ></button>
    </div>
  </div>
</template>

<script setup>
import { computed, onMounted, onUnmounted, ref } from 'vue';
import { useRouter } from 'vue-router';
import { toRouterPath } from '../../utils/links';

const props = defineProps({ section: { type: Object, required: true } });
const router = useRouter();
const slides = computed(() => props.section.data?.slides || []);
const container = ref(null);
const current = ref(0);
let timer = null;

const open = (slide) => {
  if (!slide.link) return;
  if (slide.internal) {
    router.push(toRouterPath(slide.link));
  } else {
    window.open(slide.link, '_blank', 'noopener');
  }
};

const onScroll = () => {
  const el = container.value;
  if (!el) return;
  const index = Math.round(Math.abs(el.scrollLeft) / el.clientWidth);
  if (index !== current.value && index < slides.value.length) current.value = index;
};

const goTo = (index) => {
  const el = container.value;
  if (!el || !el.children[index]) return;
  current.value = index;
  el.scrollTo({ left: el.children[index].offsetLeft, behavior: 'smooth' });
  restart();
};

const start = () => {
  if (slides.value.length < 2) return;
  timer = setInterval(() => goTo((current.value + 1) % slides.value.length), 6000);
};
const restart = () => { clearInterval(timer); start(); };

onMounted(start);
onUnmounted(() => clearInterval(timer));
</script>

<style scoped>
.hero-slider-wrapper { position: relative; }
.hero-scroll-container {
  display: flex;
  overflow-x: auto;
  scroll-snap-type: x mandatory;
  -webkit-overflow-scrolling: touch;
  scrollbar-width: none;
  gap: 16px;
  padding: 0 16px;
  margin-top: 14px;
}
.hero-scroll-container::-webkit-scrollbar { display: none; }
.hero-slide {
  position: relative;
  flex: 0 0 calc(100% - 24px);
  scroll-snap-align: center;
  border-radius: var(--r20, 20px);
  overflow: hidden;
}
.hero-slide.clickable { cursor: pointer; }
.hero-img { width: 100%; height: auto; display: block; }
.hero-caption {
  position: absolute;
  inset-inline-start: 0;
  bottom: 0;
  max-width: 80%;
  padding: 16px;
  color: #fff;
  text-shadow: 0 1px 3px rgba(0,0,0,.5);
  background: linear-gradient(to top, rgba(0,0,0,.55), transparent);
  border-start-end-radius: 12px;
}
.hero-caption h2 { font-size: 18px; font-weight: 800; margin: 0 0 4px; }
.hero-caption p { font-size: 12px; margin: 0 0 8px; opacity: .95; }
.hero-btn {
  display: inline-block;
  padding: 6px 14px;
  border-radius: 999px;
  background: var(--primary-strong);
  color: var(--on-primary);
  font-size: 12px;
  font-weight: 700;
  text-shadow: none;
}
.hero-pagination {
  position: absolute;
  bottom: 12px;
  left: 0;
  width: 100%;
  display: flex;
  justify-content: center;
  gap: 8px;
  z-index: 10;
}
.hero-dot {
  width: 8px;
  height: 8px;
  padding: 0;
  border: 0;
  border-radius: 50%;
  background: rgba(255,255,255,.5);
  cursor: pointer;
  transition: all .3s ease;
}
.hero-dot.active { width: 24px; border-radius: 4px; background: var(--surface); }
@media (min-width: 992px) {
  .hero-scroll-container { padding: 0; gap: 0; margin-top: 0; }
  .hero-slide { flex-basis: 100%; border-radius: 0; }
  .hero-caption { padding: 40px 60px; max-width: 55%; }
  .hero-caption h2 { font-size: 36px; }
  .hero-caption p { font-size: 16px; margin-bottom: 14px; }
  .hero-btn { font-size: 14px; padding: 10px 22px; }
  .hero-pagination { bottom: 25px; }
}
</style>

<template>
  <section class="hero" v-if="slides.length" @mouseenter="pause = true" @mouseleave="pause = false">
    <div class="hero-grid">
      <div class="hero-copy-wrap">
        <transition name="hero-fade" mode="out-in">
          <div class="hero-copy" :key="slide.id">
            <span class="hero-eyebrow" v-if="eyebrow"><span class="hero-dotp"></span>{{ eyebrow }}</span>
            <h1 class="hero-title" v-if="slide.title">{{ slide.title }}</h1>
            <p class="hero-sub" v-if="slide.description">{{ slide.description }}</p>
            <div class="hero-ctas">
              <component
                :is="slide.link ? (slide.internal ? 'router-link' : 'a') : 'span'"
                v-bind="slide.link ? (slide.internal ? { to: toRouterPath(slide.link) } : { href: slide.link, target: '_blank', rel: 'noopener' }) : {}"
                class="hero-btn hero-btn-gold"
              >
                {{ slide.button_text || __('shop_now') }}
                <i class="ti ti-arrow-left hero-btn-arrow" aria-hidden="true"></i>
              </component>
              <router-link v-if="wizardEnabled" to="/project-wizard" class="hero-btn hero-btn-ghost">{{ __('book_install') }}</router-link>
            </div>
            <div class="hero-stats" v-if="stats.length">
              <div class="hero-stat" v-for="s in stats" :key="s.label">
                <b>{{ s.value }}</b>
                <span>{{ s.label }}</span>
              </div>
            </div>
          </div>
        </transition>
        <div class="hero-dots" v-if="slides.length > 1">
          <button
            v-for="(s, index) in slides"
            :key="'dot-' + s.id"
            type="button"
            class="hero-dot"
            :class="{ on: current === index }"
            :aria-label="String(index + 1)"
            @click="goTo(index)"
          ></button>
        </div>
      </div>

      <div class="hero-scene">
        <transition name="hero-img" mode="out-in">
          <picture :key="'img-' + slide.id" class="hero-frame" :class="{ clickable: !!slide.link }" @click="open(slide)">
            <source :srcset="slide.image" media="(min-width: 768px)" />
            <img :src="slide.mobile_image || slide.image" :alt="slide.title || ''" class="hero-img" :loading="current === 0 ? 'eager' : 'lazy'" />
          </picture>
        </transition>
      </div>
    </div>
    <svg class="hero-wave" viewBox="0 0 720 80" preserveAspectRatio="none" aria-hidden="true">
      <path d="M0 46C140 12 300 68 470 42 580 26 660 36 720 30L720 80 0 80Z" fill="currentColor"/>
    </svg>
  </section>
</template>

<script setup>
// Copy-led hero: slide title/description/button come from Simple Sliders (home-slider);
// the tag line and the small numbers from Theme options → Homepage: Hero.
import { computed, onMounted, onUnmounted, ref, watch } from 'vue';
import { useRouter } from 'vue-router';
import { __ } from '../../utils/i18n';
import { toRouterPath } from '../../utils/links';

const props = defineProps({ section: { type: Object, required: true } });
const router = useRouter();
const slides = computed(() => props.section.data?.slides || []);
const eyebrow = computed(() => props.section.data?.eyebrow || '');
const stats = computed(() => (props.section.data?.stats || []).slice(0, 3));
const wizardEnabled = !!(window.BotbleData?.wizardEnabled ?? true);
const current = ref(0);
const pause = ref(false);
const slide = computed(() => slides.value[current.value] || slides.value[0]);
let timer = null;

const open = (s) => {
  if (!s.link) return;
  if (s.internal) router.push(toRouterPath(s.link));
  else window.open(s.link, '_blank', 'noopener');
};
const goTo = (index) => { current.value = index; restart(); };
const start = () => {
  if (slides.value.length < 2) return;
  timer = setInterval(() => { if (!pause.value) current.value = (current.value + 1) % slides.value.length; }, 6500);
};
const restart = () => { clearInterval(timer); start(); };
watch(slides, () => { current.value = 0; restart(); });
onMounted(start);
onUnmounted(() => clearInterval(timer));
</script>

<style scoped>
.hero {
  position: relative;
  overflow: hidden;
  color: #fff;
  padding: 28px 16px 64px;
  background:
    radial-gradient(900px 420px at 85% -10%, rgba(255,255,255,.10) 0%, transparent 55%),
    linear-gradient(160deg, var(--deep) 0%, var(--deep) 40%, var(--deep-2) 100%);
}
.hero-grid { display: grid; gap: 22px; max-width: 1240px; margin: 0 auto; }
.hero-eyebrow {
  display: inline-flex; align-items: center; gap: 8px;
  background: rgba(255,255,255,.08); border: 1px solid rgba(255,255,255,.14);
  color: #fff; font-size: 12px; font-weight: 700; padding: 6px 13px; border-radius: 999px;
}
.hero-dotp { width: 7px; height: 7px; border-radius: 50%; background: var(--glow); animation: hero-blink 1.8s ease-in-out infinite; }
@keyframes hero-blink { 0%, 100% { opacity: 1 } 50% { opacity: .25 } }
.hero-title { font-size: 30px; font-weight: 800; line-height: 1.2; margin: 14px 0 6px; color: #fff; }
.hero-sub { color: var(--on-deep); font-size: 14.5px; line-height: 1.65; max-width: 460px; margin: 0 0 20px; }
.hero-ctas { display: flex; gap: 10px; flex-wrap: wrap; }
.hero-btn {
  display: inline-flex; align-items: center; gap: 8px;
  font-weight: 800; font-size: 14px; padding: 12px 20px; border-radius: 11px;
  text-decoration: none; transition: background .18s, transform .18s, box-shadow .25s;
}
.hero-btn:active { transform: scale(.97); }
.hero-btn-gold { background: var(--sand); color: var(--on-sand); }
.hero-btn-gold:hover { background: var(--sand-strong); box-shadow: 0 10px 24px -12px rgba(0,0,0,.25); }
.hero-btn-ghost { background: transparent; border: 1.6px solid rgba(255,255,255,.55); color: #fff; }
.hero-btn-ghost:hover { background: rgba(255,255,255,.1); border-color: #fff; }
.hero-btn-arrow { transition: transform .25s var(--ease); }
.hero-btn-gold:hover .hero-btn-arrow { transform: translateX(-4px); }
[dir="ltr"] .hero-btn-arrow { transform: scaleX(-1); }
[dir="ltr"] .hero-btn-gold:hover .hero-btn-arrow { transform: scaleX(-1) translateX(-4px); }
.hero-stats { display: flex; gap: 22px; margin-top: 26px; flex-wrap: wrap; }
.hero-stat b { display: block; font-size: 19px; font-weight: 800; color: var(--glow); line-height: 1.1; }
.hero-stat span { font-size: 11.5px; color: var(--on-deep); }
.hero-dots { display: flex; align-items: center; gap: 9px; margin-top: 22px; }
.hero-dot { width: 9px; height: 9px; padding: 0; border: 0; border-radius: 999px; background: rgba(255,255,255,.28); cursor: pointer; transition: all .25s; }
.hero-dot.on { width: 26px; background: var(--sand); }
.hero-scene { position: relative; }
.hero-frame {
  display: block; border-radius: 22px; overflow: hidden;
  box-shadow: 0 30px 50px -28px rgba(0,0,0,.6);
  border: 1px solid rgba(255,255,255,.12);
}
.hero-frame.clickable { cursor: pointer; }
.hero-img { width: 100%; height: auto; display: block; aspect-ratio: 16 / 9; object-fit: cover; }
.hero-wave { position: absolute; bottom: -1px; left: 0; width: 100%; height: 44px; color: var(--bg); }
.hero-fade-enter-active { transition: opacity .5s ease, transform .5s var(--ease); }
.hero-fade-leave-active { transition: opacity .25s ease, transform .25s ease; }
.hero-fade-enter-from { opacity: 0; transform: translateY(18px); }
.hero-fade-leave-to { opacity: 0; transform: translateY(-12px); }
.hero-img-enter-active { transition: opacity .6s ease, transform .6s var(--ease); }
.hero-img-leave-active { transition: opacity .25s ease; }
.hero-img-enter-from { opacity: 0; transform: scale(.97); }
.hero-img-leave-to { opacity: 0; }
/* Phone: compact app-style card (mockup "index_1"): copy on the start side, the slide image
   fading in from the end side, no stats / wave (the numbers band carries them further down). */
@media (max-width: 767px) {
  .hero {
    margin: 12px 14px 0; border-radius: 20px; padding: 20px 18px 18px; min-height: 196px;
    background: linear-gradient(140deg, var(--deep), var(--deep-2));
  }
  .hero::after {
    content: ''; position: absolute; inset-inline-end: -46px; top: -46px; width: 150px; height: 150px;
    border-radius: 50%; background: radial-gradient(circle, rgba(255,255,255,.16), transparent 70%); pointer-events: none;
  }
  .hero-grid { display: block; }
  .hero-copy-wrap { position: relative; z-index: 1; max-width: 72%; }
  .hero-eyebrow {
    background: rgba(255,255,255,.14); border-color: rgba(255,255,255,.3); color: #fff;
    font-size: 10px; font-weight: 800; padding: 4px 10px; gap: 6px;
  }
  .hero-dotp { background: var(--sand); width: 6px; height: 6px; }
  .hero-title { font-size: 21px; font-weight: 900; line-height: 1.45; margin: 10px 0 4px; }
  .hero-sub { font-size: 12px; line-height: 1.6; margin: 0 0 14px; color: var(--on-deep); }
  .hero-ctas { gap: 8px; }
  .hero-btn { font-size: 12px; padding: 0 12px; height: 38px; border-radius: 12px; gap: 6px; }
  .hero-btn-ghost { border-width: 1.3px; }
  .hero-stats { display: none; }
  .hero-dots { margin-top: 12px; gap: 5px; }
  .hero-dot { width: 6px; height: 6px; }
  .hero-dot.on { width: 16px; }
  .hero-scene { position: absolute; inset-block: 0; inset-inline-end: 0; width: 40%; }
  .hero-frame { height: 100%; border: 0; border-radius: 0; box-shadow: none; }
  .hero-img { height: 100%; aspect-ratio: auto; opacity: .55; }
  [dir="rtl"] .hero-frame { -webkit-mask-image: linear-gradient(to right, #000 10%, transparent 95%); mask-image: linear-gradient(to right, #000 10%, transparent 95%); }
  [dir="ltr"] .hero-frame { -webkit-mask-image: linear-gradient(to left, #000 10%, transparent 95%); mask-image: linear-gradient(to left, #000 10%, transparent 95%); }
  .hero-wave { display: none; }
}
@media (min-width: 992px) {
  .hero { padding: 64px 26px 110px; }
  .hero-grid { grid-template-columns: 1fr 1.08fr; gap: 40px; align-items: center; }
  .hero-title { font-size: clamp(34px, 4.2vw, 52px); letter-spacing: -.5px; margin: 18px 0 8px; }
  .hero-sub { font-size: 16px; margin-bottom: 26px; }
  .hero-btn { padding: 13px 24px; font-size: 15px; }
  .hero-stat b { font-size: 22px; }
  .hero-wave { height: 72px; }
}
</style>

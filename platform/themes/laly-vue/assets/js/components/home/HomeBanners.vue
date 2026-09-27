<template>
  <section class="sblock home-banners" v-if="items.length">
    <div class="promos" :class="{ single: items.length === 1 }">
      <component
        v-for="(banner, index) in items"
        :key="'banner-' + index"
        :is="banner.link ? (banner.internal ? 'router-link' : 'a') : 'div'"
        v-bind="banner.link ? (banner.internal ? { to: toRouterPath(banner.link) } : { href: banner.link, target: '_blank', rel: 'noopener' }) : {}"
        class="promo"
        :class="{ 'promo-card': !!banner.title, 'promo-plain': !banner.title }"
      >
        <template v-if="banner.title">
          <div class="promo-copy">
            <h3>{{ banner.title }}</h3>
            <p v-if="banner.text">{{ banner.text }}</p>
            <span class="promo-btn" v-if="banner.button_text && banner.link">
              {{ banner.button_text }} <i class="ti ti-arrow-left promo-arrow" aria-hidden="true"></i>
            </span>
          </div>
          <div class="promo-art"><img loading="lazy" :src="banner.image" :alt="banner.title"></div>
        </template>
        <img v-else loading="lazy" :src="banner.image" :alt="section.title || ('Banner ' + (index + 1))" class="banner-img">
      </component>
    </div>
  </section>
</template>

<script setup>
import { computed } from 'vue';
import { toRouterPath } from '../../utils/links';

const props = defineProps({ section: { type: Object, required: true } });
const items = computed(() => (props.section.data?.items || []).filter(b => b && b.image));
</script>

<style scoped>
.promos { display: grid; grid-template-columns: 1fr; gap: 14px; }
.promo {
  position: relative; display: block; overflow: hidden; text-decoration: none; color: var(--ink);
  border: 1px solid var(--line); border-radius: 20px; background: var(--surface);
  transition: transform .3s var(--ease), box-shadow .35s, border-color .2s;
}
.promo:hover { transform: translateY(-4px); box-shadow: var(--shadow-card); border-color: var(--primary); }
.promo-card {
  display: grid; grid-template-columns: 1.05fr .95fr; gap: 12px; align-items: center; padding: 22px 20px;
  background: linear-gradient(135deg, var(--surface), var(--primary-soft));
}
.promo-card h3 { font-size: 18px; font-weight: 800; line-height: 1.3; margin: 0; }
.promo-card p { color: var(--ink-2); font-size: 13px; margin: 8px 0 16px; max-width: 260px; line-height: 1.6; }
.promo-btn {
  display: inline-flex; align-items: center; gap: 8px;
  background: var(--primary-strong); color: var(--on-primary); font-weight: 700; font-size: 13px;
  padding: 10px 18px; border-radius: 11px; transition: background .18s;
}
.promo:hover .promo-btn { background: var(--primary); }
.promo-arrow { transition: transform .25s var(--ease); }
.promo:hover .promo-arrow { transform: translateX(-4px); }
[dir="ltr"] .promo-arrow { transform: scaleX(-1); }
[dir="ltr"] .promo:hover .promo-arrow { transform: scaleX(-1) translateX(-4px); }
.promo-art img {
  width: 100%; max-width: 245px; height: auto; aspect-ratio: 16 / 10; object-fit: cover;
  border-radius: 14px; margin-inline-start: auto; display: block;
  transition: transform .5s var(--ease);
}
.promo:hover .promo-art img { transform: translateY(-6px) scale(1.04); }
.banner-img { width: 100%; display: block; object-fit: cover; transition: transform .3s; }
.promo-plain:hover .banner-img { transform: scale(1.02); }
/* Phone: compact banner rows (mockup "index_1") — thumbnail, two lines of copy, one button.
   The first is dark, the next light, so two banners in a row don't read as one block. */
@media (max-width: 767px) {
  .promos { gap: 12px; }
  .promo-card {
    display: flex; flex-direction: row-reverse; align-items: center; gap: 13px; padding: 14px;
    border-radius: 18px; background: var(--primary-soft); border-color: transparent;
  }
  .promo-card:first-child { background: linear-gradient(135deg, var(--deep), var(--deep-2)); color: #fff; }
  .promo-card:first-child h3 { color: #fff !important; }
  .promo-card:first-child p { color: var(--on-deep); }
  .promo-card:first-child .promo-btn { background: var(--sand); color: var(--on-sand); }
  .promo-copy { flex: 1; min-width: 0; }
  .promo-card h3 { font-size: 13.5px; }
  .promo-card p { font-size: 11px; margin: 2px 0 9px; line-height: 1.5; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; }
  .promo-btn { font-size: 12px; padding: 0 14px; height: 34px; border-radius: 11px; }
  .promo-art { flex: none; width: 88px; }
  .promo-art img { width: 88px; height: 88px; aspect-ratio: 1; border-radius: 14px; max-width: none; }
  .promo:hover { transform: none; box-shadow: none; }
  .promo-plain { border-radius: 18px; }
}
@media (min-width: 768px) {
  .promos { grid-template-columns: 1fr 1fr; gap: 18px; }
  .promos.single { grid-template-columns: 1fr; }
  .promo-card { padding: 30px; }
  .promo-card h3 { font-size: 21px; }
}
</style>

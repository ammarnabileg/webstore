<template>
  <section class="sblock home-stats" v-if="items.length">
    <div class="stats" ref="band">
      <div class="stat" v-for="(s, i) in items" :key="s.label">
        <div class="stat-n">
          <template v-if="parsed[i].numeric">
            <em v-if="parsed[i].prefix">{{ parsed[i].prefix }}</em>{{ shown[i].toLocaleString('en-US') }}<em v-if="parsed[i].suffix">{{ parsed[i].suffix }}</em>
          </template>
          <template v-else>{{ s.value }}</template>
        </div>
        <div class="stat-l">{{ s.label }}</div>
      </div>
    </div>
  </section>
</template>

<script setup>
// Numbers band (Theme options → Homepage: Numbers). A value like "+15000" or "24 h" counts up
// from 0 the first time the band scrolls into view; anything non-numeric ("4.8/5") is shown as typed.
import { computed, onMounted, onUnmounted, ref } from 'vue';

const props = defineProps({ section: { type: Object, required: true } });
const items = computed(() => (props.section.data?.items || []).slice(0, 4));
const parsed = computed(() => items.value.map((s) => {
  const m = String(s.value).trim().match(/^([+\-]?)\s*(\d[\d,]*)\s*([^\d,]{0,6})$/);
  if (!m) return { numeric: false };
  return { numeric: true, prefix: m[1], target: parseInt(m[2].replace(/,/g, ''), 10), suffix: m[3] };
}));
const shown = ref(items.value.map(() => 0));
const band = ref(null);
let observer = null;
let raf = null;

const run = () => {
  const start = performance.now();
  const duration = 1400;
  const tick = (t) => {
    const p = Math.min(1, (t - start) / duration);
    const eased = 1 - Math.pow(1 - p, 3);
    shown.value = parsed.value.map((x) => (x.numeric ? Math.round(x.target * eased) : 0));
    if (p < 1) raf = requestAnimationFrame(tick);
  };
  raf = requestAnimationFrame(tick);
};

onMounted(() => {
  if (!('IntersectionObserver' in window) || window.matchMedia('(prefers-reduced-motion: reduce)').matches) {
    shown.value = parsed.value.map((x) => (x.numeric ? x.target : 0));
    return;
  }
  observer = new IntersectionObserver((entries) => {
    if (entries.some((e) => e.isIntersecting)) { run(); observer.disconnect(); }
  }, { threshold: 0.3 });
  if (band.value) observer.observe(band.value);
});
onUnmounted(() => { observer?.disconnect(); cancelAnimationFrame(raf); });
</script>

<style scoped>
.stats {
  background: linear-gradient(140deg, var(--deep) 20%, var(--deep-2));
  border-radius: 24px; color: #fff; padding: 30px 18px;
  display: grid; grid-template-columns: repeat(2, 1fr); gap: 26px 12px; position: relative; overflow: hidden;
}
.stats::after {
  content: ""; position: absolute; inset-inline-start: -80px; bottom: -120px; width: 280px; height: 280px;
  border-radius: 50%; border: 38px solid rgba(255,255,255,.08); pointer-events: none;
}
.stat { text-align: center; position: relative; }
.stat-n { font-size: 28px; font-weight: 800; color: #fff; font-variant-numeric: tabular-nums; direction: ltr; }
.stat-n em { font-style: normal; color: var(--sand); }
.stat-l { font-size: 12.5px; color: var(--on-deep); margin-top: 4px; font-weight: 700; }
@media (min-width: 992px) {
  .stats { grid-template-columns: repeat(4, 1fr); padding: 44px 34px; gap: 22px; }
  .stat + .stat::before { content: ""; position: absolute; inset-inline-start: 0; top: 12%; height: 76%; width: 1px; background: rgba(255,255,255,.12); }
  .stat-n { font-size: clamp(28px, 3.4vw, 40px); }
}
</style>

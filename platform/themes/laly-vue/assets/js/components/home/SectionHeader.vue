<template>
  <div class="sec-head">
    <div class="sec-head-text">
      <div v-if="subtitle" class="sec-kicker">{{ subtitle }}</div>
      <h2 class="sec-title">{{ title }}</h2>
    </div>
    <router-link v-if="viewAll" :to="viewAll" class="sec-more">
      {{ __('view_all') }} <i class="ti ti-arrow-left sec-more-arrow" aria-hidden="true"></i>
    </router-link>
  </div>
</template>

<script setup>
import { __ } from '../../utils/i18n';

defineProps({
  title: { type: String, default: '' },
  subtitle: { type: String, default: '' },
  viewAll: { type: String, default: '' }
});
</script>

<style scoped>
.sec-head {
  display: flex;
  justify-content: space-between;
  align-items: flex-end;
  gap: 12px;
  margin-bottom: 16px;
}
.sec-kicker {
  display: inline-flex; align-items: center; gap: 8px;
  color: var(--primary-strong); font-size: 12.5px; font-weight: 800; letter-spacing: .3px; margin-bottom: 6px;
}
.sec-kicker::before { content: ""; width: 22px; height: 3px; border-radius: 3px; background: var(--primary); }
.sec-head .sec-title { margin: 0; font-size: 21px; font-weight: 800; line-height: 1.2; letter-spacing: -.3px; color: var(--ink); }
.sec-more {
  flex-shrink: 0; display: inline-flex; align-items: center; gap: 6px;
  font-size: 13.5px; font-weight: 800; color: var(--primary-strong); text-decoration: none; white-space: nowrap;
  transition: gap .2s;
}
.sec-more:hover { gap: 10px; }
[dir="ltr"] .sec-more-arrow { transform: scaleX(-1); }
@media (max-width: 767px) {
  .sec-head { margin-bottom: 12px; align-items: flex-end; }
  .sec-kicker { font-size: 10.5px; font-weight: 900; letter-spacing: .6px; margin-bottom: 2px; gap: 6px; }
  .sec-kicker::before { width: 14px; height: 2.5px; }
  .sec-head .sec-title { font-size: 17px; letter-spacing: -.2px; }
  .sec-more { font-size: 11.5px; gap: 4px; }
}
@media (min-width: 992px) {
  .sec-head { margin-bottom: 22px; }
  .sec-head .sec-title { font-size: 28px; }
}
</style>

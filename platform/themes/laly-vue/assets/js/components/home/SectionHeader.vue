<template>
  <div class="sec-head">
    <div class="sec-head-text">
      <h2 class="sec-title">{{ title }}</h2>
      <p v-if="subtitle" class="sec-subtitle">{{ subtitle }}</p>
    </div>
    <router-link v-if="viewAll" :to="viewAll" class="sec-more">{{ __('view_all') }}</router-link>
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
  margin-bottom: 14px;
}
.sec-head .sec-title {
  margin: 0;
  font-size: 17px;
}
.sec-subtitle {
  margin: 2px 0 0;
  font-size: 13px;
  color: var(--ink-2);
}
.sec-more {
  flex-shrink: 0;
  font-size: 14px;
  font-weight: 700;
  color: var(--primary-strong);
  text-decoration: none;
}
@media (min-width: 992px) {
  .sec-head .sec-title { font-size: 22px; }
}
</style>

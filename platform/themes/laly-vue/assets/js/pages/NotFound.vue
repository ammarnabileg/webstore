<template>
  <div class="not-found">
    <i class="ti ti-map-search not-found-icon" aria-hidden="true"></i>
    <h2>{{ __('page_not_found') }}</h2>
    <p>{{ __('page_not_found_desc') }}</p>
    <router-link to="/" class="not-found-btn">{{ __('back_home') }}</router-link>
  </div>
</template>

<script setup>
import { __ } from '../utils/i18n';
</script>

<style scoped>
.not-found {
  text-align: center;
  padding: 64px 16px;
}
.not-found-icon {
  font-size: 56px;
  color: var(--primary);
}
.not-found h2 {
  margin: 16px 0 8px;
}
.not-found p {
  color: var(--muted, #6b7280);
  margin-bottom: 24px;
}
.not-found-btn {
  display: inline-block;
  padding: 12px 24px;
  border-radius: 12px;
  background: var(--primary);
  color: #fff;
  font-weight: 700;
  text-decoration: none;
}
</style>

<template>
  <router-link to="/project-wizard" class="wizard-cta">
    <i class="ti ti-device-cctv" aria-hidden="true"></i>
    <span class="wizard-cta-text">
      <strong>{{ section.data?.title || __('wizard_cta_title') }}</strong>
      <small>{{ section.data?.subtitle || __('wizard_cta_sub') }}</small>
    </span>
    <i class="ti ti-chevron-left wizard-cta-arrow" aria-hidden="true"></i>
  </router-link>
</template>

<script setup>
import { __ } from '../../utils/i18n';

defineProps({ section: { type: Object, required: true } });
</script>

<style scoped>
.wizard-cta {
  display: flex;
  align-items: center;
  gap: var(--space-3);
  margin: var(--space-4);
  padding: var(--space-4);
  border-radius: var(--radius-lg);
  background: var(--primary-soft);
  border: 1px solid var(--line);
  color: var(--ink);
  text-decoration: none;
}
.wizard-cta > .ti-device-cctv { font-size: 28px; color: var(--primary-strong); }
.wizard-cta-text { display: grid; gap: 2px; flex: 1; }
.wizard-cta-text small { color: var(--ink-2); }
.wizard-cta-arrow { color: var(--primary-strong); }
[dir="ltr"] .wizard-cta-arrow { transform: scaleX(-1); }
@media (min-width: 992px) {
  .wizard-cta { max-width: 1200px; margin: 0 auto 30px; }
}
</style>

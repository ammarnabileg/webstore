<template>
<section class="done">
  <div class="done-ic">
    <svg width="30" height="30" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 6L9 17l-5-5"/></svg>
  </div>
  <h2>{{ __('wiz_done_greeting') }} {{ lead.name || __('wiz_dear') }}</h2>
  <p>{{ __('wiz_done_msg_pre') }} {{ lead.phone }} {{ __('wiz_done_msg_post') }}</p>
  <p v-if="serverEstimate !== null" class="done-estimate">{{ __('wiz_done_estimate') }}: ~{{ Math.round(serverEstimate) }} {{ __('wiz_kwd') }}</p>
</section>
</template>

<script setup>
// Shown after the lead was stored.
import { inject } from 'vue';
import { __ } from '../../utils/i18n';

const { lead, serverEstimate } = inject('wizard');
</script>

<template>
<div class="nav">
  <div class="nav-inner">
    <button v-if="step>1" class="btn btn-ghost" @click="back">{{ __('wiz_back') }}</button>
    <button class="btn btn-primary" :disabled="!canNext || submitting" @click="next">{{ submitting ? __('wiz_submitting') : nextLabel }}</button>
  </div>
</div>
</template>

<script setup>
// Footer: back / next (submits on step 5).
import { inject } from 'vue';
import { __ } from '../../utils/i18n';

const { step, canNext, nextLabel, next, back, submitting } = inject('wizard');
</script>

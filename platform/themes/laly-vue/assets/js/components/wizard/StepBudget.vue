<template>
<section>
  <h1 class="q-title">{{ __('wiz_sb_title') }}</h1>
  <p class="q-hint">{{ __('wiz_sb_hint') }}</p>
  <div class="seg-block">
    <div class="seg">
      <button v-for="(o,i) in budgetOpts" :key="i" class="opt" :class="{sel:a.budget===i}" @click="a.budget=i" :aria-pressed="a.budget===i">{{ o.label }}</button>
    </div>
  </div>
  <div class="seg-block">
    <div class="seg-title">{{ __('wiz_sb_brand') }}</div>
    <div class="seg">
      <button v-for="(o,i) in brandOpts" :key="i" class="opt" :class="{sel:a.brand===i}" @click="a.brand=i" :aria-pressed="a.brand===i">{{ o.label }}</button>
    </div>
  </div>
  <button class="skip" @click="skipBudget">{{ __('wiz_sb_skip') }}</button>
</section>
</template>

<script setup>
// Step 4: optional budget and brand.
import { inject } from 'vue';
import { __ } from '../../utils/i18n';

const { skipBudget, a, budgetOpts, brandOpts } = inject('wizard');
</script>

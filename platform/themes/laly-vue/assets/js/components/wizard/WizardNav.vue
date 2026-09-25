<template>
<div class="nav">
  <div class="nav-inner">
    <button v-if="step>1" class="btn btn-ghost" @click="back">رجوع</button>
    <button class="btn btn-primary" :disabled="!canNext || submitting" @click="next">{{ submitting ? 'جارٍ الإرسال...' : nextLabel }}</button>
  </div>
</div>
</template>

<script setup>
// Footer: back / next (submits on step 5).
import { inject } from 'vue';

const { step, canNext, nextLabel, next, back, submitting } = inject('wizard');
</script>

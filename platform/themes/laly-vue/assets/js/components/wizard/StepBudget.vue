<template>
<section>
  <h1 class="q-title">هل لديك ميزانية تقريبية؟</h1>
  <p class="q-hint">اختياري، ويساعدنا على ترشيح الأنسب لك من المرة الأولى.</p>
  <div class="seg-block">
    <div class="seg">
      <button v-for="(o,i) in budgetOpts" :key="i" class="opt" :class="{sel:a.budget===i}" @click="a.budget=i" :aria-pressed="a.budget===i">{{ o.label }}</button>
    </div>
  </div>
  <div class="seg-block">
    <div class="seg-title">هل تفضّل علامة تجارية معينة؟</div>
    <div class="seg">
      <button v-for="(o,i) in brandOpts" :key="i" class="opt" :class="{sel:a.brand===i}" @click="a.brand=i" :aria-pressed="a.brand===i">{{ o.label }}</button>
    </div>
  </div>
  <button class="skip" @click="skipBudget">تخطَّ، لم أحدد بعد</button>
</section>
</template>

<script setup>
// Step 4: optional budget and brand.
import { inject } from 'vue';

const { skipBudget, a, budgetOpts, brandOpts } = inject('wizard');
</script>

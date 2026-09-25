<template>
<section>
  <h1 class="q-title">لأي مكان هذا النظام؟</h1>
  <p class="q-hint">اختر نوع المكان وسنتولى الباقي.</p>
  <div class="grid">
    <button v-for="p in placeTypes" :key="p.id" class="opt"
            :class="{sel: a.place===p.id}" @click="a.place=p.id"
            :aria-pressed="a.place===p.id">
      <span class="ic" v-html="icon(p.icon)"></span>
      {{ p.label }}
    </button>
  </div>
</section>
</template>

<script setup>
// Step 1: place type.
import { inject } from 'vue';

const { a, placeTypes, icon } = inject('wizard');
</script>

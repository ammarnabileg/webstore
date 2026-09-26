<template>
<section>
  <h1 class="q-title">{{ __('wiz_pt_title') }}</h1>
  <p class="q-hint">{{ __('wiz_pt_hint') }}</p>
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
import { __ } from '../../utils/i18n';

const { a, placeTypes, icon } = inject('wizard');
</script>

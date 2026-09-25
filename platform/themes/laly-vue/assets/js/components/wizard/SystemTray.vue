<template>
<div class="tray">
  <div class="tray-inner">
    <div class="tray-card">
      <span class="tray-title"><span class="rec-dot" aria-hidden="true"></span> نظامك قيد التجهيز</span>
      <span v-for="c in trayChips" :key="c" class="chip">{{ c }}</span>
    </div>
  </div>
</div>
</template>

<script setup>
// Live "your system" chips above the footer (steps 2-4).
import { inject } from 'vue';

const { trayChips } = inject('wizard');
</script>

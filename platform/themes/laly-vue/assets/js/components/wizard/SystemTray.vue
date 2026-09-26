<template>
<div class="tray">
  <div class="tray-inner">
    <div class="tray-card">
      <span class="tray-title"><span class="rec-dot" aria-hidden="true"></span> {{ __('wiz_tray_title') }}</span>
      <span v-for="c in trayChips" :key="c" class="chip">{{ c }}</span>
    </div>
  </div>
</div>
</template>

<script setup>
// Live "your system" chips above the footer (steps 2-4).
import { inject } from 'vue';
import { __ } from '../../utils/i18n';

const { trayChips } = inject('wizard');
</script>

<template>
<section>
  <h1 class="q-title">{{ __('wiz_sn_title') }}</h1>
  <p class="q-hint">{{ __('wiz_sn_hint') }}</p>
  <div class="grid one">
    <button v-for="g in goals" :key="g.id" class="opt row"
            v-show="g.id!=='perimeter' || a.outdoor"
            :class="{sel: a.goals.includes(g.id)}" @click="toggleGoal(g.id)"
            :aria-pressed="a.goals.includes(g.id)">
      <span class="ic" v-html="icon(g.icon)"></span>
      <span>{{ g.label }}<br><span class="sub">{{ g.sub }}</span></span>
      <span class="check" aria-hidden="true">
        <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"><path d="M20 6L9 17l-5-5"/></svg>
      </span>
    </button>
  </div>

  <div class="seg-block" v-if="wantsWifi" style="margin-top:18px;">
    <div class="seg-title">{{ __('wiz_sn_devices') }}</div>
    <div class="seg">
      <button v-for="(o,i) in deviceOpts" :key="i" class="opt" :class="{sel:a.devices===i}" @click="a.devices=i" :aria-pressed="a.devices===i">{{ o.label }}</button>
    </div>
  </div>

  <div class="seg-block" v-if="wantsCams" style="margin-top:6px;">
    <div class="seg-title">{{ __('wiz_sn_record') }}</div>
    <div class="seg">
      <button v-for="(o,i) in recordOpts" :key="i" class="opt" :class="{sel:a.recordDays===i}" @click="a.recordDays=i" :aria-pressed="a.recordDays===i">{{ o.label }}</button>
    </div>
    <p class="plan-hint" v-if="isCommercial" style="margin-top:8px;">{{ moiNotice }}</p>
    <p class="plan-hint" v-if="isCommercial && a.recordDays!==null && recordOpts[a.recordDays].days < 180" style="color:var(--rec);margin-top:4px;">{{ __('wiz_sn_moi_warn') }}</p>
  </div>

  <div class="seg-block" v-if="wantsCams">
    <div class="seg-title">{{ __('wiz_sn_internet') }} <span style="font-weight:400;color:var(--muted);">{{ __('wiz_sn_internet_note') }}</span></div>
    <div class="seg">
      <button class="opt" :class="{sel:a.internet==='yes'}" @click="a.internet='yes'" :aria-pressed="a.internet==='yes'">{{ __('wiz_yes') }}</button>
      <button class="opt" :class="{sel:a.internet==='no'}" @click="a.internet='no'" :aria-pressed="a.internet==='no'">{{ __('wiz_no') }}</button>
    </div>
  </div>

  <div class="seg-block" v-if="zoomVisible">
    <div class="seg-title">{{ __('wiz_sn_zoom') }} <span style="font-weight:400;color:var(--muted);">{{ __('wiz_sn_zoom_note') }}</span></div>
    <div class="seg">
      <button class="opt" :class="{sel:a.zoom===true}" @click="a.zoom=true" :aria-pressed="a.zoom===true">{{ __('wiz_yes') }}</button>
      <button class="opt" :class="{sel:a.zoom===false}" @click="a.zoom=false" :aria-pressed="a.zoom===false">{{ __('wiz_no') }}</button>
    </div>
  </div>
</section>
</template>

<script setup>
// Step 3: goals and the follow-up questions they unlock.
import { inject } from 'vue';
import { __ } from '../../utils/i18n';

const { a, deviceOpts, recordOpts, goals, toggleGoal, wantsWifi, wantsCams, zoomVisible, isCommercial, moiNotice, icon } = inject('wizard');
</script>

<template>
<section>
  <h1 class="q-title">{{ __('wiz_pd_title') }}</h1>
  <p class="q-hint">{{ __('wiz_pd_hint') }}</p>

  <div class="seg-block">
    <div class="seg-title">{{ __('wiz_pd_area') }}</div>
    <div class="seg">
      <button v-for="(o,i) in areaOpts" :key="i" class="opt" :class="{sel:a.area===i}" @click="a.area=i" :aria-pressed="a.area===i">{{ o.label }}</button>
    </div>
  </div>

  <div class="seg-block">
    <div class="seg-title">{{ __('wiz_pd_floors') }}</div>
    <div class="seg">
      <button v-for="(o,i) in floorOpts" :key="i" class="opt" :class="{sel:a.floors===i}" @click="a.floors=i" :aria-pressed="a.floors===i">{{ o.label }}</button>
    </div>
  </div>

  <div class="seg-block">
    <div class="seg-title">{{ __('wiz_pd_entrances') }}</div>
    <div class="seg">
      <button v-for="(o,i) in entranceOpts" :key="i" class="opt" :class="{sel:a.entrances===i}" @click="a.entrances=i" :aria-pressed="a.entrances===i">{{ o.label }}</button>
    </div>
  </div>

  <div class="seg-block">
    <div class="seg-title">{{ __('wiz_pd_outdoor') }}</div>
    <div class="seg">
      <button class="opt" :class="{sel:a.outdoor===true}" @click="a.outdoor=true" :aria-pressed="a.outdoor===true">{{ __('wiz_yes') }}</button>
      <button class="opt" :class="{sel:a.outdoor===false}" @click="a.outdoor=false" :aria-pressed="a.outdoor===false">{{ __('wiz_no') }}</button>
    </div>
  </div>

  <div class="seg-block">
    <div class="seg-title">{{ __('wiz_pd_condition') }}</div>
    <div class="seg">
      <button v-for="(o,i) in conditionOpts" :key="i" class="opt" :class="{sel:a.condition===i}" @click="a.condition=i" :aria-pressed="a.condition===i">{{ o.label }}</button>
    </div>
  </div>

  <div class="seg-block" v-if="a.condition===2">
    <div class="seg-title">{{ __('wiz_pd_conduits') }}</div>
    <div class="seg">
      <button class="opt" :class="{sel:a.conduits==='yes'}" @click="a.conduits='yes'" :aria-pressed="a.conduits==='yes'">{{ __('wiz_pd_conduits_yes') }}</button>
      <button class="opt" :class="{sel:a.conduits==='no'}" @click="a.conduits='no'" :aria-pressed="a.conduits==='no'">{{ __('wiz_no') }}</button>
      <button class="opt" :class="{sel:a.conduits==='unsure'}" @click="a.conduits='unsure'" :aria-pressed="a.conduits==='unsure'">{{ __('wiz_pd_conduits_unsure') }}</button>
    </div>
    <p class="plan-hint" v-if="a.conduits==='unsure'" style="margin-top:8px;">{{ __('wiz_pd_conduits_hint') }}</p>
  </div>
</section>
</template>

<script setup>
// Step 2: area, floors, entrances, outdoor areas, condition.
import { inject } from 'vue';
import { __ } from '../../utils/i18n';

const { a, areaOpts, floorOpts, entranceOpts, conditionOpts } = inject('wizard');
</script>

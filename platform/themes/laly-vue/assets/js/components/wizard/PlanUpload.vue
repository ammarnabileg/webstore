<template>
<div>
<template v-if="!plan.img">
  <label class="plan-upload">
    <input type="file" accept="image/*" @change="onPlanFile" hidden>
    {{ __('wiz_plan_upload') }}
  </label>
  <div class="err" v-if="plan.err" style="margin-top:8px;color:var(--rec);font-size:12.5px;">{{ plan.err }}</div>
</template>
<template v-else>
  <div class="plan-tools">
    <button v-for="pt in pinTypes" :key="pt.id" class="tool" :class="{sel: plan.tool===pt.id}" @click="plan.tool=pt.id" :aria-pressed="plan.tool===pt.id">
      <span v-html="icon(pt.icon)"></span> {{ pt.label }}
    </button>
    <button class="tool danger" @click="clearPlan">{{ __('wiz_plan_clear') }}</button>
  </div>
  <div class="plan-stage" @click="placePin">
    <img :src="plan.img" :alt="__('wiz_plan_alt')">
    <div v-for="(p,i) in plan.pins" :key="i" class="pin" :class="p.t"
         :style="{left:p.x+'%', top:p.y+'%'}"
         @pointerdown.stop.prevent="startDrag(p,$event)" @click.stop>
      <span v-html="icon(pinIcon(p.t))"></span>
      <button class="x" @pointerdown.stop @click.stop="removePin(i)" aria-label="احذف العلامة">×</button>
    </div>
  </div>
  <p class="plan-hint">{{ __('wiz_plan_hint_pre') }} «{{ pinLabel(plan.tool) }}»{{ __('wiz_plan_hint_post') }}</p>
</template>
</div>
</template>

<script setup>
// Plan box, "upload a picture" tab: image with draggable pins.
import { inject } from 'vue';
import { __ } from '../../utils/i18n';

const { icon, plan, pinTypes, pinIcon, pinLabel, onPlanFile, clearPlan, placePin, removePin, startDrag } = inject('wizard');
</script>

<template>
<div>
<template v-if="!plan.img">
  <label class="plan-upload">
    <input type="file" accept="image/*" @change="onPlanFile" hidden>
    ارفع صورة المخطط، أو حتى رسمًا بيدك على ورقة
  </label>
  <div class="err" v-if="plan.err" style="margin-top:8px;color:var(--rec);font-size:12.5px;">{{ plan.err }}</div>
</template>
<template v-else>
  <div class="plan-tools">
    <button v-for="pt in pinTypes" :key="pt.id" class="tool" :class="{sel: plan.tool===pt.id}" @click="plan.tool=pt.id" :aria-pressed="plan.tool===pt.id">
      <span v-html="icon(pt.icon)"></span> {{ pt.label }}
    </button>
    <button class="tool danger" @click="clearPlan">امسح المخطط</button>
  </div>
  <div class="plan-stage" @click="placePin">
    <img :src="plan.img" alt="مخطط المكان">
    <div v-for="(p,i) in plan.pins" :key="i" class="pin" :class="p.t"
         :style="{left:p.x+'%', top:p.y+'%'}"
         @pointerdown.stop.prevent="startDrag(p,$event)" @click.stop>
      <span v-html="icon(pinIcon(p.t))"></span>
      <button class="x" @pointerdown.stop @click.stop="removePin(i)" aria-label="احذف العلامة">×</button>
    </div>
  </div>
  <p class="plan-hint">اضغط على المخطط لإضافة علامة «{{ pinLabel(plan.tool) }}»، واسحب أي علامة لتحريكها. لا يلزم أن تكون دقيقًا، فالفني يحدّد الأماكن النهائية في المعاينة.</p>
</template>
</div>
</template>

<script setup>
// Plan box, "upload a picture" tab: image with draggable pins.
import { inject } from 'vue';

const { icon, plan, pinTypes, pinIcon, pinLabel, onPlanFile, clearPlan, placePin, removePin, startDrag } = inject('wizard');
</script>

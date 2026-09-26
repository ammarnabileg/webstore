<template>
<div>
  <div class="plan-tools">
    <button class="tool" :class="{sel:sk.mode==='room'}" @click="sk.mode='room'" :aria-pressed="sk.mode==='room'">
      <span v-html="icon('room')"></span> {{ __('wiz_fs_area_tool') }}
    </button>
    <button v-for="pt in pinTypes" :key="pt.id" class="tool" :class="{sel:sk.mode===pt.id}" @click="sk.mode=pt.id" :aria-pressed="sk.mode===pt.id">
      <span v-html="icon(pt.icon)"></span> {{ pt.label }}
    </button>
    <button class="tool" @click="skUndo" :disabled="!sk.hist.length">{{ __('wiz_fs_undo') }}</button>
    <button class="tool danger" v-if="sk.rooms.length || sk.pins.length" @click="skClear">{{ __('wiz_fs_clear') }}</button>
  </div>

  <div class="floor-tabs" v-if="floorsAvail.length > 1">
    <button v-for="f in floorsAvail" :key="f.id" :class="{sel: sk.floor===f.id}" @click="sk.floor=f.id" :aria-pressed="sk.floor===f.id">
      {{ floorLabel(f.id) }} <span class="cnt" v-if="floorCount(f.id)">({{ floorCount(f.id) }})</span>
    </button>
  </div>

  <div class="live-price" v-if="livePkg">
    <span>{{ __('wiz_fs_price_pre') }} {{ livePkg.title }} {{ __('wiz_fs_price_now') }} <span style="color:var(--muted);">{{ __('wiz_fs_price_note') }}</span></span>
    <b>~{{ livePkg.total }} {{ __('wiz_kwd') }}</b>
  </div>

  <div class="label-chips" v-if="sk.sel!==null && sk.rooms[sk.sel]">
    <span style="font-size:12px;color:var(--muted);">{{ __('wiz_fs_name_room') }}</span>
    <button v-for="l in roomLabels" :key="l" class="lchip" :class="{out: zoneType(l)==='out'}" @click="labelRoom(l)">{{ roomLabel(l) }}</button>
  </div>

  <div class="sketch-stage" @pointerdown="stageDown" @click="sketchPlacePin">
    <div v-for="(r,i) in sk.rooms" :key="'r'+i" class="room" :class="{sel: sk.sel===i, out: zoneType(r.label)==='out'}"
         v-show="(r.floor||'g')===sk.floor"
         :style="{left:r.x+'%', top:r.y+'%', width:r.w+'%', height:r.h+'%'}"
         @pointerdown.stop="roomDown(i,$event)" @click.stop="roomClick(i,$event)">
      <span class="lbl">{{ roomLabel(r.label) }}</span>
      <button class="x" @pointerdown.stop @click.stop="delRoom(i)" :aria-label="__('wiz_fs_del_room')">×</button>
      <span class="handle" @pointerdown.stop="resizeDown(i,$event)" aria-hidden="true"></span>
    </div>
    <div v-if="sk.draft" class="room draft"
         :style="{left:sk.draft.x+'%', top:sk.draft.y+'%', width:sk.draft.w+'%', height:sk.draft.h+'%'}"></div>
    <div v-for="(p,i) in sk.pins" :key="'p'+i" class="pin" :class="p.t"
         v-show="(p.floor||'g')===sk.floor"
         :style="{left:p.x+'%', top:p.y+'%'}"
         @pointerdown.stop.prevent="skPinDrag(p,$event)" @click.stop>
      <span v-html="icon(pinIcon(p.t))"></span>
      <button class="x" @pointerdown.stop @click.stop="delSkPin(i)" :aria-label="__('wiz_fs_del_pin')">×</button>
    </div>
    <div v-if="!sk.rooms.length && !sk.draft && !sk.dismiss" class="sketch-empty" style="pointer-events:auto;">
      <div>
        <p style="margin-bottom:10px;">{{ __('wiz_fs_gen_prompt') }}</p>
        <div style="display:flex;gap:8px;justify-content:center;">
          <button class="lchip" style="border-color:var(--primary);color:var(--primary-ink);background:var(--primary-soft);" @pointerdown.stop @click.stop="generateStarter">{{ __('wiz_fs_gen_yes') }}</button>
          <button class="lchip" @pointerdown.stop @click.stop="sk.dismiss=true">{{ __('wiz_fs_gen_no') }}</button>
        </div>
      </div>
    </div>
    <p v-else-if="!sk.rooms.length && !sk.draft" class="sketch-empty">{{ __('wiz_fs_draw_hint') }}</p>
  </div>
  <p class="plan-hint" v-if="sketchCams.in + sketchCams.out > 0" style="color:var(--ink);">{{ __('wiz_fs_cams_pre') }} <b>{{ sketchCams.in }}</b> {{ __('wiz_fs_indoor') }} · <b>{{ sketchCams.out }}</b> {{ __('wiz_fs_outdoor') }}{{ __('wiz_fs_cams_post') }}</p>
  <p class="plan-hint" v-if="sketchWiring.nets + sketchWiring.tvs > 0 || sketchWiring.rack" style="color:var(--ink);">{{ __('wiz_fs_wiring_pre') }} {{ sketchWiring.nets }} {{ __('wiz_fs_net') }} · {{ sketchWiring.tvs }} {{ __('wiz_fs_tv') }} · {{ __('wiz_fs_rack') }} {{ sketchWiring.rack ? __('wiz_fs_rack_set') : __('wiz_fs_rack_unset') }}{{ __('wiz_fs_wiring_post') }}</p>
  <p class="plan-hint">{{ __('wiz_fs_hint_main') }}</p>
</div>
</template>

<script setup>
// Plan box, "draw it yourself" tab: rooms and pins per floor (state in useSketch.js).
import { inject } from 'vue';
import { __ } from '../../utils/i18n';
// Room labels are stable ids (e.g. 'hall','yard') so pricing/zone matching never
// depends on display text; render them through i18n.
const roomLabel = (id) => { const key = 'room_' + id; return __(key); };
const floorLabel = (id) => { const key = 'wiz_floor_lvl_' + id; return __(key); };

const { icon, livePkg, pinTypes, pinIcon, sk, roomLabels, zoneType, floorsAvail, floorCount, sketchCams, sketchWiring, skUndo, skClear, generateStarter, stageDown, roomDown, resizeDown, sketchPlacePin, roomClick, delRoom, delSkPin, skPinDrag, labelRoom } = inject('wizard');
</script>

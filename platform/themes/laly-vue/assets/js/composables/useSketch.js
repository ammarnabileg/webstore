import { reactive, ref, computed } from 'vue';

/**
 * Pointer drag helper shared by the sketch editor and the uploaded-plan pins:
 * moves `pin` (x/y in %) inside the closest stage while the pointer is down.
 */
export function startDrag(pin, e){
  const stage = e.currentTarget.closest('.plan-stage, .sketch-stage');
  if(!stage) return;
  const rect = stage.getBoundingClientRect();
  const move = ev=>{
    pin.x = Math.min(99, Math.max(1, ((ev.clientX - rect.left)/rect.width)*100));
    pin.y = Math.min(99, Math.max(1, ((ev.clientY - rect.top)/rect.height)*100));
  };
  const up = ()=>{ window.removeEventListener('pointermove', move); window.removeEventListener('pointerup', up); };
  window.addEventListener('pointermove', move);
  window.addEventListener('pointerup', up);
}

/**
 * Floor sketch editor: rooms (labelled rectangles) and pins per floor.
 * `needs()` returns the question-based {indoor, outdoor, ap} counts the starter sketch reproduces.
 */
export function useSketch(a, { floorOpts, entranceOpts, pinTypes }, needs) {
    const PIN_MODES = pinTypes.map(p=>p.id);

    // ---- أداة الرسم: مستطيلات (أوض) بأسماء + دبابيس — مقيّدة عمداً عشان الناتج يفضل مقروء ----
    const planTab = ref('draw');
    const sk = reactive({ mode:'room', rooms:[], pins:[], sel:null, draft:null, hist:[], generated:false, dismiss:false, floor:'g' });
    // مفردات لكل نوع مكان — الاحترافية إن المكتب مايشوفش "غرفة نوم"
    const VOCAB = {
      apartment: {in:['hall','bedroom','kitchen','bathroom','entrance','corridor'], out:['balcony']},
      villa:     {in:['hall','bedroom','kitchen','bathroom','entrance','corridor'], out:['yard','garden','garage','parking']},
      compound:  {in:['hall','bedroom','kitchen','bathroom','entrance','corridor'], out:['yard','garden','garage','parking']},
      shop:      {in:['hall','storage','office','bathroom','entrance'],      out:['parking']},
      office:    {in:['reception','office','meeting','corridor','bathroom','storage'], out:['parking']},
      warehouse: {in:['storage','office','bathroom','entrance'],             out:['courtyard','parking']},
    };
    const roomLabels = computed(()=>{
      const v = VOCAB[a.place] || VOCAB.villa;
      const extra = floorsAvail.value.length > 1 ? ['stairs'] : [];
      return [...v.in, ...extra, ...v.out];
    });
    const ZONE = {'hall':'in','bedroom':'in','kitchen':'in','bathroom':'in','entrance':'in','corridor':'in','office':'in','storage':'in','reception':'in','meeting':'in','room':'in','stairs':'in','yard':'out','garden':'out','garage':'out','parking':'out','balcony':'out','courtyard':'out'};
    const zoneType = l => ZONE[l] || 'in';
    // الأدوار المتاحة بتتولد من إجابة "عدد الأدوار" ونوع المكان — دور واحد = مفيش تابات ولا احتكاك
    const FLOOR_DEFS = [{id:'g',label:'الأرضي'},{id:'f1',label:'الأول'},{id:'f2',label:'الثاني'},{id:'roof',label:'السطح'}];
    const floorsAvail = computed(()=>{
      const v = a.floors!==null ? floorOpts[a.floors].v : 1;
      const list = [FLOOR_DEFS[0]];
      if(v>=2) list.push(FLOOR_DEFS[1]);
      if(v>=3) list.push(FLOOR_DEFS[2]);
      if(a.place!=='apartment' && v>=2) list.push(FLOOR_DEFS[3]);
      return list;
    });
    const floorCount = id => sk.rooms.filter(r=>(r.floor||'g')===id).length + sk.pins.filter(p=>(p.floor||'g')===id).length;
    // تصنيف العلامة حسب زونات نفس الدور بس — برة كل الزونات = خارجي (محيط أو سطح مكشوف)
    const classifyPin = p => {
      let t = 'out';
      sk.rooms.forEach(r => {
        if((r.floor||'g')===(p.floor||'g') && p.x>=r.x && p.x<=r.x+r.w && p.y>=r.y && p.y<=r.y+r.h) t = zoneType(r.label);
      });
      return t;
    };
    const sketchCams = computed(()=>{
      const c = {in:0, out:0};
      sk.pins.forEach(p=>{ if(p.t==='cam') c[classifyPin(p)]++; });
      return c;
    });
    const sketchAps = computed(()=> sk.pins.filter(p=>p.t==='ap').length);
    const sketchWiring = computed(()=>({
      nets: sk.pins.filter(p=>p.t==='net').length,
      tvs:  sk.pins.filter(p=>p.t==='tv').length,
      rack: sk.pins.some(p=>p.t==='rack'),
    }));
    const snapV = v => Math.min(100, Math.max(0, Math.round(v/2)*2));
    const pct = (rect, ev) => ({
      x: ((ev.clientX - rect.left)/rect.width)*100,
      y: ((ev.clientY - rect.top)/rect.height)*100,
    });
    function snapPush(){
      sk.hist.push(JSON.stringify({rooms:sk.rooms, pins:sk.pins}));
      if(sk.hist.length>30) sk.hist.shift();
    }
    function skUndo(){
      const s = sk.hist.pop();
      if(!s) return;
      const o = JSON.parse(s);
      sk.rooms.splice(0, sk.rooms.length, ...o.rooms);
      sk.pins.splice(0, sk.pins.length, ...o.pins);
      sk.sel = null; sk.draft = null;
    }
    function skClear(){ snapPush(); sk.rooms.splice(0); sk.pins.splice(0); sk.sel=null; sk.draft=null; sk.generated=false; sk.dismiss=false; sk.floor='g'; }

    // ---- الرسمة المبدئية: تتولد من إجابات الويزارد — بزرار صريح، مش تلقائي ----
    // قاعدة ثابتة: أعداد البنات المولّدة = أعداد heuristic الأسئلة بالظبط، عشان سعر الباقة مايتحركش لما الرسمة تظهر
    const clampV = (v,min,max)=> Math.min(max, Math.max(min, v));
    function generateStarter(){
      snapPush();
      // نلقط الأعداد قبل ما نحط بنات، لأن أول بن هيخلي camCounts يقرا من الرسمة
      const { indoor: needIn, outdoor: needOut, ap: needAp } = needs();
      sk.rooms.splice(0); sk.pins.splice(0);
      const out = a.outdoor===true, big = a.area>=2, ent = a.entrances!==null ? entranceOpts[a.entrances].v : 1;
      const R = [];
      const t = a.place;
      const vNum = a.floors!==null ? floorOpts[a.floors].v : 1;
      if(t==='shop'){
        R.push({x:4,y:6,w:92,h:50,label:'hall',floor:'g'},{x:4,y:60,w:44,h:34,label:'storage',floor:'g'});
        if(out) R.push({x:52,y:60,w:44,h:34,label:'parking',floor:'g'});
      } else if(t==='office'){
        R.push({x:4,y:6,w:40,h:28,label:'reception',floor:'g'},{x:48,y:6,w:48,h:28,label:'office',floor:'g'},{x:48,y:38,w:48,h:26,label:'meeting',floor:'g'},{x:4,y:38,w:40,h:26,label:'corridor',floor:'g'});
        if(out) R.push({x:4,y:70,w:92,h:26,label:'parking',floor:'g'});
      } else if(t==='warehouse'){
        R.push({x:4,y:6,w:92,h:56,label:'storage',floor:'g'},{x:4,y:66,w:28,h:28,label:'office',floor:'g'});
        if(out) R.push({x:36,y:66,w:60,h:28,label:'courtyard',floor:'g'});
      } else if(t==='apartment'){
        R.push({x:4,y:6,w:54,h:42,label:'hall',floor:'g'},{x:62,y:6,w:34,h:26,label:'bedroom',floor:'g'},{x:62,y:36,w:34,h:24,label:'kitchen',floor:'g'},{x:4,y:52,w:28,h:22,label:'bathroom',floor:'g'});
        if(big) R.push({x:36,y:52,w:22,h:22,label:'bedroom',floor:'g'});
        if(out) R.push({x:62,y:64,w:34,h:16,label:'balcony',floor:'g'});
      } else {
        const stair = vNum>=2; // سلم حقيقي بيتكرر في نفس المكان على كل الأدوار
        if(out){
          if(stair){
            R.push({x:4,y:4,w:48,h:32,label:'hall',floor:'g'},{x:56,y:4,w:10,h:26,label:'stairs',floor:'g'},{x:70,y:4,w:26,h:26,label:'bedroom',floor:'g'},{x:70,y:34,w:26,h:22,label:'kitchen',floor:'g'},{x:4,y:40,w:22,h:16,label:'bathroom',floor:'g'});
            if(big) R.push({x:30,y:40,w:22,h:16,label:'bedroom',floor:'g'});
          } else {
            R.push({x:4,y:4,w:54,h:32,label:'hall',floor:'g'},{x:62,y:4,w:34,h:24,label:'bedroom',floor:'g'},{x:62,y:32,w:34,h:24,label:'kitchen',floor:'g'},{x:4,y:40,w:24,h:16,label:'bathroom',floor:'g'});
            if(big) R.push({x:32,y:40,w:26,h:16,label:'bedroom',floor:'g'});
          }
          if(ent>=2 || t==='villa'){
            R.push({x:4,y:62,w:70,h:34,label: t==='compound' ? 'garden' : 'yard',floor:'g'});
            R.push({x:78,y:62,w:18,h:34,label:'garage',floor:'g'});
          } else {
            R.push({x:4,y:62,w:92,h:34,label: t==='compound' ? 'garden' : 'yard',floor:'g'});
          }
        } else {
          if(stair){
            R.push({x:4,y:6,w:48,h:42,label:'hall',floor:'g'},{x:56,y:6,w:10,h:26,label:'stairs',floor:'g'},{x:70,y:6,w:26,h:26,label:'bedroom',floor:'g'},{x:70,y:36,w:26,h:24,label:'kitchen',floor:'g'},{x:4,y:52,w:26,h:20,label:'bathroom',floor:'g'});
            if(big) R.push({x:34,y:52,w:18,h:20,label:'bedroom',floor:'g'});
          } else {
            R.push({x:4,y:6,w:54,h:42,label:'hall',floor:'g'},{x:62,y:6,w:34,h:26,label:'bedroom',floor:'g'},{x:62,y:36,w:34,h:24,label:'kitchen',floor:'g'},{x:4,y:52,w:28,h:22,label:'bathroom',floor:'g'});
            if(big) R.push({x:36,y:52,w:22,h:22,label:'bedroom',floor:'g'});
          }
        }
        if(stair){
          R.push({x:56,y:4,w:10,h:26,label:'stairs',floor:'f1'},{x:4,y:4,w:48,h:40,label:'bedroom',floor:'f1'},{x:70,y:4,w:26,h:40,label:'bedroom',floor:'f1'},{x:4,y:50,w:26,h:20,label:'bathroom',floor:'f1'},{x:34,y:50,w:62,h:20,label:'corridor',floor:'f1'});
        }
      }
      sk.rooms.push(...R);
      const gRooms = sk.rooms.filter(r=>r.floor==='g');
      const ins = gRooms.filter(r=>zoneType(r.label)==='in');
      const outs = gRooms.filter(r=>zoneType(r.label)==='out');
      for(let i=0;i<needIn && sk.pins.length<30;i++){
        const r = ins[i % Math.max(1, ins.length)] || {x:40,y:40,w:20,h:20};
        const wave = Math.floor(i / Math.max(1, ins.length));
        sk.pins.push({t:'cam', x:clampV(r.x+6+wave*10, r.x+4, r.x+r.w-4), y:clampV(r.y+6, r.y+4, r.y+r.h-4), floor:'g'});
      }
      for(let i=0;i<needOut && sk.pins.length<30;i++){
        if(outs.length){
          const r = outs[i % outs.length];
          const step = (r.w-12) / Math.max(1, needOut);
          sk.pins.push({t:'cam', x:clampV(r.x+6+i*step, r.x+4, r.x+r.w-4), y:clampV(r.y+6, r.y+4, r.y+r.h-4), floor:'g'});
        } else {
          sk.pins.push({t:'cam', x:clampV(8 + i*(84/Math.max(1,needOut)), 2, 98), y:96, floor:'g'});
        }
      }
      // أكسس بوينت لكل دور — التغطية الصح للواي فاي، والدور اللي ملوش غرف مولّدة ياخد نصيبه أرضي
      const apFloors = ['g'].concat(vNum>=2 && (t==='villa'||t==='compound') ? ['f1'] : []);
      for(let i=0;i<needAp && sk.pins.length<30;i++){
        const fl = apFloors[Math.min(i, apFloors.length-1)];
        const flRooms = sk.rooms.filter(r=>r.floor===fl && zoneType(r.label)==='in');
        const r = flRooms[i % Math.max(1, flRooms.length)] || ins[0] || {x:40,y:40,w:20,h:20};
        const wave = Math.floor(i / Math.max(1, flRooms.length));
        sk.pins.push({t:'ap', x:clampV(r.x+r.w-8-wave*10, r.x+4, r.x+r.w-4), y:clampV(r.y+r.h-8, r.y+4, r.y+r.h-4), floor:fl});
      }
      // اقتراحات التمديدات — دي الإضافة الوحيدة اللي بتحرك السعر عند التوليد، وبتظهر كبنود واضحة قابلة للمسح
      const NETLBL = ['hall','bedroom','office','reception','meeting','storage'];
      sk.rooms.forEach(r=>{
        if(sk.pins.length>=29) return;
        if(zoneType(r.label)==='in' && NETLBL.includes(r.label) && r.w*r.h>=450){
          sk.pins.push({t:'net', x:clampV(r.x+8, r.x+4, r.x+r.w-4), y:clampV(r.y+r.h-6, r.y+4, r.y+r.h-4), floor:r.floor||'g'});
        }
      });
      const tvRoom = sk.rooms.filter(r=>['hall','reception'].includes(r.label)).sort((ra,rb)=>rb.w*rb.h - ra.w*ra.h)[0];
      if(tvRoom && sk.pins.length<30) sk.pins.push({t:'tv', x:tvRoom.x+tvRoom.w/2, y:clampV(tvRoom.y+6, tvRoom.y+4, tvRoom.y+tvRoom.h-4), floor:tvRoom.floor||'g'});
      const RACKLBL = ['corridor','entrance','storage'];
      const rackRoom = sk.rooms.find(r=>(r.floor||'g')==='g' && RACKLBL.includes(r.label))
                    || sk.rooms.find(r=>(r.floor||'g')==='g' && zoneType(r.label)==='in' && r.label!=='stairs')
                    || sk.rooms.find(r=>RACKLBL.includes(r.label));
      if(rackRoom && sk.pins.length<30) sk.pins.push({t:'rack', x:clampV(rackRoom.x+rackRoom.w-8, rackRoom.x+4, rackRoom.x+rackRoom.w-4), y:clampV(rackRoom.y+8, rackRoom.y+4, rackRoom.y+rackRoom.h-4), floor:rackRoom.floor||'g'});
      sk.generated = true; sk.dismiss = false; sk.sel = null;
      // في الموقع: سجّل event باسم sketch_generated هنا
    }

    function stageDown(e){
      if(sk.mode!=='room' || e.target!==e.currentTarget) return;
      const rect = e.currentTarget.getBoundingClientRect();
      const p0 = pct(rect, e);
      sk.draft = { x:snapV(p0.x), y:snapV(p0.y), w:0, h:0 };
      const move = ev=>{
        const p = pct(rect, ev);
        sk.draft.x = snapV(Math.min(p0.x, p.x));
        sk.draft.y = snapV(Math.min(p0.y, p.y));
        sk.draft.w = snapV(Math.abs(p.x - p0.x));
        sk.draft.h = snapV(Math.abs(p.y - p0.y));
      };
      const up = ()=>{
        window.removeEventListener('pointermove', move);
        window.removeEventListener('pointerup', up);
        if(sk.draft && sk.draft.w>=6 && sk.draft.h>=6 && sk.rooms.length<20){
          snapPush();
          sk.rooms.push({...sk.draft, label:'room', floor: sk.floor});
          sk.sel = sk.rooms.length-1;
        }
        sk.draft = null;
      };
      window.addEventListener('pointermove', move);
      window.addEventListener('pointerup', up);
    }
    function roomDown(i, e){
      if(PIN_MODES.includes(sk.mode)) return; // في وضع الأدوات: الضغطة بتحط نقطة مش بتسحب المنطقة
      sk.sel = i;
      const r = sk.rooms[i];
      const stage = e.currentTarget.closest('.sketch-stage');
      const rect = stage.getBoundingClientRect();
      const p0 = pct(rect, e);
      const ox = r.x, oy = r.y;
      snapPush();
      const move = ev=>{
        const p = pct(rect, ev);
        r.x = snapV(Math.min(100 - r.w, Math.max(0, ox + (p.x - p0.x))));
        r.y = snapV(Math.min(100 - r.h, Math.max(0, oy + (p.y - p0.y))));
      };
      const up = ()=>{ window.removeEventListener('pointermove', move); window.removeEventListener('pointerup', up); };
      window.addEventListener('pointermove', move);
      window.addEventListener('pointerup', up);
    }
    function resizeDown(i, e){
      sk.sel = i;
      const r = sk.rooms[i];
      const stage = e.currentTarget.closest('.sketch-stage');
      const rect = stage.getBoundingClientRect();
      snapPush();
      const move = ev=>{
        const p = pct(rect, ev);
        r.w = snapV(Math.min(100 - r.x, Math.max(6, p.x - r.x)));
        r.h = snapV(Math.min(100 - r.y, Math.max(6, p.y - r.y)));
      };
      const up = ()=>{ window.removeEventListener('pointermove', move); window.removeEventListener('pointerup', up); };
      window.addEventListener('pointermove', move);
      window.addEventListener('pointerup', up);
    }
    function placePinXY(x, y){
      if(sk.mode!=='rack' && sk.pins.length>=30) return;
      snapPush();
      if(sk.mode==='rack'){
        // كبينة رئيسية واحدة بس للنظام — الضغطة الجديدة بتنقلها مكانها
        const ex = sk.pins.find(pp=>pp.t==='rack');
        if(ex){ ex.x=x; ex.y=y; ex.floor=sk.floor; return; }
      }
      sk.pins.push({ t:sk.mode, x, y, floor: sk.floor });
    }
    function sketchPlacePin(e){
      if(!PIN_MODES.includes(sk.mode)) return;
      const p = pct(e.currentTarget.getBoundingClientRect(), e);
      placePinXY(p.x, p.y);
    }
    function roomClick(i, e){
      if(PIN_MODES.includes(sk.mode)){
        const stage = e.currentTarget.closest('.sketch-stage');
        if(!stage) return;
        const p = pct(stage.getBoundingClientRect(), e);
        placePinXY(p.x, p.y);
        return;
      }
      sk.sel = i;
    }
    function delRoom(i){ snapPush(); sk.rooms.splice(i,1); sk.sel=null; }
    function delSkPin(i){ snapPush(); sk.pins.splice(i,1); }
    function skPinDrag(p, e){ snapPush(); startDrag(p, e); }
    function labelRoom(l){ if(sk.sel===null || !sk.rooms[sk.sel]) return; snapPush(); sk.rooms[sk.sel].label = l; }

    return {
        planTab, sk, roomLabels, zoneType, floorsAvail, floorCount, sketchCams, sketchAps, sketchWiring,
        skUndo, skClear, generateStarter, stageDown, roomDown, resizeDown, sketchPlacePin, roomClick,
        delRoom, delSkPin, skPinDrag, labelRoom,
    };
}

import { ref, reactive, computed, onMounted, watch } from 'vue';
import axios from 'axios';
import { useSketch, startDrag } from './useSketch';
import { __ } from '../utils/i18n';

// اشتراطات وزارة الداخلية للمنشآت التجارية — راجع النص الرسمي حسب نوع النشاط قبل الإطلاق، والقيم دي config
const COMMERCIAL_TYPES = ['shop','office','warehouse'];
const MOI_RETENTION_DAYS = 180;
const MOI_NOTICE = __('wiz_moi_notice');

const TIERS = [
  { tier:'basic', title:__('wiz_tier_basic_title'),  outcome:__('wiz_tier_basic_outcome') },
  { tier:'pro',   title:__('wiz_tier_pro_title'),  outcome:__('wiz_tier_pro_outcome'), badge:__('wiz_tier_pro_badge') },
  { tier:'prem',  title:__('wiz_tier_prem_title'),  outcome:__('wiz_tier_prem_outcome') },
];

const ICONS = {
  apartment: '<svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"><rect x="5" y="3" width="14" height="18" rx="1.5"/><path d="M9 7h1.5M13.5 7H15M9 11h1.5M13.5 11H15M9 15h1.5M13.5 15H15M10.5 21v-3h3v3"/></svg>',
  villa: '<svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"><path d="M3 11l9-7 9 7"/><path d="M5 10v10h14V10"/><path d="M10 20v-5h4v5"/></svg>',
  shop: '<svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"><path d="M4 8l1.5-4h13L20 8"/><path d="M4 8h16v2a2.5 2.5 0 0 1-5 0 2.5 2.5 0 0 1-6 0 2.5 2.5 0 0 1-5 0z"/><path d="M5 12.5V20h14v-7.5M9 20v-4h6v4"/></svg>',
  office: '<svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"><rect x="4" y="7" width="10" height="14" rx="1"/><path d="M14 11h5a1 1 0 0 1 1 1v9h-6"/><path d="M7.5 11h3M7.5 15h3M17 15h.5"/></svg>',
  warehouse: '<svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"><path d="M3 9l9-5 9 5v11H3z"/><path d="M7 20v-7h10v7"/><path d="M7 16h10"/></svg>',
  compound: '<svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"><path d="M2 21h20"/><path d="M4 21V9l5-3v15"/><path d="M9 21V6l6 3v12"/><path d="M15 21V9l5 3v9"/></svg>',
  door: '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"><path d="M6 21V4a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v17"/><path d="M3 21h18"/><circle cx="14.5" cy="12" r=".8"/></svg>',
  cam: '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"><rect x="2" y="7" width="13" height="10" rx="2"/><path d="M15 10.5l6-3v9l-6-3"/></svg>',
  fence: '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"><path d="M12 3l8 4v5c0 5-3.5 8-8 9-4.5-1-8-4-8-9V7z"/><path d="M8.5 12l2.5 2.5 4.5-5"/></svg>',
  wifi: '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"><path d="M5 12.5a10 10 0 0 1 14 0"/><path d="M8.5 16a5 5 0 0 1 7 0"/><circle cx="12" cy="19" r="1"/></svg>',
  intercom: '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"><rect x="7" y="3" width="10" height="18" rx="2"/><circle cx="12" cy="9" r="2.2"/><path d="M10 15h4"/></svg>',
  bell: '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"><path d="M18 9a6 6 0 1 0-12 0c0 6-2 7-2 7h16s-2-1-2-7"/><path d="M10.3 20a2 2 0 0 0 3.4 0"/></svg>',
  pin: '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"><path d="M12 21s-7-6.1-7-11a7 7 0 0 1 14 0c0 4.9-7 11-7 11z"/><circle cx="12" cy="10" r="2.5"/></svg>',
  room: '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"><rect x="4" y="5" width="16" height="14" rx="1.5"/><path d="M4 12h5M20 12h-3"/></svg>',
  net: '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"><rect x="6" y="4" width="12" height="12" rx="1.5"/><path d="M9 16v4M15 16v4M9.5 8v3M12 8v3M14.5 8v3"/></svg>',
  tv: '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="5" width="18" height="12" rx="1.5"/><path d="M8 21h8M12 17v4"/></svg>',
  rack: '<svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.7" stroke-linecap="round" stroke-linejoin="round"><rect x="6" y="3" width="12" height="18" rx="1.5"/><path d="M6 9h12M6 15h12M9 6h.01M9 12h.01M9 18h.01"/></svg>'
};

/**
 * All state and logic of the "اعرف نظامك" wizard. SystemWizard.vue creates it once and provides it;
 * the step components inject what they render. Catalog: GET /ajax/vue/wizard-catalog (admin-mapped
 * products). Pricing mirrors RecommendationService, which recomputes every estimate on submit.
 */
export function useWizard() {
    const catalog = ref(null);
    const catalogError = ref(false);

    const loadingCatalog = ref(true);

    const step = ref(1);
        const submitted = ref(false);
        const phoneTouched = ref(false);

        const stepNames = [__('wiz_step_place'),__('wiz_step_place_details'),__('wiz_step_needs'),__('wiz_step_budget'),__('wiz_step_packages')];

        const placeTypes = [
          {id:'apartment', label:__('wiz_place_apartment'), icon:'apartment'},
          {id:'villa',     label:__('wiz_place_villa'),     icon:'villa'},
          {id:'shop',      label:__('wiz_place_shop'),      icon:'shop'},
          {id:'office',    label:__('wiz_place_office'),    icon:'office'},
          {id:'warehouse', label:__('wiz_place_warehouse'), icon:'warehouse'},
          {id:'compound',  label:__('wiz_place_compound'),  icon:'compound'},
        ];

        // NOTE: option arrays are addressed by INDEX server-side (RecommendationService),
        // so their order/length must never change — only the display label is translated.
        const areaOpts      = [{label:__('wiz_area_0'),mid:80},{label:__('wiz_area_1'),mid:175},{label:__('wiz_area_2'),mid:375},{label:__('wiz_area_3'),mid:650}];
        const floorOpts     = [{label:__('wiz_floor_1'),v:1},{label:__('wiz_floor_2'),v:2},{label:__('wiz_floor_3'),v:3}];
        const entranceOpts  = [{label:'1',v:1},{label:'2',v:2},{label:'3',v:3},{label:'4+',v:4}];
        const conditionOpts = [{label:__('wiz_cond_0'),factor:0.9},{label:__('wiz_cond_1'),factor:1.0},{label:__('wiz_cond_2'),factor:1.35}];
        const deviceOpts    = [{label:__('wiz_dev_0')},{label:__('wiz_dev_1')},{label:__('wiz_dev_2')}];
        const recordOpts    = [{label:__('wiz_rec_0'),days:7},{label:__('wiz_rec_1'),days:14},{label:__('wiz_rec_2'),days:30},{label:__('wiz_rec_3'),days:90},{label:__('wiz_rec_4'),days:180}];
        const budgetOpts    = [{label:__('wiz_budget_0')},{label:__('wiz_budget_1')},{label:__('wiz_budget_2')},{label:__('wiz_budget_3')}];
        const brandOpts     = [{label:'Hikvision'},{label:'Dahua'},{label:'Ubiquiti'},{label:'TP-Link'},{label:__('wiz_brand_advise')}];

        const goals = [
          {id:'entry',     label:__('wiz_goal_entry_label'),     sub:__('wiz_goal_entry_sub'),     icon:'door'},
          {id:'indoor',    label:__('wiz_goal_indoor_label'),    sub:__('wiz_goal_indoor_sub'),    icon:'cam'},
          {id:'perimeter', label:__('wiz_goal_perimeter_label'), sub:__('wiz_goal_perimeter_sub'), icon:'fence'},
          {id:'wifi',      label:__('wiz_goal_wifi_label'),      sub:__('wiz_goal_wifi_sub'),      icon:'wifi'},
          {id:'intercom',  label:__('wiz_goal_intercom_label'),  sub:__('wiz_goal_intercom_sub'),  icon:'intercom'},
          {id:'alarm',     label:__('wiz_goal_alarm_label'),     sub:__('wiz_goal_alarm_sub'),     icon:'bell'},
        ];

        const a = reactive({
          place:null, area:null, floors:null, entrances:null, outdoor:null, condition:null, conduits:null,
          goals:[], devices:null, recordDays:null, internet:null, zoom:null,
          budget:null, brand:null, package:null,
        });
        const lead = reactive({name:'', phone:''});


    // ---- المخطط الاختياري: صورة + دبابيس {t, x%, y%} ----
    const plan = reactive({ img:null, pins:[], tool:'cam', err:'' });
    const pinTypes = [
      {id:'cam',  label:__('wiz_pin_cam'),  icon:'cam'},
      {id:'ap',   label:__('wiz_pin_ap'),   icon:'wifi'},
      {id:'net',  label:__('wiz_pin_net'),  icon:'net'},
      {id:'tv',   label:__('wiz_pin_tv'),   icon:'tv'},
      {id:'rack', label:__('wiz_pin_rack'), icon:'rack'},
      {id:'note', label:__('wiz_pin_note'), icon:'pin'},
    ];
    const pinIcon  = t => (pinTypes.find(x=>x.id===t)||{}).icon || 'pin';
    const pinLabel = t => (pinTypes.find(x=>x.id===t)||{}).label || '';
    function onPlanFile(e){
      const f = e.target.files && e.target.files[0];
      if(!f) return;
      if(f.size > 8*1024*1024){ plan.err = 'حجم الصورة أكبر من 8 ميجابايت، صغّرها أولًا.'; e.target.value=''; return; }
      plan.err = '';
      const r = new FileReader();
      r.onload = ()=>{ plan.img = r.result; plan.pins = []; };
      r.readAsDataURL(f);
      // في موقعك: الملف نفسه بيترفع multipart مع الليد لـ storage — الـ dataURL هنا للعرض في البروتوتايب بس
      e.target.value = '';
    }
    function clearPlan(){ plan.img = null; plan.pins = []; }
    function placePin(e){
      if(!plan.img || plan.pins.length >= 30) return;
      const rect = e.currentTarget.getBoundingClientRect();
      plan.pins.push({
        t: plan.tool,
        x: ((e.clientX - rect.left)/rect.width)*100,
        y: ((e.clientY - rect.top)/rect.height)*100,
      });
    }
    function removePin(i){ plan.pins.splice(i,1); }

    // ---- floor sketch (useSketch.js); its starter drawing reproduces the question-based counts ----
    const sketch = useSketch(a, { floorOpts, entranceOpts, pinTypes }, () => ({
      indoor: camCounts.value.indoor, outdoor: camCounts.value.outdoor, ap: apCount.value,
    }));
    const { sk, sketchCams, sketchAps, sketchWiring } = sketch;

    // سعر لايف جنب الرسم — عشان الزبون يشوف أثر كل كاميرا بيحطها من غير ما يطلع فوق
    const livePkg = computed(()=>{
      const t = (a.package && a.package!=='advise') ? a.package : 'pro';
      return packages.value.find(p=>p.tier===t) || null;
    });

        const wantsWifi = computed(()=> a.goals.includes('wifi'));
        const wantsCams = computed(()=> a.goals.some(g=>['entry','indoor','perimeter'].includes(g)));
        const zoomVisible = computed(()=> wantsCams.value && (a.area>=2 || ['warehouse','compound'].includes(a.place) || a.outdoor===true));

        function toggleGoal(id){
          const i = a.goals.indexOf(id);
          i === -1 ? a.goals.push(id) : a.goals.splice(i,1);
        }

        // ---- الكميات (heuristic — ظبّطه على خبرتك في التركيبات) ----
        const camCounts = computed(()=>{
          // لو رسم كاميرات على المخطط، الرسم هو المرجع — أدق من تخمين الأسئلة
          if(sketchCams.value.in + sketchCams.value.out > 0)
            return {indoor: sketchCams.value.in, outdoor: sketchCams.value.out};
          if(!wantsCams.value || a.area===null) return {indoor:0, outdoor:0};
          let indoor = 0, outdoor = 0;
          if(a.goals.includes('entry') && a.entrances!==null) outdoor += entranceOpts[a.entrances].v;
          if(a.goals.includes('indoor')) indoor += [2,3,5,8][a.area];
          if(a.goals.includes('perimeter') && a.outdoor) outdoor += [2,3,4,6][a.area];
          return {indoor, outdoor};
        });
        const camTotal = computed(()=> camCounts.value.indoor + camCounts.value.outdoor + (a.zoom ? 1 : 0));
        const apCount = computed(()=>{
          if(sketchAps.value > 0) return sketchAps.value;
          if(!wantsWifi.value || a.area===null || a.floors===null) return 0;
          const floors = floorOpts[a.floors].v;
          let n = Math.max(floors, Math.ceil(areaOpts[a.area].mid / 140));
          if(a.devices===2) n += 1;
          return n;
        });

        // ---- محرك الباقات: نفس المنطق هيتنقل لـ RecommendationService في Laravel ----
        function pickSize(list, need){
          for(const s of list){ if(s >= need) return s; }
          return list[list.length-1];
        }

        function buildPackage(meta){
          if(!catalog.value) return {...meta, items:[], total:0, foot:''};
          const t = meta.tier;
          const items = [];
          let total = 0;
          const add = (name, qty, unitPrice)=>{ items.push({name, qty}); total += qty*unitPrice; };

          const {indoor, outdoor} = camCounts.value;
          if(indoor>0)  add(catalog.value.camera[t].in.name, indoor, catalog.value.camera[t].in.price);
          if(outdoor>0) add(catalog.value.camera[t].out.name, outdoor, catalog.value.camera[t].out.price);
          if(a.zoom)    add(catalog.value.ptz.name, 1, catalog.value.ptz.price);

          const cams = camTotal.value;
          if(cams>0){
            const ch = pickSize([8,16,32], cams);
            add(`جهاز تسجيل NVR ${ch} قناة`, 1, catalog.value.nvr[ch][t]);
            // حجم التخزين = عدد الكاميرات × أيام الحفظ × جيجا/يوم حسب جودة الباقة
            const days = a.recordDays!==null ? recordOpts[a.recordDays].days : 14;
            const tbNeeded = (cams * days * catalog.value.camera[t].gbDay) / 1000;
            const maxDrive = catalog.value.hdd.sizes[catalog.value.hdd.sizes.length-1];
            const recLabel = a.recordDays!==null ? recordOpts[a.recordDays].label : 'أسبوعين';
            if(tbNeeded <= maxDrive){
              const tb = pickSize(catalog.value.hdd.sizes, tbNeeded);
              add(`قرص تخزين للمراقبة ${tb} تيرابايت (يكفي ${recLabel})`, 1, catalog.value.hdd.price[tb]);
            } else {
              // مدد التخزين الطويلة (اشتراط الوزارة مثلاً) محتاجة أكتر من هارد
              const n = Math.ceil(tbNeeded / maxDrive);
              add(`قرص تخزين للمراقبة ${maxDrive} تيرابايت (يكفي ${recLabel})`, n, catalog.value.hdd.price[maxDrive]);
            }
          }

          // البنية التحتية للشبكة بتتضاف تلقائي — الكاميرات IP محتاجاها حتى لو مطلبش "واي فاي"
          const aps = apCount.value;
          if(cams + aps > 0){
            const ports = pickSize(catalog.value.poeSwitch.ports, cams + aps + 2);
            add(`سويتش PoE ${ports} منفذ`, 1, catalog.value.poeSwitch.price[ports]);
          }
          if(aps>0){
            add(catalog.value.ap[t].name, aps, catalog.value.ap[t].price);
            if(aps>3) add(catalog.value.ap.controller.name, 1, catalog.value.ap.controller.price);
          }

          if(a.goals.includes('intercom')) add(catalog.value.intercom[t].name, 1, catalog.value.intercom[t].price);
          if(a.goals.includes('alarm'))    add(catalog.value.alarm[t].name, 1, catalog.value.alarm[t].price);
          if(a.internet==='no' && cams>0)  add(catalog.value.router4g.name, 1, catalog.value.router4g.price);

          // تمديدات من الرسم: نقاط شبكة سلكية، تلفزيون، والكبينة الرئيسية
          const nets = sk.pins.filter(pp=>pp.t==='net').length;
          const tvs  = sk.pins.filter(pp=>pp.t==='tv').length;
          const hasRack = sk.pins.some(pp=>pp.t==='rack');
          if(nets)   add(catalog.value.netPoint[t].name, nets, catalog.value.netPoint[t].price);
          if(tvs)    add(catalog.value.tvPoint[t].name, tvs, catalog.value.tvPoint[t].price);
          if(hasRack) add(catalog.value.rack[t].name, 1, catalog.value.rack[t].price);

          // التركيب: نقاط × سعر النقطة × معامل حالة المكان
          const points = cams + aps + nets + tvs + (hasRack?1:0) + (a.goals.includes('intercom')?1:0) + (a.goals.includes('alarm')?3:0);
          if(points>0){
            // التمديدات الجاهزة في المكان المتشطب بتلغي تكلفة الترنكات — و"مش متأكد" بيتسعّر بالأعلى والمعاينة تنزّله
            let factor = a.condition!==null ? conditionOpts[a.condition].factor : 1;
            const readyConduits = a.condition===2 && a.conduits==='yes';
            if(readyConduits) factor = 1.0;
            const install = Math.round(points * catalog.value.installPerPoint * factor);
            items.push({name: readyConduits ? 'تركيب عبر التمديدات الجاهزة (تقديري)' : (a.condition===2 ? 'تركيب وتمديدات عبر مجارٍ خارجية (تقديري)' : 'تركيب وتمديدات (تقديري)'), qty:1});
            total += install;
          }

          return {
            ...meta,
            items,
            total: Math.round(total),
            foot: cams>0 ? 'تشمل المتابعة من الهاتف والإعداد الكامل.' : 'تشمل الإعداد والبرمجة الكاملة.',
          };
        }

        const packages = computed(()=> TIERS.map(buildPackage));

        const trayChips = computed(()=>{
          const c = [];
          const pt = placeTypes.find(p=>p.id===a.place);
          if(pt) c.push(pt.label);
          if(a.area!==null) c.push(areaOpts[a.area].label);
          if(a.condition!==null) c.push(conditionOpts[a.condition].label);
          if(camTotal.value>0) c.push(`${camTotal.value} كاميرا`);
          if(apCount.value>0) c.push(`${apCount.value} أكسس بوينت`);
          if(a.zoom) c.push('كاميرا زوم');
          if(a.goals.includes('intercom')) c.push('إنتركم');
          if(a.goals.includes('alarm')) c.push('إنذار');
          return c;
        });

        const summary = computed(()=>{
          const s = [];
          const pt = placeTypes.find(p=>p.id===a.place);
          if(pt) s.push({k:'المكان', v:pt.label});
          if(a.area!==null) s.push({k:'المساحة', v:areaOpts[a.area].label});
          if(a.condition!==null) s.push({k:'حالة المكان', v:conditionOpts[a.condition].label});
          if(a.condition===2 && a.conduits!==null) s.push({k:'تمديدات جاهزة', v: a.conduits==='yes' ? 'موجودة' : a.conduits==='no' ? 'غير موجودة' : 'غير متأكد، تُؤكَّد في المعاينة'});
          if(a.floors!==null) s.push({k:'الأدوار', v:floorOpts[a.floors].label});
          if(a.entrances!==null) s.push({k:'المداخل', v:entranceOpts[a.entrances].label});
          s.push({k:'الاحتياج', v:a.goals.map(g=>goals.find(x=>x.id===g).label).join('، ')});
          if(wantsCams.value) s.push({k:'إنترنت ثابت', v:a.internet==='yes'?'موجود':'غير موجود'});
          if(sk.rooms.length || sk.pins.length){
            const flN = new Set(sk.rooms.map(r=>r.floor||'g').concat(sk.pins.map(p=>p.floor||'g'))).size;
            s.push({k:'مخطط', v:`مرسوم: ${sk.rooms.length} منطقة و${sk.pins.length} علامة على ${flN} دور`});
            if(sketchCams.value.in + sketchCams.value.out > 0) s.push({k:'كاميرات من الرسم', v:`${sketchCams.value.in} داخلي · ${sketchCams.value.out} خارجي`});
            const w = sketchWiring.value;
            if(w.nets + w.tvs > 0 || w.rack) s.push({k:'تمديدات من الرسم', v:`${w.nets} نت · ${w.tvs} تلفزيون${w.rack?' · كبينة رئيسية':''}`});
          }
          else if(plan.img) s.push({k:'مخطط', v: plan.pins.length ? `صورة مرفوعة + ${plan.pins.length} علامة` : 'صورة مرفوعة'});
          if(a.budget!==null) s.push({k:'الميزانية', v:budgetOpts[a.budget].label});
          if(a.brand!==null) s.push({k:'العلامة التجارية', v:brandOpts[a.brand].label});
          return s;
        });

        // ---- navigation & validation ----
        const canNext = computed(()=>{
          if(step.value===1) return a.place!==null;
          if(step.value===2) return a.area!==null && a.floors!==null && a.entrances!==null && a.outdoor!==null && a.condition!==null && (a.condition!==2 || a.conduits!==null);
          if(step.value===3){
            if(a.goals.length===0) return false;
            if(wantsWifi.value && a.devices===null) return false;
            if(wantsCams.value && (a.recordDays===null || a.internet===null)) return false;
            if(zoomVisible.value && a.zoom===null) return false;
            return true;
          }
          if(step.value===4) return true;
          if(step.value===5) return a.package!==null && lead.name.length>=2 && phoneValid.value;
          return false;
        });

        // Same rule as the server: Kuwaiti 8-digit number, optional +965 / 00965.
        const phoneValid = computed(()=> /^(?:\+?965|00965)?[124569]\d{7}$/.test(lead.phone.replace(/[\s-]/g,'')));

        const nextLabel = computed(()=>{
          if(step.value===4) return 'اعرض الباقات';
          if(step.value===5) return 'أرسل الطلب';
          return 'متابعة';
        });

        const isCommercial = computed(()=> COMMERCIAL_TYPES.includes(a.place));
        const moiNotice = MOI_NOTICE;
        const moiDaysIdx = recordOpts.findIndex(o=>o.days===MOI_RETENTION_DAYS);
        function next(){
          if(step.value===5){ submitLead(); return; }
          step.value++;
          // المنشآت التجارية بتبدأ على اشتراط الوزارة كافتراضي — والاختيار لسه بإيده
          if(step.value===3 && isCommercial.value && a.recordDays===null && moiDaysIdx>-1) a.recordDays = moiDaysIdx;
          window.scrollTo({top:0});
        }
        function back(){ if(step.value>1) step.value--; window.scrollTo({top:0}); }
        function skipBudget(){ a.budget=null; a.brand=null; step.value=5; window.scrollTo({top:0}); }

        // Raw answer indices: the server maps them to the same option tables and recomputes
        // the package (RecommendationService). Display labels are not sent.
        function payload(){
          const hasSketch = sk.rooms.length || sk.pins.length;
          return {
            answers: {
              place: a.place, area: a.area, floors: a.floors, entrances: a.entrances,
              outdoor: a.outdoor, condition: a.condition,
              conduits: a.condition===2 ? a.conduits : null,
              goals: a.goals, devices: a.devices, recordDays: a.recordDays,
              internet: a.internet, zoom: a.zoom, budget: a.budget, brand: a.brand,
            },
            sketch: hasSketch ? {
              rooms: sk.rooms.map(r=>({x:+r.x, y:+r.y, w:+r.w, h:+r.h, label:r.label || null, floor:r.floor||'g'})),
              pins:  sk.pins.map(p=>({t:p.t, x:+(+p.x).toFixed(1), y:+(+p.y).toFixed(1), floor:p.floor||'g'})),
              generated: !!sk.generated,
            } : null,
            plan_attached: !!plan.img,
            plan_pins: plan.pins.map(p=>({t:p.t, x:+(+p.x).toFixed(1), y:+(+p.y).toFixed(1)})),
            package: a.package,
            name: lead.name,
            phone: lead.phone,
          };
        }

        const waNumber = computed(()=> catalog.value?.whatsappNumber || '');
        const waLink = computed(()=>{
          const chosen = a.package && a.package!=='advise' ? packages.value.find(p=>p.tier===a.package) : null;
          const lines = [
            'طلب نظام جديد 👇',
            summary.value.map(s=>`${s.k}: ${s.v}`).join(' | '),
            chosen ? `الباقة المختارة: ${chosen.title} (~${chosen.total} د.ك)` : 'الباقة: أحتاج إلى ترشيح في المعاينة',
            (sk.rooms.length || sk.pins.length) ? `مرفق رسم للمكان (${sk.rooms.length} منطقة، ${sk.pins.length} علامة — كاميرات: ${sketchCams.value.in} داخلي/${sketchCams.value.out} خارجي)` : (plan.img ? 'مرفق صورة مخطط، تُرسل من الموقع' : ''),
            lead.name ? `الاسم: ${lead.name}` : '',
            lead.phone ? `الهاتف: ${lead.phone}` : '',
          ].filter(Boolean);
          return waNumber.value ? `https://wa.me/${waNumber.value}?text=${encodeURIComponent(lines.join('\n'))}` : '';
        });

        const icon = (name)=> ICONS[name] || '';

    // ---- analytics: wizard funnel events (sw_wizard_events) ----
    const wizardSession = (() => {
      try {
        let id = sessionStorage.getItem('sw_session');
        if (!id) { id = Date.now().toString(36) + Math.random().toString(36).slice(2, 10); sessionStorage.setItem('sw_session', id); }
        return id;
      } catch (e) { return Date.now().toString(36); }
    })();
    function track(action, payloadData = null) {
      axios.post('/ajax/vue/wizard-events', {
        session_id: wizardSession,
        step: String(step.value),
        action,
        payload: payloadData,
      }).catch(() => {});
    }
    watch(step, (value) => track('step_view', { step: value }));

    const loadCatalog = async () => {
      loadingCatalog.value = true;
      catalogError.value = false;
      try {
        const res = await axios.get('/ajax/vue/wizard-catalog');
        catalog.value = res.data?.data || null;
        if (!catalog.value) catalogError.value = true;
      } catch (e) {
        catalogError.value = true;
      } finally {
        loadingCatalog.value = false;
      }
    };

    onMounted(() => {
      loadCatalog();
      track('start');
    });

    const submitting = ref(false);
    const submitError = ref('');
    const honeypot = ref('');
    const serverEstimate = ref(null);

    const submitLead = async () => {
      phoneTouched.value = true;
      if (!canNext.value || submitting.value) return;
      submitting.value = true;
      submitError.value = '';
      try {
        const res = await axios.post('/ajax/vue/project-leads', { ...payload(), website: honeypot.value });
        if (res.data && res.data.error === false) {
          serverEstimate.value = res.data.data?.estimate ?? null;
          submitted.value = true;
          track('submit', { package: a.package });
          window.scrollTo({ top: 0 });
        } else {
          submitError.value = res.data?.message || 'تعذّر إرسال الطلب. حاول مرة أخرى.';
        }
      } catch (e) {
        const errors = e.response?.data?.errors;
        submitError.value = e.response?.data?.message
          || (errors ? Object.values(errors).flat()[0] : '')
          || 'تعذّر الاتصال بالخادم. تحقق من الإنترنت وحاول مرة أخرى.';
      } finally {
        submitting.value = false;
      }
    };

    return {
        catalog, catalogError, loadingCatalog, loadCatalog,
        step, submitted, stepNames, canNext, nextLabel, next, back, skipBudget,
        a, lead, placeTypes, areaOpts, floorOpts, entranceOpts, conditionOpts, deviceOpts, recordOpts, budgetOpts, brandOpts, goals,
        toggleGoal, wantsWifi, wantsCams, zoomVisible, isCommercial, moiNotice, icon,
        packages, livePkg, trayChips, summary,
        plan, pinTypes, pinIcon, pinLabel, onPlanFile, clearPlan, placePin, removePin, startDrag,
        ...sketch,
        phoneTouched, phoneValid, honeypot, submitting, submitError, serverEstimate, waLink,
    };
}

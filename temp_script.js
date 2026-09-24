
import { ref, reactive, computed, nextTick, onMounted } from 'vue';
import axios from 'axios';

// ================= CONFIG — عدّل قبل الربط بموقعك =================
const WHATSAPP_NUMBER = "965XXXXXXXX";        // رقم واتساب الشركة بكود الدولة بدون +
const API_ENDPOINT    = "/api/project-leads";  // Laravel endpoint للـ POST

// ================= CATALOG (بيانات تجريبية) =================
// !! كل الأسعار هنا وهمية للعرض بس — في موقعك ده بييجي من جدول
// `products` في Laravel عن طريق GET /api/wizard-catalog
// شكل الصف: {sku, name, category, tier, specs(json), price, active}
const CATALOG = {
  camera: {
    basic: { in:{name:'كاميرا داخلية 2MP', price:12}, out:{name:'كاميرا خارجية 2MP مقاومة للجو', price:16}, gbDay:12 },
    pro:   { in:{name:'كاميرا داخلية 4MP', price:19}, out:{name:'كاميرا خارجية 4MP رؤية ليلية', price:24}, gbDay:20 },
    prem:  { in:{name:'كاميرا 4K ColorVu داخلية', price:29}, out:{name:'كاميرا 4K ColorVu خارجية (ألوان بالليل)', price:38}, gbDay:35 },
  },
  ptz: { name:'كاميرا زوم متحركة PTZ ×25', price:95 },
  nvr: { // السعر حسب عدد القنوات × المستوى
    8:  {basic:45,  pro:60,  prem:85},
    16: {basic:70,  pro:95,  prem:130},
    32: {basic:120, pro:160, prem:210},
  },
  hdd: { sizes:[1,2,4,6,8,12,16], price:{1:18,2:28,4:45,6:60,8:78,12:115,16:145} }, // تيرابايت مراقبة
  poeSwitch: { ports:[4,8,16,24], price:{4:22,8:38,16:68,24:98} },
  ap: {
    basic:{name:'أكسس بوينت WiFi 5', price:22},
    pro:  {name:'أكسس بوينت WiFi 6', price:38},
    prem: {name:'أكسس بوينت WiFi 6 سقفي احترافي', price:58},
    controller:{name:'وحدة تحكم للشبكة', price:45},
  },
  intercom: { basic:{name:'إنتركم فيديو', price:38}, pro:{name:'إنتركم فيديو بالموبايل', price:60}, prem:{name:'إنتركم ذكي متعدد الشقق', price:95} },
  alarm:    { basic:{name:'طقم إنذار أساسي', price:65}, pro:{name:'طقم إنذار بالموبايل', price:95}, prem:{name:'نظام إنذار متكامل بالحساسات', price:150} },
  router4g: { name:'راوتر 4G للمتابعة عن بعد', price:32 },
  netPoint: { basic:{name:'نقطة شبكة سلكية Cat5e', price:5}, pro:{name:'نقطة شبكة سلكية Cat6', price:7}, prem:{name:'نقطة شبكة سلكية Cat6A', price:10} },
  tvPoint:  { basic:{name:'نقطة تلفزيون', price:6}, pro:{name:'نقطة تلفزيون HD', price:8}, prem:{name:'نقطة تلفزيون 4K', price:11} },
  rack:     { basic:{name:'كبينة شبكة صغيرة', price:15}, pro:{name:'كبينة شبكة 6U منظمة', price:28}, prem:{name:'كبينة 9U بتهوية وتنظيم', price:45} },
  installPerPoint: 8, // د.ك لكل نقطة تركيب — يتضرب في معامل حالة المكان
};

// اشتراطات وزارة الداخلية للمنشآت التجارية — راجع النص الرسمي حسب نوع النشاط قبل الإطلاق، والقيم دي config
const COMMERCIAL_TYPES = ['shop','office','warehouse'];
const MOI_RETENTION_DAYS = 180;
const MOI_NOTICE = 'تنويه: اشتراطات وزارة الداخلية للمنشآت التجارية تتطلب الاحتفاظ بالتسجيل لمدة 6 شهور.';

const TIERS = [
  { tier:'basic', title:'الباقة الأساسية',  outcome:'تعرف إن في حركة وتراجع التسجيلات وقت ما تحب.' },
  { tier:'pro',   title:'الباقة المحترفة',  outcome:'تميّز الوجوه وأرقام العربيات بوضوح — نهاراً وليلاً.', badge:'الأكثر طلباً' },
  { tier:'prem',  title:'الباقة الممتازة',  outcome:'تفاصيل دقيقة بالألوان حتى في العتمة، وأعلى جودة تخزين.' },
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

const loadingCatalog = ref(true);

const step = ref(1);
    const submitted = ref(false);
    const phoneTouched = ref(false);

    const stepNames = ["نوع المكان","تفاصيل المكان","احتياجك","الميزانية","الباقات والتواصل"];

    const placeTypes = [
      {id:'apartment', label:'شقة',          icon:'apartment'},
      {id:'villa',     label:'فيلا / بيت',    icon:'villa'},
      {id:'shop',      label:'محل',          icon:'shop'},
      {id:'office',    label:'مكتب / شركة',   icon:'office'},
      {id:'warehouse', label:'مخزن / مصنع',   icon:'warehouse'},
      {id:'compound',  label:'عمارة / كمبوند', icon:'compound'},
    ];

    const areaOpts      = [{label:'أقل من 100م²',mid:80},{label:'100–250م²',mid:175},{label:'250–500م²',mid:375},{label:'أكتر من 500م²',mid:650}];
    const floorOpts     = [{label:'دور واحد',v:1},{label:'دورين',v:2},{label:'3 أدوار أو أكتر',v:3}];
    const entranceOpts  = [{label:'1',v:1},{label:'2',v:2},{label:'3',v:3},{label:'4+',v:4}];
    const conditionOpts = [{label:'لسه بيتبني',factor:0.9},{label:'في مرحلة التشطيب',factor:1.0},{label:'جاهز ومتشطب',factor:1.35}];
    const deviceOpts    = [{label:'أقل من 10'},{label:'10–25'},{label:'أكتر من 25'}];
    const recordOpts    = [{label:'أسبوع',days:7},{label:'أسبوعين',days:14},{label:'شهر',days:30},{label:'3 شهور',days:90},{label:'6 شهور',days:180}];
    const budgetOpts    = [{label:'أقل من 200 د.ك'},{label:'200–500 د.ك'},{label:'500–1000 د.ك'},{label:'أكتر من 1000 د.ك'}];
    const brandOpts     = [{label:'Hikvision'},{label:'Dahua'},{label:'Ubiquiti'},{label:'TP-Link'},{label:'انصحوني بالأنسب'}];

    const goals = [
      {id:'entry',     label:'مراقبة المداخل والأبواب',   sub:'تعرف مين دخل وخرج وامتى',      icon:'door'},
      {id:'indoor',    label:'مراقبة من جوه',             sub:'الصالة، الكاشير، الممرات',      icon:'cam'},
      {id:'perimeter', label:'تأمين المحيط الخارجي',      sub:'الحوش، الجراج، السور',         icon:'fence'},
      {id:'wifi',      label:'واي فاي قوي يغطي كل المكان', sub:'من غير مناطق ضعيفة',           icon:'wifi'},
      {id:'intercom',  label:'إنتركم للباب',              sub:'تشوف وترد على اللي بره',       icon:'intercom'},
      {id:'alarm',     label:'إنذار ضد السرقة',           sub:'تنبيه فوري لو في حركة غريبة',   icon:'bell'},
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
      {id:'cam',  label:'كاميرا',      icon:'cam'},
      {id:'ap',   label:'أكسس',       icon:'wifi'},
      {id:'net',  label:'نقطة نت',    icon:'net'},
      {id:'tv',   label:'تلفزيون',    icon:'tv'},
      {id:'rack', label:'الكبينة',    icon:'rack'},
      {id:'note', label:'ملاحظة',     icon:'pin'},
    ];
    const PIN_MODES = pinTypes.map(p=>p.id);
    const pinIcon  = t => (pinTypes.find(x=>x.id===t)||{}).icon || 'pin';
    const pinLabel = t => (pinTypes.find(x=>x.id===t)||{}).label || '';
    function onPlanFile(e){
      const f = e.target.files && e.target.files[0];
      if(!f) return;
      if(f.size > 8*1024*1024){ plan.err = 'الصورة أكبر من 8 ميجا — صغّرها الأول.'; e.target.value=''; return; }
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
    function startDrag(pin, e){
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

    // ---- أداة الرسم: مستطيلات (أوض) بأسماء + دبابيس — مقيّدة عمداً عشان الناتج يفضل مقروء ----
    const planTab = ref('draw');
    const sk = reactive({ mode:'room', rooms:[], pins:[], sel:null, draft:null, hist:[], generated:false, dismiss:false, floor:'g' });
    // مفردات لكل نوع مكان — الاحترافية إن المكتب مايشوفش "غرفة نوم"
    const VOCAB = {
      apartment: {in:['صالة','نوم','مطبخ','حمام','مدخل','ممر'], out:['بلكونة']},
      villa:     {in:['صالة','نوم','مطبخ','حمام','مدخل','ممر'], out:['حوش','حديقة','جراج','موقف']},
      compound:  {in:['صالة','نوم','مطبخ','حمام','مدخل','ممر'], out:['حوش','حديقة','جراج','موقف']},
      shop:      {in:['صالة','مخزن','مكتب','حمام','مدخل'],      out:['موقف']},
      office:    {in:['استقبال','مكتب','اجتماعات','ممر','حمام','مخزن'], out:['موقف']},
      warehouse: {in:['مخزن','مكتب','حمام','مدخل'],             out:['ساحة','موقف']},
    };
    const roomLabels = computed(()=>{
      const v = VOCAB[a.place] || VOCAB.villa;
      const extra = floorsAvail.value.length > 1 ? ['سلم'] : [];
      return [...v.in, ...extra, ...v.out];
    });
    const ZONE = {'صالة':'in','نوم':'in','مطبخ':'in','حمام':'in','مدخل':'in','ممر':'in','مكتب':'in','مخزن':'in','استقبال':'in','اجتماعات':'in','أوضة':'in','سلم':'in','حوش':'out','حديقة':'out','جراج':'out','موقف':'out','بلكونة':'out','ساحة':'out'};
    const zoneType = l => ZONE[l] || 'in';
    // الأدوار المتاحة بتتولد من إجابة "عدد الأدوار" ونوع المكان — دور واحد = مفيش تابات ولا احتكاك
    const FLOOR_DEFS = [{id:'g',label:'الأرضي'},{id:'f1',label:'الأول'},{id:'f2',label:'التاني'},{id:'roof',label:'السطح'}];
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
      const needIn = camCounts.value.indoor, needOut = camCounts.value.outdoor, needAp = apCount.value;
      sk.rooms.splice(0); sk.pins.splice(0);
      const out = a.outdoor===true, big = a.area>=2, ent = a.entrances!==null ? entranceOpts[a.entrances].v : 1;
      const R = [];
      const t = a.place;
      const vNum = a.floors!==null ? floorOpts[a.floors].v : 1;
      if(t==='shop'){
        R.push({x:4,y:6,w:92,h:50,label:'صالة',floor:'g'},{x:4,y:60,w:44,h:34,label:'مخزن',floor:'g'});
        if(out) R.push({x:52,y:60,w:44,h:34,label:'موقف',floor:'g'});
      } else if(t==='office'){
        R.push({x:4,y:6,w:40,h:28,label:'استقبال',floor:'g'},{x:48,y:6,w:48,h:28,label:'مكتب',floor:'g'},{x:48,y:38,w:48,h:26,label:'اجتماعات',floor:'g'},{x:4,y:38,w:40,h:26,label:'ممر',floor:'g'});
        if(out) R.push({x:4,y:70,w:92,h:26,label:'موقف',floor:'g'});
      } else if(t==='warehouse'){
        R.push({x:4,y:6,w:92,h:56,label:'مخزن',floor:'g'},{x:4,y:66,w:28,h:28,label:'مكتب',floor:'g'});
        if(out) R.push({x:36,y:66,w:60,h:28,label:'ساحة',floor:'g'});
      } else if(t==='apartment'){
        R.push({x:4,y:6,w:54,h:42,label:'صالة',floor:'g'},{x:62,y:6,w:34,h:26,label:'نوم',floor:'g'},{x:62,y:36,w:34,h:24,label:'مطبخ',floor:'g'},{x:4,y:52,w:28,h:22,label:'حمام',floor:'g'});
        if(big) R.push({x:36,y:52,w:22,h:22,label:'نوم',floor:'g'});
        if(out) R.push({x:62,y:64,w:34,h:16,label:'بلكونة',floor:'g'});
      } else {
        const stair = vNum>=2; // سلم حقيقي بيتكرر في نفس المكان على كل الأدوار
        if(out){
          if(stair){
            R.push({x:4,y:4,w:48,h:32,label:'صالة',floor:'g'},{x:56,y:4,w:10,h:26,label:'سلم',floor:'g'},{x:70,y:4,w:26,h:26,label:'نوم',floor:'g'},{x:70,y:34,w:26,h:22,label:'مطبخ',floor:'g'},{x:4,y:40,w:22,h:16,label:'حمام',floor:'g'});
            if(big) R.push({x:30,y:40,w:22,h:16,label:'نوم',floor:'g'});
          } else {
            R.push({x:4,y:4,w:54,h:32,label:'صالة',floor:'g'},{x:62,y:4,w:34,h:24,label:'نوم',floor:'g'},{x:62,y:32,w:34,h:24,label:'مطبخ',floor:'g'},{x:4,y:40,w:24,h:16,label:'حمام',floor:'g'});
            if(big) R.push({x:32,y:40,w:26,h:16,label:'نوم',floor:'g'});
          }
          if(ent>=2 || t==='villa'){
            R.push({x:4,y:62,w:70,h:34,label: t==='compound' ? 'حديقة' : 'حوش',floor:'g'});
            R.push({x:78,y:62,w:18,h:34,label:'جراج',floor:'g'});
          } else {
            R.push({x:4,y:62,w:92,h:34,label: t==='compound' ? 'حديقة' : 'حوش',floor:'g'});
          }
        } else {
          if(stair){
            R.push({x:4,y:6,w:48,h:42,label:'صالة',floor:'g'},{x:56,y:6,w:10,h:26,label:'سلم',floor:'g'},{x:70,y:6,w:26,h:26,label:'نوم',floor:'g'},{x:70,y:36,w:26,h:24,label:'مطبخ',floor:'g'},{x:4,y:52,w:26,h:20,label:'حمام',floor:'g'});
            if(big) R.push({x:34,y:52,w:18,h:20,label:'نوم',floor:'g'});
          } else {
            R.push({x:4,y:6,w:54,h:42,label:'صالة',floor:'g'},{x:62,y:6,w:34,h:26,label:'نوم',floor:'g'},{x:62,y:36,w:34,h:24,label:'مطبخ',floor:'g'},{x:4,y:52,w:28,h:22,label:'حمام',floor:'g'});
            if(big) R.push({x:36,y:52,w:22,h:22,label:'نوم',floor:'g'});
          }
        }
        if(stair){
          R.push({x:56,y:4,w:10,h:26,label:'سلم',floor:'f1'},{x:4,y:4,w:48,h:40,label:'نوم',floor:'f1'},{x:70,y:4,w:26,h:40,label:'نوم',floor:'f1'},{x:4,y:50,w:26,h:20,label:'حمام',floor:'f1'},{x:34,y:50,w:62,h:20,label:'ممر',floor:'f1'});
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
      const NETLBL = ['صالة','نوم','مكتب','استقبال','اجتماعات','مخزن'];
      sk.rooms.forEach(r=>{
        if(sk.pins.length>=29) return;
        if(zoneType(r.label)==='in' && NETLBL.includes(r.label) && r.w*r.h>=450){
          sk.pins.push({t:'net', x:clampV(r.x+8, r.x+4, r.x+r.w-4), y:clampV(r.y+r.h-6, r.y+4, r.y+r.h-4), floor:r.floor||'g'});
        }
      });
      const tvRoom = sk.rooms.filter(r=>['صالة','استقبال'].includes(r.label)).sort((ra,rb)=>rb.w*rb.h - ra.w*ra.h)[0];
      if(tvRoom && sk.pins.length<30) sk.pins.push({t:'tv', x:tvRoom.x+tvRoom.w/2, y:clampV(tvRoom.y+6, tvRoom.y+4, tvRoom.y+tvRoom.h-4), floor:tvRoom.floor||'g'});
      const RACKLBL = ['ممر','مدخل','مخزن'];
      const rackRoom = sk.rooms.find(r=>(r.floor||'g')==='g' && RACKLBL.includes(r.label))
                    || sk.rooms.find(r=>(r.floor||'g')==='g' && zoneType(r.label)==='in' && r.label!=='سلم')
                    || sk.rooms.find(r=>RACKLBL.includes(r.label));
      if(rackRoom && sk.pins.length<30) sk.pins.push({t:'rack', x:clampV(rackRoom.x+rackRoom.w-8, rackRoom.x+4, rackRoom.x+rackRoom.w-4), y:clampV(rackRoom.y+8, rackRoom.y+4, rackRoom.y+rackRoom.h-4), floor:rackRoom.floor||'g'});
      sk.generated = true; sk.dismiss = false; sk.sel = null;
      // في الموقع: سجّل event باسم sketch_generated هنا
    }

    // سعر لايف جنب الرسم — عشان الزبون يشوف أثر كل كاميرا بيحطها من غير ما يطلع فوق
    const livePkg = computed(()=>{
      const t = (a.package && a.package!=='advise') ? a.package : 'pro';
      return packages.value.find(p=>p.tier===t) || null;
    });

    // ---- 3D preview (مرجع تنفيذ للمرحلة المؤجلة) — المكتبة بتتحمل لحظة الضغط بس ----
    const s3d = reactive({ open:false, ready:false, fail:false, loading:false });
    let T=null, tScene=null, tCam=null, tRen=null, tDyn=null, tKey='', tTheta=0.9, tPhi=1.02, tR=9.5, tAuto=true;
    function load3dLib(){
      return new Promise((res, rej)=>{
        if(window.THREE){ res(); return; }
        const s = document.createElement('script');
        s.src = 'https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js';
        s.onload = res; s.onerror = rej;
        document.head.appendChild(s);
      });
    }
    function toggle3d(){
      if(s3d.open){ s3d.open = false; return; }
      s3d.open = true;
      if(s3d.ready || s3d.loading) return;
      s3d.loading = true;
      load3dLib().then(()=>{ s3d.fail=false; nextTick(()=> init3d()); })
                 .catch(()=>{ s3d.fail=true; s3d.open=false; s3d.loading=false; });
    }
    function init3d(){
      const wrap = document.getElementById('skt3d');
      if(!wrap || !window.THREE){ s3d.fail=true; s3d.loading=false; return; }
      T = window.THREE;
      tScene = new T.Scene();
      const W = wrap.clientWidth || 340, Hh = 300;
      tCam = new T.PerspectiveCamera(46, W/Hh, 0.1, 100);
      tRen = new T.WebGLRenderer({antialias:true, alpha:true});
      tRen.setPixelRatio(Math.min(window.devicePixelRatio||1, 2));
      tRen.setSize(W, Hh); tRen.setClearColor(0x000000, 0);
      wrap.appendChild(tRen.domElement);
      tScene.add(new T.AmbientLight(0xffffff, 0.8));
      const dl = new T.DirectionalLight(0xffffff, 0.65); dl.position.set(5,9,4); tScene.add(dl);
      const g = new T.Mesh(new T.PlaneGeometry(13,13), new T.MeshLambertMaterial({color:0xF1EFE8}));
      g.rotation.x = -Math.PI/2; g.position.y = -0.02; tScene.add(g);
      tScene.add(new T.GridHelper(12,12,0xD3D1C7,0xE0DED5));
      tDyn = new T.Group(); tScene.add(tDyn);
      let tTarget = new T.Vector3(0, 0.35, 0);
      const wallM = new T.MeshLambertMaterial({color:0xB4B2A9});
      const fenceM = new T.MeshLambertMaterial({color:0x97C459});
      const slabIn = new T.MeshLambertMaterial({color:0xE1F5EE});
      const slabOut = new T.MeshLambertMaterial({color:0xC0DD97});
      const camM = new T.MeshLambertMaterial({color:0x1D9E75});
      const apM = new T.MeshLambertMaterial({color:0x7F77DD});
      const noteM = new T.MeshLambertMaterial({color:0xE5484D});
      function bx(w,h,d,m,x,y,z){ const b=new T.Mesh(new T.BoxGeometry(w,h,d),m); b.position.set(x,y,z); tDyn.add(b); }
      function rebuild(){
        for(let i=tDyn.children.length-1;i>=0;i--){
          const c=tDyn.children[i];
          if(c.geometry) c.geometry.dispose();
          if(c.material && c.material.map) c.material.map.dispose();
          tDyn.remove(c);
        }
        const vNum = a.floors!==null ? floorOpts[a.floors].v : 1;
        const LVL = {g:0, f1:1, f2:2, roof:(vNum>=3?3:2)};
        let top = 0;
        sk.rooms.concat(sk.pins).forEach(x=>{ top = Math.max(top, LVL[x.floor||'g']||0); });
        tTarget = new T.Vector3(0, 0.35 + top*0.6, 0);
        sk.rooms.forEach(r=>{
          const o = zoneType(r.label)==='out', H = o ? 0.32 : 1.1;
          const yOff = (LVL[r.floor||'g']||0) * 1.4;
          const rw=r.w*0.1, rd=r.h*0.1, cx=(r.x+r.w/2-50)*0.1, cz=(r.y+r.h/2-50)*0.1;
          bx(rw,H,0.06, o?fenceM:wallM, cx, yOff+H/2, cz-rd/2);
          bx(rw,H,0.06, o?fenceM:wallM, cx, yOff+H/2, cz+rd/2);
          bx(0.06,H,rd, o?fenceM:wallM, cx-rw/2, yOff+H/2, cz);
          bx(0.06,H,rd, o?fenceM:wallM, cx+rw/2, yOff+H/2, cz);
          bx(rw-0.08,0.04,rd-0.08, o?slabOut:slabIn, cx, yOff+0.02, cz);
          const cv=document.createElement('canvas'); cv.width=256; cv.height=96;
          const c2=cv.getContext('2d'); c2.font='500 42px sans-serif'; c2.textAlign='center'; c2.fillStyle='#444441'; c2.fillText(r.label,128,60);
          const sp=new T.Sprite(new T.SpriteMaterial({map:new T.CanvasTexture(cv), transparent:true}));
          sp.scale.set(1.7,0.64,1); sp.position.set(cx, yOff+H+0.5, cz); tDyn.add(sp);
        });
        const netM = new T.MeshLambertMaterial({color:0x2F6FED});
        const tvM = new T.MeshLambertMaterial({color:0xC026D3});
        const rackM = new T.MeshLambertMaterial({color:0xB7791F});
        sk.pins.forEach(p=>{
          const px=(p.x-50)*0.1, pz=(p.y-50)*0.1;
          const yOff = (LVL[p.floor||'g']||0) * 1.4;
          if(p.t==='rack'){ bx(0.32,0.95,0.24, rackM, px, yOff+0.475, pz); return; }
          if(p.t==='net' || p.t==='tv'){
            const m2 = p.t==='net' ? netM : tvM;
            bx(0.05,0.5,0.05, m2, px, yOff+0.25, pz);
            const s2=new T.Mesh(new T.SphereGeometry(0.09,14,10), m2); s2.position.set(px, yOff+0.52, pz); tDyn.add(s2);
            return;
          }
          const m = p.t==='cam' ? camM : p.t==='ap' ? apM : noteM;
          bx(0.05,1.25,0.05, m, px, yOff+0.62, pz);
          const s=new T.Mesh(new T.SphereGeometry(0.1,16,12), m); s.position.set(px, yOff+1.28, pz); tDyn.add(s);
          if(p.t==='cam'){
            const cg=new T.ConeGeometry(0.5,1.7,24,1,true); cg.rotateX(-Math.PI/2); cg.translate(0,0,0.85);
            const cone=new T.Mesh(cg, new T.MeshBasicMaterial({color:0x1D9E75, transparent:true, opacity:0.14, side:T.DoubleSide}));
            const gp=new T.Group(); gp.position.set(px, yOff+1.28, pz); gp.add(cone); gp.lookAt(new T.Vector3(0, yOff+0.35, 0)); tDyn.add(gp);
          }
        });
      }
      let down=false, lx=0, ly=0;
      wrap.addEventListener('pointerdown', e=>{ down=true; tAuto=false; lx=e.clientX; ly=e.clientY; wrap.setPointerCapture && wrap.setPointerCapture(e.pointerId); });
      window.addEventListener('pointermove', e=>{ if(!down) return; tTheta-=(e.clientX-lx)*0.008; tPhi=Math.min(1.35, Math.max(0.35, tPhi+(e.clientY-ly)*0.006)); lx=e.clientX; ly=e.clientY; });
      window.addEventListener('pointerup', ()=>{ down=false; });
      s3d.ready = true; s3d.loading = false;
      (function loop(){
        requestAnimationFrame(loop);
        if(!s3d.open) return;
        const key = JSON.stringify([sk.rooms, sk.pins]);
        if(key !== tKey){ tKey = key; rebuild(); }
        if(tAuto) tTheta += 0.0035;
        tCam.position.set(tR*Math.sin(tPhi)*Math.sin(tTheta), tR*Math.cos(tPhi), tR*Math.sin(tPhi)*Math.cos(tTheta));
        tCam.lookAt(tTarget);
        tRen.render(tScene, tCam);
      })();
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
          sk.rooms.push({...sk.draft, label:'أوضة', floor: sk.floor});
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

// fetch catalog on mounted
onMounted(async () => {
    try {
        const res = await axios.get('/ajax/vue/wizard-catalog');
        if (res.data && res.data.data) {
            CATALOG = res.data.data;
            loadingCatalog.value = false;
        }
    } catch (e) {
        console.error('Failed to load catalog', e);
        // Fallback for development if API is not ready
        alert('فشل في تحميل الإعدادات');
    }
});

// submit handler
const submitLead = async () => {
  phoneTouched.value = true;
  if(!phoneValid.value) return;
  submitting.value = true;
  try {
    const p = payload();
    const res = await axios.post('/ajax/vue/project-leads', p);
    if (res.data && res.data.success) {
      submitted.value = true;
    } else {
      alert(res.data.message || 'حدث خطأ أثناء الإرسال');
    }
  } catch(e) {
    console.error(e);
    alert('تعذر الاتصال بالسيرفر. يرجى المحاولة مرة أخرى.');
  } finally {
    submitting.value = false;
  }
};

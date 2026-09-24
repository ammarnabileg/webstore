<template>
<div class="suha-page">
  <div v-if="loadingCatalog" class="sw-state" role="status">جارٍ التحميل...</div>
  <div v-else-if="catalogError" class="sw-state" role="alert">
    <p>تعذّر تحميل بيانات الباقات.</p>
    <button class="btn btn-primary" @click="loadCatalog">حاول مرة أخرى</button>
  </div>
  <template v-else>
<!-- header -->
  <div class="top">
    <div class="brand">
      <div class="brand-mark" aria-hidden="true">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round"><path d="M12 3l8 4v5c0 5-3.5 8-8 9-4.5-1-8-4-8-9V7z"/><circle cx="12" cy="11" r="3"/><path d="M12 11h.01"/></svg>
      </div>
      <div>
        <div class="brand-name">اعرف نظامك</div>
        <div class="brand-sub">كاميرات · شبكات · أمان</div>
      </div>
    </div>
    <div class="signal" role="img" :aria-label="'الخطوة ' + step + ' من 5'">
      <span v-for="n in 5" :key="n" :class="{on: step >= n}"></span>
    </div>
  </div>
  <div class="step-label" v-if="!submitted">الخطوة {{ step }} من 5 — {{ stepNames[step-1] }}</div>

  <main>
    <transition name="step" mode="out-in">

      <!-- STEP 1: place type -->
      <section v-if="step===1 && !submitted" key="s1">
        <h1 class="q-title">لأي مكان هذا النظام؟</h1>
        <p class="q-hint">اختر نوع المكان وسنتولى الباقي.</p>
        <div class="grid">
          <button v-for="p in placeTypes" :key="p.id" class="opt"
                  :class="{sel: a.place===p.id}" @click="a.place=p.id"
                  :aria-pressed="a.place===p.id">
            <span class="ic" v-html="icon(p.icon)"></span>
            {{ p.label }}
          </button>
        </div>
      </section>

      <!-- STEP 2: place details -->
      <section v-else-if="step===2 && !submitted" key="s2">
        <h1 class="q-title">أخبرنا عن المكان</h1>
        <p class="q-hint">تكفي الأرقام التقريبية، لا نحتاج إلى دقة.</p>

        <div class="seg-block">
          <div class="seg-title">المساحة الإجمالية تقريباً</div>
          <div class="seg">
            <button v-for="(o,i) in areaOpts" :key="i" class="opt" :class="{sel:a.area===i}" @click="a.area=i" :aria-pressed="a.area===i">{{ o.label }}</button>
          </div>
        </div>

        <div class="seg-block">
          <div class="seg-title">عدد الأدوار</div>
          <div class="seg">
            <button v-for="(o,i) in floorOpts" :key="i" class="opt" :class="{sel:a.floors===i}" @click="a.floors=i" :aria-pressed="a.floors===i">{{ o.label }}</button>
          </div>
        </div>

        <div class="seg-block">
          <div class="seg-title">عدد المداخل الرئيسية</div>
          <div class="seg">
            <button v-for="(o,i) in entranceOpts" :key="i" class="opt" :class="{sel:a.entrances===i}" @click="a.entrances=i" :aria-pressed="a.entrances===i">{{ o.label }}</button>
          </div>
        </div>

        <div class="seg-block">
          <div class="seg-title">هل توجد مناطق خارجية؟ (حوش / كراج / سور)</div>
          <div class="seg">
            <button class="opt" :class="{sel:a.outdoor===true}" @click="a.outdoor=true" :aria-pressed="a.outdoor===true">نعم</button>
            <button class="opt" :class="{sel:a.outdoor===false}" @click="a.outdoor=false" :aria-pressed="a.outdoor===false">لا</button>
          </div>
        </div>

        <div class="seg-block">
          <div class="seg-title">حالة المكان حاليًا</div>
          <div class="seg">
            <button v-for="(o,i) in conditionOpts" :key="i" class="opt" :class="{sel:a.condition===i}" @click="a.condition=i" :aria-pressed="a.condition===i">{{ o.label }}</button>
          </div>
        </div>

        <div class="seg-block" v-if="a.condition===2">
          <div class="seg-title">هل توجد تمديدات (مواسير) جاهزة للكاميرات والشبكة؟</div>
          <div class="seg">
            <button class="opt" :class="{sel:a.conduits==='yes'}" @click="a.conduits='yes'" :aria-pressed="a.conduits==='yes'">نعم، موجودة</button>
            <button class="opt" :class="{sel:a.conduits==='no'}" @click="a.conduits='no'" :aria-pressed="a.conduits==='no'">لا</button>
            <button class="opt" :class="{sel:a.conduits==='unsure'}" @click="a.conduits='unsure'" :aria-pressed="a.conduits==='unsure'">لست متأكدًا</button>
          </div>
          <p class="plan-hint" v-if="a.conduits==='unsure'" style="margin-top:8px;">لا مشكلة، سنتأكد منها في المعاينة المجانية، وإذا كانت التمديدات موجودة ينخفض السعر.</p>
        </div>
      </section>

      <!-- STEP 3: needs (problem language) -->
      <section v-else-if="step===3 && !submitted" key="s3">
        <h1 class="q-title">ماذا تريد أن يحقق لك النظام؟</h1>
        <p class="q-hint">اختر كل ما يهمك، لا يلزم أن تعرف أسماء الأجهزة.</p>
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
          <div class="seg-title">كم جهازًا تقريبًا سيستخدم الإنترنت؟</div>
          <div class="seg">
            <button v-for="(o,i) in deviceOpts" :key="i" class="opt" :class="{sel:a.devices===i}" @click="a.devices=i" :aria-pressed="a.devices===i">{{ o.label }}</button>
          </div>
        </div>

        <div class="seg-block" v-if="wantsCams" style="margin-top:6px;">
          <div class="seg-title">ما المدة التي تريد حفظ التسجيل خلالها؟</div>
          <div class="seg">
            <button v-for="(o,i) in recordOpts" :key="i" class="opt" :class="{sel:a.recordDays===i}" @click="a.recordDays=i" :aria-pressed="a.recordDays===i">{{ o.label }}</button>
          </div>
          <p class="plan-hint" v-if="isCommercial" style="margin-top:8px;">{{ moiNotice }}</p>
          <p class="plan-hint" v-if="isCommercial && a.recordDays!==null && recordOpts[a.recordDays].days < 180" style="color:var(--rec);margin-top:4px;">اختيارك أقل من اشتراط الوزارة للمنشآت التجارية. يمكننا تنفيذه، لكن المسؤولية النظامية تقع عليك.</p>
        </div>

        <div class="seg-block" v-if="wantsCams">
          <div class="seg-title">هل يوجد إنترنت ثابت في المكان؟ <span style="font-weight:400;color:var(--muted);">(للمتابعة من الهاتف)</span></div>
          <div class="seg">
            <button class="opt" :class="{sel:a.internet==='yes'}" @click="a.internet='yes'" :aria-pressed="a.internet==='yes'">نعم</button>
            <button class="opt" :class="{sel:a.internet==='no'}" @click="a.internet='no'" :aria-pressed="a.internet==='no'">لا</button>
          </div>
        </div>

        <div class="seg-block" v-if="zoomVisible">
          <div class="seg-title">هل توجد نقاط بعيدة تحتاج إلى تقريب الصورة عليها؟ <span style="font-weight:400;color:var(--muted);">(بوابة بعيدة، ساحة، سور طويل)</span></div>
          <div class="seg">
            <button class="opt" :class="{sel:a.zoom===true}" @click="a.zoom=true" :aria-pressed="a.zoom===true">نعم</button>
            <button class="opt" :class="{sel:a.zoom===false}" @click="a.zoom=false" :aria-pressed="a.zoom===false">لا</button>
          </div>
        </div>
      </section>

      <!-- STEP 4: budget & brand (optional) -->
      <section v-else-if="step===4 && !submitted" key="s4">
        <h1 class="q-title">هل لديك ميزانية تقريبية؟</h1>
        <p class="q-hint">اختياري، ويساعدنا على ترشيح الأنسب لك من المرة الأولى.</p>
        <div class="seg-block">
          <div class="seg">
            <button v-for="(o,i) in budgetOpts" :key="i" class="opt" :class="{sel:a.budget===i}" @click="a.budget=i" :aria-pressed="a.budget===i">{{ o.label }}</button>
          </div>
        </div>
        <div class="seg-block">
          <div class="seg-title">هل تفضّل علامة تجارية معينة؟</div>
          <div class="seg">
            <button v-for="(o,i) in brandOpts" :key="i" class="opt" :class="{sel:a.brand===i}" @click="a.brand=i" :aria-pressed="a.brand===i">{{ o.label }}</button>
          </div>
        </div>
        <button class="skip" @click="skipBudget">تخطَّ، لم أحدد بعد</button>
      </section>

      <!-- STEP 5: packages + summary + lead -->
      <section v-else-if="step===5 && !submitted" key="s5">
        <h1 class="q-title">اختر الباقة المناسبة لك</h1>
        <p class="q-hint">بُنيت على إجاباتك، بمكونات حقيقية من مخزوننا.</p>

        <button v-for="pkg in packages" :key="pkg.tier" class="pkg"
                :class="{sel: a.package===pkg.tier}" @click="a.package=pkg.tier"
                :aria-pressed="a.package===pkg.tier">
          <span v-if="pkg.badge" class="pkg-badge">{{ pkg.badge }}</span>
          <div class="pkg-head">
            <span class="pkg-name">{{ pkg.title }}</span>
            <span class="pkg-price">يبدأ من ~{{ pkg.total }} د.ك <small>شاملة التركيب التقديري</small></span>
          </div>
          <div class="pkg-outcome">{{ pkg.outcome }}</div>
          <ul class="pkg-items">
            <li v-for="it in pkg.items" :key="it.name">
              <span>{{ it.name }}</span><span>{{ it.qty > 1 ? '×' + it.qty : '' }}</span>
            </li>
          </ul>
          <div class="pkg-foot" v-if="pkg.foot">{{ pkg.foot }}</div>
        </button>

        <button class="pkg slim" :class="{sel: a.package==='advise'}" @click="a.package='advise'" :aria-pressed="a.package==='advise'">
          <span class="pkg-name">لست متأكدًا؟ اترك الأمر لنا، وسنرشح لك الأنسب في المعاينة المجانية</span>
        </button>

        <p class="reco-note">الأسعار استرشادية وتُؤكَّد بعد معاينة المكان، والمعاينة مجانية ودون التزام. تختلف تكلفة التركيب حسب حالة المكان{{ a.condition===2 ? ' (المكان المُشطّب يحتاج إلى تمديدات خارجية عبر مجارٍ)' : '' }}. إذا رسمت مخطط المكان بالأسفل، تُضبط أعداد الكاميرات وأسعار الباقات عليه تلقائيًا.{{ a.condition===2 && a.conduits==='unsure' ? ' وإذا تبيّن في المعاينة وجود التمديدات، ينخفض السعر ولا يزيد.' : '' }}</p>

        <div class="h-sub">ملخص طلبك</div>
        <div class="sum-list">
          <div class="sum-row" v-for="s in summary" :key="s.k">
            <span class="k">{{ s.k }}</span><span class="v">{{ s.v }}</span>
          </div>
        </div>

        <div class="h-sub">مخطط المكان <span style="font-weight:400;color:var(--muted);font-size:13px;">(اختياري، ويساعدنا على تجهيز عرض أدق قبل المعاينة)</span></div>
        <div class="plan-box">
          <div class="plan-tabs">
            <button :class="{sel:planTab==='draw'}" @click="planTab='draw'">ارسمه بنفسك</button>
            <button :class="{sel:planTab==='upload'}" @click="planTab='upload'">ارفع صورة</button>
          </div>

          <!-- DRAW PANE -->
          <div v-if="planTab==='draw'">
            <div class="plan-tools">
              <button class="tool" :class="{sel:sk.mode==='room'}" @click="sk.mode='room'" :aria-pressed="sk.mode==='room'">
                <span v-html="icon('room')"></span> منطقة
              </button>
              <button v-for="pt in pinTypes" :key="pt.id" class="tool" :class="{sel:sk.mode===pt.id}" @click="sk.mode=pt.id" :aria-pressed="sk.mode===pt.id">
                <span v-html="icon(pt.icon)"></span> {{ pt.label }}
              </button>
              <button class="tool" @click="skUndo" :disabled="!sk.hist.length">تراجع</button>
              <button class="tool danger" v-if="sk.rooms.length || sk.pins.length" @click="skClear">امسح الكل</button>
            </div>

            <div class="floor-tabs" v-if="floorsAvail.length > 1">
              <button v-for="f in floorsAvail" :key="f.id" :class="{sel: sk.floor===f.id}" @click="sk.floor=f.id" :aria-pressed="sk.floor===f.id">
                {{ f.label }} <span class="cnt" v-if="floorCount(f.id)">({{ floorCount(f.id) }})</span>
              </button>
            </div>

            <div class="live-price" v-if="livePkg">
              <span>سعر {{ livePkg.title }} الآن <span style="color:var(--muted);">(يتحدّث مع كل كاميرا ونقطة واي فاي تضيفها)</span></span>
              <b>~{{ livePkg.total }} د.ك</b>
            </div>

            <div class="label-chips" v-if="sk.sel!==null && sk.rooms[sk.sel]">
              <span style="font-size:12px;color:var(--muted);">سمِّ الغرفة:</span>
              <button v-for="l in roomLabels" :key="l" class="lchip" :class="{out: zoneType(l)==='out'}" @click="labelRoom(l)">{{ l }}</button>
            </div>

            <div class="sketch-stage" @pointerdown="stageDown" @click="sketchPlacePin">
              <div v-for="(r,i) in sk.rooms" :key="'r'+i" class="room" :class="{sel: sk.sel===i, out: zoneType(r.label)==='out'}"
                   v-show="(r.floor||'g')===sk.floor"
                   :style="{left:r.x+'%', top:r.y+'%', width:r.w+'%', height:r.h+'%'}"
                   @pointerdown.stop="roomDown(i,$event)" @click.stop="roomClick(i,$event)">
                <span class="lbl">{{ r.label }}</span>
                <button class="x" @pointerdown.stop @click.stop="delRoom(i)" aria-label="احذف الغرفة">×</button>
                <span class="handle" @pointerdown.stop="resizeDown(i,$event)" aria-hidden="true"></span>
              </div>
              <div v-if="sk.draft" class="room draft"
                   :style="{left:sk.draft.x+'%', top:sk.draft.y+'%', width:sk.draft.w+'%', height:sk.draft.h+'%'}"></div>
              <div v-for="(p,i) in sk.pins" :key="'p'+i" class="pin" :class="p.t"
                   v-show="(p.floor||'g')===sk.floor"
                   :style="{left:p.x+'%', top:p.y+'%'}"
                   @pointerdown.stop.prevent="skPinDrag(p,$event)" @click.stop>
                <span v-html="icon(pinIcon(p.t))"></span>
                <button class="x" @pointerdown.stop @click.stop="delSkPin(i)" aria-label="احذف العلامة">×</button>
              </div>
              <div v-if="!sk.rooms.length && !sk.draft && !sk.dismiss" class="sketch-empty" style="pointer-events:auto;">
                <div>
                  <p style="margin-bottom:10px;">لدينا إجاباتك عن المكان. هل نجهّز لك رسمًا مبدئيًا تعدّل عليه؟</p>
                  <div style="display:flex;gap:8px;justify-content:center;">
                    <button class="lchip" style="border-color:var(--primary);color:var(--primary-ink);background:var(--primary-soft);" @pointerdown.stop @click.stop="generateStarter">جهّزه لي</button>
                    <button class="lchip" @pointerdown.stop @click.stop="sk.dismiss=true">سأرسم من البداية</button>
                  </div>
                </div>
              </div>
              <p v-else-if="!sk.rooms.length && !sk.draft" class="sketch-empty">اسحب بإصبعك هنا لرسم أول منطقة على شكل مستطيل</p>
            </div>
            <p class="plan-hint" v-if="sketchCams.in + sketchCams.out > 0" style="color:var(--ink);">كاميرات الرسم: <b>{{ sketchCams.in }}</b> داخلية · <b>{{ sketchCams.out }}</b> خارجية، وضُبطت أعداد الباقات وأسعارها بالأعلى تلقائيًا.</p>
            <p class="plan-hint" v-if="sketchWiring.nets + sketchWiring.tvs > 0 || sketchWiring.rack" style="color:var(--ink);">تمديدات: {{ sketchWiring.nets }} نقطة نت · {{ sketchWiring.tvs }} تلفزيون · الكبينة {{ sketchWiring.rack ? 'محددة' : 'لم تُحدَّد بعد' }} ، وكلها محسوبة في السعر.</p>
            <p class="plan-hint">اضغط داخل أي منطقة لإضافة نقطة فيها. الأسماء الخضراء تُحسب خارجية تلقائيًا وتغيّر نوع الكاميرا وسعرها، وأي علامة خارج كل المناطق تُعدّ خارجية. نقاط الشبكة والتلفزيون والكبينة تُحسب في السعر، أما «الملاحظة» فللتوضيح فقط. الكبينة واحدة للنظام كله، وأي ضغطة جديدة تنقلها.</p>
          </div>

          <!-- UPLOAD PANE -->
          <div v-else>
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
        </div>

        <div class="field">
          <label for="name">اسمك</label>
          <input id="name" v-model.trim="lead.name" type="text" autocomplete="name" placeholder="الاسم" />
        </div>
        <div class="field">
          <label for="phone">رقم الهاتف</label>
          <input id="phone" v-model.trim="lead.phone" type="tel" inputmode="tel" autocomplete="tel" placeholder="مثال: 5xxxxxxx" @blur="phoneTouched=true" />
          <div class="err" v-if="phoneTouched && !phoneValid">أدخل رقمًا كويتيًا صحيحًا من 8 أرقام.</div>
        </div>
        <div class="hp-field" aria-hidden="true">
          <label for="sw-website">اترك هذا الحقل فارغًا</label>
          <input id="sw-website" v-model="honeypot" type="text" tabindex="-1" autocomplete="off" />
        </div>
        <p class="privacy">تُستخدم بياناتك للتواصل بخصوص طلبك فقط.</p>
        <div class="err" v-if="submitError" role="alert">{{ submitError }}</div>

        <a class="wa" v-if="waLink" :href="waLink" target="_blank" rel="noopener">
          <svg width="18" height="18" viewBox="0 0 24 24" fill="currentColor"><path d="M12 2a10 10 0 0 0-8.6 15.1L2 22l5-1.3A10 10 0 1 0 12 2zm5.4 14.1c-.2.6-1.3 1.2-1.8 1.2-.5.1-1 .2-3.4-.7-2.9-1.2-4.7-4.1-4.9-4.3-.1-.2-1.1-1.5-1.1-2.9s.7-2 1-2.3c.2-.3.5-.3.7-.3h.5c.2 0 .4 0 .6.4l.9 2.1c.1.2.1.4 0 .6l-.4.6c-.1.2-.3.4-.1.7.1.3.7 1.2 1.6 1.9 1.1.9 2 1.2 2.3 1.4.3.1.5.1.6-.1l.8-.9c.2-.2.4-.2.6-.1l2 .9c.2.1.4.2.4.3.1.1.1.6-.3 1.5z"/></svg>
          أو أرسل الطلب عبر واتساب
        </a>
      </section>

      <!-- SUCCESS -->
      <section v-else key="done" class="done">
        <div class="done-ic">
          <svg width="30" height="30" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 6L9 17l-5-5"/></svg>
        </div>
        <h2>وصلنا طلبك يا {{ lead.name || 'عزيزنا' }}</h2>
        <p>سنتواصل معك خلال 24 ساعة على {{ lead.phone }} لتحديد موعد المعاينة المجانية وتأكيد العرض النهائي.</p>
        <p v-if="serverEstimate !== null" class="done-estimate">التكلفة التقديرية لباقتك: ~{{ Math.round(serverEstimate) }} د.ك</p>
      </section>

    </transition>
  </main>

  <!-- live system tray -->
  <div class="tray" v-if="!submitted && step>1 && step<5 && trayChips.length">
    <div class="tray-inner">
      <div class="tray-card">
        <span class="tray-title"><span class="rec-dot" aria-hidden="true"></span> نظامك قيد التجهيز</span>
        <span v-for="c in trayChips" :key="c" class="chip">{{ c }}</span>
      </div>
    </div>
  </div>

  <!-- footer nav -->
  <div class="nav" v-if="!submitted">
    <div class="nav-inner">
      <button v-if="step>1" class="btn btn-ghost" @click="back">رجوع</button>
      <button class="btn btn-primary" :disabled="!canNext || submitting" @click="next">{{ submitting ? 'جارٍ الإرسال...' : nextLabel }}</button>
    </div>
  </div>
  </template>
</div>
</template>

<script setup>
import { ref, reactive, computed, nextTick, onMounted, watch } from 'vue';
import axios from 'axios';

// Catalog comes from GET /ajax/vue/wizard-catalog (admin-mapped products, see
// platform/plugins/system-wizard). The server recomputes every estimate on submit.
const catalog = ref(null);
const catalogError = ref(false);

// اشتراطات وزارة الداخلية للمنشآت التجارية — راجع النص الرسمي حسب نوع النشاط قبل الإطلاق، والقيم دي config
const COMMERCIAL_TYPES = ['shop','office','warehouse'];
const MOI_RETENTION_DAYS = 180;
const MOI_NOTICE = 'تنويه: تشترط وزارة الداخلية على المنشآت التجارية الاحتفاظ بالتسجيل لمدة 6 أشهر.';

const TIERS = [
  { tier:'basic', title:'الباقة الأساسية',  outcome:'تعرف عند وجود حركة، وتراجع التسجيلات متى شئت.' },
  { tier:'pro',   title:'الباقة الاحترافية',  outcome:'تميّز الوجوه وأرقام السيارات بوضوح، نهارًا وليلًا.', badge:'الأكثر طلبًا' },
  { tier:'prem',  title:'الباقة المميزة',  outcome:'تفاصيل دقيقة بالألوان حتى في الظلام، وأعلى جودة تخزين.' },
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
      {id:'compound',  label:'عمارة / مجمع', icon:'compound'},
    ];

    const areaOpts      = [{label:'أقل من 100م²',mid:80},{label:'100–250م²',mid:175},{label:'250–500م²',mid:375},{label:'أكثر من 500م²',mid:650}];
    const floorOpts     = [{label:'طابق واحد',v:1},{label:'طابقان',v:2},{label:'3 طوابق أو أكثر',v:3}];
    const entranceOpts  = [{label:'1',v:1},{label:'2',v:2},{label:'3',v:3},{label:'4+',v:4}];
    const conditionOpts = [{label:'قيد الإنشاء',factor:0.9},{label:'في مرحلة التشطيب',factor:1.0},{label:'جاهز ومُشطّب',factor:1.35}];
    const deviceOpts    = [{label:'أقل من 10'},{label:'10–25'},{label:'أكثر من 25'}];
    const recordOpts    = [{label:'أسبوع',days:7},{label:'أسبوعين',days:14},{label:'شهر',days:30},{label:'3 أشهر',days:90},{label:'6 أشهر',days:180}];
    const budgetOpts    = [{label:'أقل من 200 د.ك'},{label:'200–500 د.ك'},{label:'500–1000 د.ك'},{label:'أكثر من 1000 د.ك'}];
    const brandOpts     = [{label:'Hikvision'},{label:'Dahua'},{label:'Ubiquiti'},{label:'TP-Link'},{label:'انصحوني بالأنسب'}];

    const goals = [
      {id:'entry',     label:'مراقبة المداخل والأبواب',   sub:'تعرف من دخل وخرج ومتى',      icon:'door'},
      {id:'indoor',    label:'مراقبة داخلية',             sub:'الصالة، الكاشير، الممرات',      icon:'cam'},
      {id:'perimeter', label:'تأمين المحيط الخارجي',      sub:'الحوش، الكراج، السور',         icon:'fence'},
      {id:'wifi',      label:'واي فاي قوي يغطي كل المكان', sub:'دون مناطق ضعيفة',           icon:'wifi'},
      {id:'intercom',  label:'إنتركم للباب',              sub:'ترى الزائر وترد عليه',       icon:'intercom'},
      {id:'alarm',     label:'إنذار ضد السرقة',           sub:'تنبيه فوري عند أي حركة غريبة',   icon:'bell'},
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
    const ZONE = {'صالة':'in','نوم':'in','مطبخ':'in','حمام':'in','مدخل':'in','ممر':'in','مكتب':'in','مخزن':'in','استقبال':'in','اجتماعات':'in','غرفة':'in','سلم':'in','حوش':'out','حديقة':'out','جراج':'out','موقف':'out','بلكونة':'out','ساحة':'out'};
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
          sk.rooms.push({...sk.draft, label:'غرفة', floor: sk.floor});
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
</script>

<style scoped>
.suha-page{
  /* Storefront design tokens (--bg, --surface, --ink, --primary, --primary-soft, --line,
     --radius) are inherited from app.scss; only wizard-specific roles are mapped here. */
  --muted:var(--ink-2);
  --primary-ink:var(--primary-strong);
  --rec:var(--sale);
  --out-b:#639922; --out-bg:rgba(99,153,34,.12); --out-t:#3B6D11;
  --font-display:var(--font);
  --font-body:var(--font);
  background:var(--bg);
  color:var(--ink);
  font-family:var(--font-body);
}
*{box-sizing:border-box;margin:0;padding:0;}
[v-cloak]{display:none;}
html,.suha-page{
height:100%;}
body{
  background:var(--bg);
  color:var(--ink);
  font-family:var(--font-body);
  font-size:16px;
  line-height:1.6;
  -webkit-font-smoothing:antialiased;
}
button{font-family:inherit;cursor:pointer;}
:focus-visible{outline:2px solid var(--primary);outline-offset:2px;border-radius:6px;}

.suha-page{
max-width:560px;margin:0 auto;min-height:100dvh;display:flex;flex-direction:column;}

/* ---------- header ---------- */
.top{
  padding:18px 20px 10px;
  display:flex;align-items:center;justify-content:space-between;gap:12px;
}
.brand{display:flex;align-items:center;gap:10px;}
.brand-mark{
  width:38px;height:38px;border-radius:11px;background:var(--ink);
  display:grid;place-items:center;color:#fff;flex:none;
}
.brand-name{font-family:var(--font-display);font-weight:600;font-size:17px;line-height:1.2;}
.brand-sub{font-size:12px;color:var(--muted);}

.signal{display:flex;align-items:flex-end;gap:4px;height:26px;}
.signal span{width:8px;border-radius:3px;background:var(--line);transition:background .25s ease;}
.signal span:nth-child(1){height:8px;}
.signal span:nth-child(2){height:12px;}
.signal span:nth-child(3){height:16px;}
.signal span:nth-child(4){height:20px;}
.signal span:nth-child(5){height:24px;}
.signal span.on{background:var(--primary-strong);}

.step-label{padding:0 20px 6px;font-size:13px;color:var(--muted);}

/* ---------- main ---------- */
main{flex:1;padding:8px 20px 150px;}
.q-title{font-family:var(--font-display);font-weight:600;font-size:26px;line-height:1.35;margin:10px 0 4px;}
.q-hint{color:var(--muted);font-size:14px;margin-bottom:18px;}

.grid{display:grid;grid-template-columns:1fr 1fr;gap:10px;}
.grid.one{grid-template-columns:1fr;}
.opt{
  background:var(--surface);border:1.5px solid var(--line);border-radius:var(--radius);
  padding:14px 12px;display:flex;flex-direction:column;align-items:flex-start;gap:8px;
  text-align:right;font-size:15px;font-weight:500;color:var(--ink);
  transition:border-color .15s ease, background .15s ease, transform .1s ease;
  min-height:56px;
}
.opt:active{transform:scale(.98);}
.opt .ic{color:var(--muted);transition:color .15s ease;}
.opt.sel{border-color:var(--primary);background:var(--primary-soft);}
.opt.sel .ic{color:var(--primary-ink);}
.opt .sub{font-size:12.5px;font-weight:400;color:var(--muted);}
.opt.row{flex-direction:row;align-items:center;justify-content:flex-start;min-height:52px;}

.seg-block{margin-bottom:18px;}
.seg-title{font-weight:600;font-size:15px;margin-bottom:8px;}
.seg{display:flex;gap:8px;flex-wrap:wrap;}
.seg .opt{flex:1;min-width:64px;align-items:center;text-align:center;padding:10px 8px;min-height:44px;}

.check{
  margin-inline-start:auto;width:20px;height:20px;border-radius:50%;
  border:1.5px solid var(--line);display:grid;place-items:center;flex:none;
  color:transparent;background:#fff;transition:all .15s ease;
}
.opt.sel .check{background:var(--primary-strong);border-color:var(--primary);color:var(--on-primary);}

/* ---------- packages (step 5) ---------- */
.pkg{
  background:var(--surface);border:2px solid var(--line);border-radius:var(--radius);
  padding:16px;margin-bottom:12px;width:100%;text-align:right;
  transition:border-color .15s ease, background .15s ease;position:relative;
}
.pkg.sel{border-color:var(--primary);background:var(--primary-soft);}
.pkg-head{display:flex;align-items:baseline;justify-content:space-between;gap:10px;flex-wrap:wrap;}
.pkg-name{font-family:var(--font-display);font-weight:600;font-size:17px;}
.pkg-badge{
  background:var(--ink);color:#fff;font-size:11px;border-radius:999px;
  padding:2px 10px;font-weight:600;position:absolute;top:-9px;inset-inline-start:14px;
}
.pkg-outcome{color:var(--muted);font-size:13.5px;margin:2px 0 10px;}
.pkg-price{font-family:var(--font-display);font-weight:700;font-size:19px;color:var(--primary-ink);white-space:nowrap;}
.pkg-price small{font-size:12px;font-weight:400;color:var(--muted);}
.pkg-items{list-style:none;font-size:13.5px;color:var(--ink);}
.pkg-items li{display:flex;justify-content:space-between;gap:10px;padding:5px 0;border-top:1px dashed var(--line);}
.pkg-items li span:last-child{color:var(--muted);white-space:nowrap;}
.pkg-foot{font-size:12px;color:var(--muted);margin-top:8px;}
.pkg.slim{padding:13px 16px;border-style:dashed;}
.pkg.slim .pkg-name{font-size:15px;font-weight:500;font-family:var(--font-body);}

.reco-note{font-size:12.5px;color:var(--muted);margin:4px 0 16px;line-height:1.7;}

/* ---------- live system tray ---------- */
.tray{position:fixed;bottom:76px;left:0;right:0;pointer-events:none;}
.tray-inner{max-width:560px;margin:0 auto;padding:0 20px;}
.tray-card{
  background:var(--ink);color:#fff;border-radius:12px;
  padding:9px 14px;display:flex;align-items:center;gap:10px;
  box-shadow:0 8px 24px rgba(23,36,47,.18);overflow-x:auto;
}
.tray-title{font-size:12px;color:#9DB2C0;flex:none;display:flex;align-items:center;gap:6px;}
.rec-dot{width:7px;height:7px;border-radius:50%;background:var(--rec);flex:none;animation:pulse 1.6s infinite;}
@keyframes pulse{0%,100%{opacity:1}50%{opacity:.35}}
.chip{
  background:rgba(255,255,255,.1);border:1px solid rgba(255,255,255,.16);
  border-radius:999px;padding:3px 11px;font-size:12.5px;white-space:nowrap;flex:none;
  animation:pop .25s ease;
}
@keyframes pop{from{transform:scale(.85);opacity:0}to{transform:scale(1);opacity:1}}

/* ---------- footer nav ---------- */
.nav{position:fixed;bottom:0;left:0;right:0;background:var(--surface);border-top:1px solid var(--line);z-index:99;}
@media (max-width: 991px) {
  .nav { bottom: 65px; }
}
.nav-inner{max-width:560px;margin:0 auto;padding:12px 20px;display:flex;gap:10px;align-items:center;}
.btn{border:none;border-radius:12px;font-size:16px;font-weight:600;padding:14px 18px;transition:background .15s ease, opacity .15s ease;}
.btn-primary{background:var(--primary-strong);color:var(--on-primary);flex:1;}
.btn-primary:hover{background:var(--primary-ink);}
.btn-primary:disabled{opacity:.4;cursor:not-allowed;}
.btn-ghost{background:transparent;color:var(--muted);border:1.5px solid var(--line);}
.skip{background:none;border:none;color:var(--muted);font-size:13.5px;text-decoration:underline;text-underline-offset:3px;margin-top:14px;}

/* ---------- summary & lead ---------- */
.sum-list{background:var(--surface);border:1.5px solid var(--line);border-radius:var(--radius);padding:6px 16px;margin-bottom:14px;}
.sum-row{display:flex;justify-content:space-between;gap:12px;padding:9px 0;border-bottom:1px solid var(--line);font-size:14px;}
.sum-row:last-child{border-bottom:none;}
.sum-row .k{color:var(--muted);flex:none;}
.sum-row .v{font-weight:500;text-align:left;}

.field{margin-bottom:14px;}
.field label{display:block;font-weight:600;font-size:14.5px;margin-bottom:6px;}
.field input{
  width:100%;border:1.5px solid var(--line);border-radius:12px;
  padding:13px 14px;font-size:16px;font-family:inherit;background:var(--surface);color:var(--ink);
}
.field input:focus{outline:none;border-color:var(--primary);}
.field .err{color:var(--rec);font-size:12.5px;margin-top:4px;}
.privacy{font-size:12px;color:var(--muted);margin:4px 0 10px;}

.wa{
  display:flex;align-items:center;justify-content:center;gap:8px;
  background:#fff;border:1.5px solid var(--line);color:var(--ink);
  border-radius:12px;padding:13px;font-size:15px;font-weight:600;width:100%;
  text-decoration:none;margin-top:10px;
}
.wa svg{color:#25D366;}

.h-sub{font-family:var(--font-display);font-size:17px;font-weight:600;margin:22px 0 10px;}

/* ---------- plan upload & pins (اختياري) ---------- */
.plan-box{background:var(--surface);border:1.5px dashed var(--line);border-radius:var(--radius);padding:14px;margin-bottom:16px;}
.plan-upload{
  display:block;text-align:center;border:1.5px solid var(--line);border-radius:12px;
  padding:16px;font-size:14.5px;font-weight:600;color:var(--primary-ink);cursor:pointer;
  background:var(--primary-soft);
}
.plan-tools{display:flex;gap:8px;flex-wrap:wrap;margin-bottom:10px;align-items:center;}
.tool{
  display:flex;align-items:center;gap:6px;border:1.5px solid var(--line);background:#fff;
  border-radius:999px;padding:6px 12px;font-size:13px;font-weight:600;color:var(--ink);
}
.tool svg{width:15px;height:15px;}
.tool.sel{border-color:var(--primary);background:var(--primary-soft);color:var(--primary-ink);}
.tool.danger{color:var(--rec);margin-inline-start:auto;}
.plan-stage{position:relative;border:1px solid var(--line);border-radius:10px;overflow:hidden;cursor:crosshair;}
.plan-stage img{display:block;width:100%;user-select:none;-webkit-user-drag:none;}
.pin{
  position:absolute;width:30px;height:30px;margin:-15px 0 0 -15px;border-radius:50%;
  display:grid;place-items:center;color:#fff;box-shadow:0 2px 8px rgba(0,0,0,.3);
  touch-action:none;cursor:grab;
}
.pin svg{width:14px;height:14px;}
.pin.cam{background:var(--primary-strong);}
.pin.ap{background:var(--ink);}
.pin.note{background:var(--rec);}
.pin.net{background:#2F6FED;}
.pin.tv{background:#C026D3;}
.pin.rack{background:#B7791F;}
.pin .x{
  position:absolute;top:-7px;left:-7px;width:16px;height:16px;border-radius:50%;
  background:#fff;color:var(--ink);border:1px solid var(--line);font-size:11px;line-height:1;
  display:grid;place-items:center;padding:0;
}
.plan-hint{font-size:12px;color:var(--muted);margin-top:8px;line-height:1.7;}
.live-price{
  display:flex;justify-content:space-between;align-items:center;gap:10px;
  background:var(--primary-soft);border:1px solid var(--primary);border-radius:10px;
  padding:8px 12px;font-size:13px;margin-bottom:10px;
}
.live-price b{font-family:var(--font-display);font-size:15px;color:var(--primary-ink);white-space:nowrap;}
.floor-tabs{display:flex;gap:6px;flex-wrap:wrap;margin-bottom:10px;}
.floor-tabs button{
  border:1.5px solid var(--line);background:#fff;border-radius:10px;
  padding:6px 14px;font-size:13px;font-weight:600;color:var(--muted);
}
.floor-tabs button.sel{border-color:var(--ink);background:var(--ink);color:#fff;}
.floor-tabs .cnt{font-weight:400;font-size:11.5px;opacity:.75;}

/* ---------- sketch tool: ارسم بنفسك ---------- */
.plan-tabs{display:flex;gap:8px;margin-bottom:12px;}
.plan-tabs button{
  flex:1;border:1.5px solid var(--line);background:#fff;border-radius:10px;
  padding:9px;font-size:13.5px;font-weight:600;color:var(--muted);
}
.plan-tabs button.sel{border-color:var(--primary);background:var(--primary-soft);color:var(--primary-ink);}
.sketch-stage{
  position:relative;height:380px;border:1px solid var(--line);border-radius:10px;
  touch-action:none;cursor:crosshair;overflow:hidden;background-color:#FBFCFD;
  background-image:linear-gradient(var(--line) 1px,transparent 1px),linear-gradient(90deg,var(--line) 1px,transparent 1px);
  background-size:24px 24px;
}
.sketch-empty{position:absolute;inset:0;display:grid;place-items:center;color:var(--muted);font-size:13.5px;pointer-events:none;text-align:center;padding:0 20px;}
.room{position:absolute;border:2px solid var(--primary);background:rgba(14,107,98,.08);border-radius:6px;cursor:grab;touch-action:none;}
.room.sel{border-color:var(--primary-ink);background:rgba(14,107,98,.16);box-shadow:0 0 0 2px var(--primary-soft);}
.room.draft{border-style:dashed;pointer-events:none;background:rgba(14,107,98,.05);}
.room .lbl{position:absolute;inset:0;display:grid;place-items:center;font-size:12px;font-weight:600;color:var(--primary-ink);pointer-events:none;padding:2px;overflow:hidden;}
.room .x{
  position:absolute;top:-8px;left:-8px;width:16px;height:16px;border-radius:50%;
  background:#fff;color:var(--ink);border:1px solid var(--line);font-size:11px;line-height:1;
  display:grid;place-items:center;padding:0;
}
.handle{
  position:absolute;bottom:-7px;right:-7px;width:14px;height:14px;border-radius:4px;
  background:#fff;border:2px solid var(--primary);cursor:nwse-resize;touch-action:none;
}
.room.out{border-style:dashed;border-color:var(--out-b);background:var(--out-bg);}
.room.out .lbl{color:var(--out-t);}
.room.sel{border-style:solid;}
.room.out.sel{border-color:var(--out-t);background:rgba(99,153,34,.2);}
.label-chips{display:flex;gap:6px;flex-wrap:wrap;align-items:center;margin-bottom:10px;}
.lchip{border:1.5px solid var(--line);background:#fff;border-radius:999px;padding:4px 11px;font-size:12.5px;font-weight:600;}
.lchip.out{color:var(--out-t);border-color:var(--out-b);}
.tool:disabled{opacity:.4;cursor:not-allowed;}

/* ---------- success ---------- */
.done{text-align:center;padding:48px 10px;}
.done-ic{width:64px;height:64px;border-radius:50%;background:var(--primary-soft);color:var(--primary-ink);display:grid;place-items:center;margin:0 auto 18px;}
.done h2{font-family:var(--font-display);font-size:24px;margin-bottom:8px;}
.done p{color:var(--muted);font-size:15px;max-width:34ch;margin:0 auto;}

/* ---------- transitions ---------- */
.step-enter-active,.step-leave-active{transition:opacity .18s ease, transform .18s ease;}
.step-enter-from{opacity:0;transform:translateY(14px);}
.step-leave-to{opacity:0;transform:translateY(-10px);}
@media (prefers-reduced-motion: reduce){
  *,*::before,*::after{animation:none!important;transition:none!important;}
}
@media (min-width:600px){
  #app{border-inline:1px solid var(--line);background:var(--surface);}
  main{background:var(--surface);}
}

.suha-page {
  max-width:560px;margin:0 auto;min-height:100dvh;display:flex;flex-direction:column;
  font-family: var(--font-body);
  padding-bottom: 80px;
}
@media (max-width: 991px) {
  .suha-page { padding-bottom: 145px; }
}
.sw-state{padding:48px 16px;text-align:center;display:grid;gap:12px;justify-items:center;color:var(--ink);}
.hp-field{position:absolute;inset-inline-start:-9999px;width:1px;height:1px;overflow:hidden;}
.done-estimate{font-weight:700;color:var(--primary-ink);}
</style>

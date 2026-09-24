# Build: "Know Your System" Wizard — Lead-Gen Module (Laravel + Vue)

You are working inside an EXISTING production codebase: Laravel backend + Vue frontend.
Attached alongside this prompt is `system-wizard-v10.html` — a fully working single-file
prototype (Vue 3 via CDN, RTL Arabic). **That file is the source of truth** for the UX flow,
all Arabic copy, validation rules, conditional questions, the package-building logic
(`buildPackage`, `camCounts`, `apCount`, catalog shape), and the optional floor-sketch tool
(`sk` state, `zoneType`, `classifyPin`, indoor/outdoor precedence).

If `system-wizard-v10.html` is not present in the workspace: **STOP and ask for it. Do not
reconstruct it from imagination.**

---

## 1. What we are building (business context — read carefully)

A customer-facing wizard where a NON-TECHNICAL customer describes their place and needs
(security cameras, WiFi coverage, intercom, alarm), and the system builds 3 recommendation
packages (Basic / Pro / Premium) from OUR real product catalog, then captures the lead
(name + phone).

- **This is a lead-generation tool, NOT an e-commerce checkout.** Success metric = completed
  lead submissions with full context. No cart, no payment, no account creation.
- Target market: Kuwait. UI is Arabic, RTL, mobile-first. Currency: KWD (د.ك).

### Non-negotiable product rules
1. **Never ask the customer equipment-spec questions** (megapixels, PoE, channels). Questions
   are outcome-based ("recognize faces and plates"). Specs differentiate the 3 packages, which
   map to real SKUs behind the scenes.
2. **Choosing cameras implies network infrastructure automatically** (PoE switch, cabling,
   NVR). This is an engine rule, never a customer question.
3. **Prices are "starting from ~" estimates.** Final price only after a free site survey —
   this disclaimer must stay visible. The place-condition answer (under construction /
   finishing / fully finished) multiplies installation cost (factors in prototype: 0.9 / 1.0 / 1.35).
4. **The server recomputes every estimate.** Never store or trust a total computed in the
   browser.
5. Keep ALL Arabic copy exactly as written in the prototype unless I explicitly approve changes.
6. The floor sketch is OPTIONAL for the customer and must NEVER gate submission. When the
   customer draws camera pins, the sketch classification (pin inside an indoor zone = indoor,
   inside an outdoor zone = outdoor, outside ALL zones = outdoor/perimeter) OVERRIDES the
   question-based camera heuristic — drawing beats guessing. Zone type is inferred from the
   zone label (صالة/نوم/مطبخ/حمام/مدخل/ممر = indoor; حوش/حديقة/جراج/موقف = outdoor), never
   asked as an extra question. With no sketch, fall back to the question heuristic. Implement
   this precedence in BOTH the frontend display and the server-side RecommendationService.

---

## 2. Phase 0 — Discovery & Plan (DO THIS FIRST, THEN STOP)

Before writing any feature code:

1. Explore the repo and report:
   - Vue version (2 or 3?) and build tooling (Vite / Laravel Mix), SFC conventions,
     state management in use (Pinia / Vuex / none), router setup, CSS approach
     (Tailwind / SCSS / plain), how existing pages call the API (axios instance? CSRF handling?).
   - Laravel version, existing API conventions (routes/api.php patterns, FormRequests,
     Resources), queue/mail setup, any admin panel (Nova / Filament / custom).
2. Inspect the database schema, especially any EXISTING products/inventory table:
   - List its exact columns. **Do not invent a new products table if one exists** — plan to
     extend it (nullable columns or a mapping table) instead.
3. Produce `PLAN.md` containing:
   - File tree of everything you will create/modify.
   - DB changes as migration descriptions (additive and reversible; no destructive changes).
   - Full API contract (routes, request/response JSON shapes).
   - How the prototype's CATALOG shape maps onto OUR real product columns.
   - Open questions for me (max 5, only what truly blocks you).
4. **STOP and wait for my approval of PLAN.md before Phase 1.**

If Vue turns out to be Vue 2: flag it loudly in the plan and propose the Options-API port;
do not silently write Vue 3 composition code that won't run.

---

## 3. Phase 1 — Frontend (convert prototype to real Vue)

- Page/route: `/project-wizard` (or match existing routing conventions — state choice in plan).
- Architecture: `WizardPage` + one component per step (`StepPlaceType`, `StepPlaceDetails`,
  `StepNeeds`, `StepBudget`, `StepPackages`) + shared `WizardNav`, `SystemTray` (the
  "نظامك بيتبني" chips bar) + a Pinia store or composable `useWizard()` holding all state and
  the ported computed logic (`camCounts`, `apCount`, `zoomVisible`, `canNext`, `buildPackage`).
- Sketch tool (inside step 5, optional): port the prototype's constrained 2D editor as a
  `FloorSketch` component — rectangle zones with label chips, zone type inferred from label,
  device pins with live indoor/outdoor camera counter, drag/move/resize/undo, caps (20 zones,
  30 pins), 2% grid snap, touch-first (`touch-action:none` on the stage only). Keep the
  image-upload tab as the low-friction alternative.
- Sketch data model: `{rooms:[{x,y,w,h,label,zone,floor}], pins:[{t,x,y,zone,floor}]}` in
  percentages — store JSON, never a rendered image. Build a tiny read-only renderer for the
  admin leads view (with a floor switcher when the sketch spans floors).
- Multi-floor sketching, answer-driven: available floor tabs are derived from the step-2
  floors answer and place type — 1 floor = NO tabs at all (zero added friction);
  2 floors = الأرضي/الأول; 3+ = +التاني; roof (السطح) appears for every type except apartment
  when floors ≥ 2. Rooms and pins carry a `floor` id (g/f1/f2/roof); pin zone classification
  only tests zones on the SAME floor, and a pin on a floor with no zones (e.g. an open roof)
  classifies as outdoor.
- Per-place-type vocabularies (the label chips must match the place):
  apartment = صالة/نوم/مطبخ/حمام/مدخل/ممر + بلكونة; villa & compound = same indoor +
  حوش/حديقة/جراج/موقف; shop = صالة/مخزن/مكتب/حمام/مدخل + موقف; office =
  استقبال/مكتب/اجتماعات/ممر/حمام/مخزن + موقف; warehouse = مخزن/مكتب/حمام/مدخل + ساحة/موقف.
  A سلم (staircase) chip appears only when more than one floor tab is available.
- Wiring pins (structured cabling — these PRICE): pin tools نقطة نت (net), تلفزيون (tv), and
  الكبينة (rack) alongside camera/AP/note. Net and TV points add tiered catalog line items
  (Cat5e/Cat6/Cat6A; TV/HD/4K) and each counts as an install point; the rack adds one tiered
  cabinet line item + one install point. The rack is a SINGLETON: placing it again MOVES the
  existing one instead of adding a second. The «note» pin never prices.
- Tap-through placement (critical interaction rule): in any pin mode, tapping INSIDE a zone
  places the pin at that spot — zones must not swallow the tap. Zone select/drag applies only
  in «منطقة» mode; the resize handle stays functional in all modes.
- Retention & MOI compliance: retention options are أسبوع/أسبوعين/شهر/3 شهور/6 شهور. For
  commercial place types (shop, office, warehouse): show the MOI notice under the retention
  question, DEFAULT the selection to the MOI retention (180 days) on entering step 3 — still
  freely changeable — and show a clear warning when a commercial customer selects less than
  the requirement. The retention days figure and the notice copy MUST come from
  `config/wizard.php`, and the owner must verify the current official MOI requirement per
  activity category before launch — never hardcode a legal claim. The lead payload carries a
  `commercial` boolean.
- Ready-conduits question (conditional): shown ONLY when place condition = جاهز ومتشطب —
  "في تمديدات (مواسير) جاهزة للكاميرات والشبكة؟" with أيوه موجودة / لأ / مش متأكد, required
  when visible. When the answer is أيوه, the install factor drops to 1.0 and the install line
  is renamed "تركيب عبر التمديدات الجاهزة"; لأ/مش متأكد keep the 1.35 trunking factor, and
  مش متأكد surfaces the trust line "لو التمديدات طلعت موجودة في المعاينة، السعر بينزل" (the
  estimate may only go DOWN after survey — never present it the other way). Payload carries
  `conduits` (null unless the place is fully finished).
  Fixture: the villa generator scenario with conduits=أيوه must total **832 / 1051 / 1414**
  (exactly the trunking delta below the 894/1113/1476 baseline), with the renamed install
  line; مش متأكد must match the baseline totals.
- Starter sketch generator: port `generateStarter` — a deterministic pure function that builds
  an initial layout + suggested pins from the wizard answers (place type, area, outdoor,
  entrances, floors). Offered as an explicit opt-in on the empty canvas ("جهزهالي" /
  "هرسم من الصفر"), NEVER auto-applied. For villa/compound with floors ≥ 2 it generates a
  first-floor bedroom layout AND a سلم (staircase) zone repeated at the same position on both
  floors, and distributes AP pins one per available floor. It also suggests wiring: one net
  point per sizeable indoor room (صالة/نوم/مكتب/استقبال/اجتماعات/مخزن with area ≥ threshold),
  exactly ONE TV point in the largest صالة/استقبال, and one rack (ground floor preferred).
  Invariant (amended): generated CAMERA and AP counts MUST equal the question heuristic's
  counts — the ONLY price delta allowed on generation is the suggested wiring items, which
  must appear as named, individually deletable line items and be reflected in the live price
  bar. Set `sketch_generated` on the lead payload.
- Live price feedback at the sketch: render the currently selected package's (default: pro)
  total in a bar directly above the sketch stage, updating reactively as camera/AP pins are
  added or removed — the customer must see the price move where their finger is, not
  off-screen above. Zones and "note" pins do not affect price by design.
- Port validation exactly: conditional questions (devices if wifi; recordDays + internet if
  cameras; zoom only when `zoomVisible`) and per-step `canNext` gating.
- Catalog comes from `GET /api/wizard-catalog` at mount (loading + error states). The
  hardcoded CATALOG in the prototype is placeholder data — delete it in the real build.
- Frontend package totals are display-only estimates.
- Fire analytics on every step view/completion: use the project's existing analytics if any,
  otherwise `POST /api/wizard-events {session_id, step, action}`. This is required, not
  optional — drop-off measurement is how we evaluate this module. Also fire
  `sketch_started`, `sketch_completed`, `sketch_generated`, and `plan_uploaded` — these
  numbers gate the deferred 3D phase below.
- Match the prototype's look (design tokens are in its `<style>` block) but adapt to the
  project's CSS system. RTL and mobile-first are mandatory; test at 380px width.

## 4. Phase 2 — Backend (Laravel)

**`GET /api/wizard-catalog`**
- Returns active products mapped to the wizard schema:
  `{camera:{basic:{in,out,gbDay},...}, ptz, nvr, hdd, poeSwitch, ap, intercom, alarm,
  router4g, netPoint, tvPoint, rack, installPerPoint}`
  (see prototype CATALOG for exact shape).
- Source: our real products table per the approved plan. Cache ~10 minutes.
- If a needed product is inactive/out of stock, fall back to the nearest same-category
  product in the same tier; if none, degrade gracefully (omit line, flag in response).

**`POST /api/project-leads`**
- FormRequest validation (name min 2, phone `^\d{8,12}$` after stripping spaces/dashes,
  answers payload shape per prototype `payload()`).
- Spam protection: hidden honeypot field + `throttle` rate limiting + reject if honeypot filled.
- Server-side `RecommendationService`: a 1:1 port of the prototype's `buildPackage` reading
  prices from the DB. Recompute the chosen package's BOM + estimate and store THAT, ignoring
  any client-sent totals. Apply the sketch-over-questions precedence from product rule 6,
  including point-in-zone classification of camera pins (outdoor pins map to outdoor SKUs,
  AP pin count overrides the AP heuristic). HDD sizing must support long retention: when the
  required TB exceeds the largest available surveillance drive, use multiple drives
  (`qty = ceil(neededTB / largestDrive)`) — never silently cap to a drive smaller than the
  promised retention.
- Persist to `project_leads` migration: `name, phone, answers (json), package_tier,
  estimate, bom (json), status enum(new, contacted, surveyed, quoted, won, lost) default new,
  timestamps`.
- Notify on new lead: mail notification using existing mail setup (queueable). Include a
  ready WhatsApp deep-link with the lead summary in the notification body.

**`POST /api/wizard-events`** — lightweight step analytics table
(`session_id, step, action, created_at`). No auth, rate-limited.

**Config:** WhatsApp number, install price per point, condition factors, and GB/day per tier
go in `config/wizard.php` (values overridable via `.env`). No magic numbers in code.

**Admin:** minimal leads index (list, filter by status, view answers/BOM) inside the existing
admin panel if one exists; otherwise a simple protected Blade/Vue page. State approach in plan.

## 5. Phase 3 — Tests & hardening

- Feature tests: lead happy path, validation failures, honeypot rejection, rate limiting,
  catalog endpoint shape.
- **Parity unit test** for `RecommendationService` using this fixture (with the prototype's
  placeholder prices seeded): villa, area 250–500m², 2 floors, 2 entrances, outdoor=yes,
  condition=fully finished, goals=[entry, indoor, perimeter, wifi, intercom], devices=10–25,
  recording=30 days, internet=no, zoom=yes →
  expected: 5 indoor cams, 6 outdoor cams, 1 PTZ, NVR 16ch, PoE switch 24-port, 3 APs,
  intercom, 4G router, and totals **788 / 984 / 1315 KWD** for basic/pro/premium (premium
  carries a 16TB drive — 12 × 4K cameras × 30 days needs 12.6TB).
  If your port doesn't reproduce these numbers, your port is wrong — fix it, don't adjust
  the fixture.
- **Classification fixture**: zones `صالة (indoor) at 6,8,44,30` and `حوش (outdoor) at
  6,62,56,32`, with camera pins at (20,20), (14,74), and (96,50) → must classify as indoor,
  outdoor, outdoor (the last is outside all zones = perimeter). `camCounts` must return
  `{indoor:1, outdoor:2}` and ignore the question heuristic entirely while sketch cams exist.
- **Generator fixture**: villa + 250–500m² + 2 floors + 2 entrances + outdoor + goals
  [entry, indoor, perimeter, wifi, intercom] + internet=no + zoom=yes must deterministically
  produce: ground floor صالة/سلم/نوم/مطبخ/حمام/نوم/حوش/جراج, first floor سلم/نوم/نوم/حمام/ممر,
  floor tabs الأرضي/الأول/السطح, 11 camera pins all on the ground floor (5 indoor, 6 outdoor),
  3 AP pins on floors g/f1/f1, wiring suggestions of 4 net points + 1 TV + 1 rack (rack on the
  ground floor), and package totals of **788 / 984 / 1315 BEFORE** generation and
  **894 / 1113 / 1476 AFTER** (prototype placeholder prices) — the entire delta must be
  attributable to the named wiring line items. (Note: premium includes a 16TB drive; the
  earlier 12TB figure came from a sizing bug that capped storage below the promised
  retention — do not reproduce it.) Any other movement is a failed build.
- **Commercial retention fixture**: shop + 100–250m² + 1 floor + 1 entrance + no outdoor +
  finishing condition + goals [entry, indoor] + internet=yes: entering step 3 must
  auto-preselect 6 شهور with the MOI notice visible; HDD lines must be basic 12TB ×1,
  pro 16TB ×2, prem 16TB ×2, with totals **306 / 533 / 616**. Selecting شهر instead must
  surface the under-requirement warning.
- **Tap-through behavior test**: with a zone drawn and camera mode active, a tap inside the
  zone must add a camera pin at the tap point (and classify by that zone); it must NOT select
  or drag the zone.
- Manual QA checklist in PR description: mobile RTL rendering, back navigation preserves
  answers, conditional questions appear/disappear correctly, out-of-stock fallback.

## 6. Deferred scope — documented, NOT built in v1

- **3D preview of the sketch** (read-only): extrude the same sketch JSON with three.js —
  indoor zones get full-height walls, outdoor zones get low fences, cameras get coverage
  cones. Loaded lazily ONLY on tap of a "شوفه 3D" button, behind a feature flag, and enabled
  only after launch metrics show healthy `sketch_completed` rates. A working reference
  implementation ships inside the prototype behind that exact button (lazy script injection,
  live rebuild on sketch change, floors stacked vertically) — treat it as the spec for this
  phase, and do NOT port it in v1 even though the code is sitting right there.
- **3D editing of any kind** (drawing/moving objects inside the 3D scene, furniture,
  walkthroughs): permanently out of scope. If ever wanted, it gets bought or embedded,
  never built in-house.

## 7. Working rules

- Work on a feature branch. Small, reviewable commits per phase.
- Follow the existing code style and conventions everywhere; introduce no new major
  dependency without listing it in PLAN.md with justification.
- Touch nothing unrelated to this feature.
- Migrations must be additive and reversible; ask before anything destructive.
- When genuinely blocked, ask one focused question instead of guessing.

## 8. Definition of done

- [ ] PLAN.md approved before feature code
- [ ] Wizard live at its route, matching prototype flow/copy, RTL mobile-first
- [ ] Catalog served from real products table; prototype's hardcoded CATALOG removed
- [ ] Leads stored with server-recomputed BOM + estimate; notification fires
- [ ] Sketch tool live in step 5 (optional, never blocking), storing zone- and
      floor-classified JSON; answer-driven floor tabs; per-type vocabularies; admin can view
      the rendered sketch per floor on the lead
- [ ] Honeypot + rate limiting active; step + sketch_started/sketch_completed/plan_uploaded
      events recording
- [ ] Parity, classification, and feature tests green
- [ ] README section: how to configure `config/wizard.php` and map products

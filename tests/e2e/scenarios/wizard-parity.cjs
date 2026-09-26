// Port of scratchpad wizard.cjs: full wizard run; the browser-shown package price must equal the server estimate.
const path = require('path');
const { newContext, instrument } = require('../lib/browser.cjs');

async function run({ browser, base, prefixes, report, outDir }) {
  const prefix = prefixes.ar ?? '';
  const ctx = await newContext(browser, { viewport: 'mobile', locale: 'ar', blockExternalFor: base });
  const p = await ctx.newPage();
  const col = instrument(p);
  let leadResponse = null;
  let leadJson = null;
  p.on('response', async (r) => { if (r.url().includes('project-leads')) { try { const full = await r.text(); leadResponse = { status: r.status(), body: full.slice(0, 600) }; try { leadJson = JSON.parse(full); } catch {} } catch {} } });
  try {
    await p.goto(`${base}${prefix}/project-wizard`, { waitUntil: 'networkidle', timeout: 60000 });
    await p.waitForTimeout(1000);
    const click = async (t) => { await p.getByRole('button', { name: t, exact: true }).first().click(); await p.waitForTimeout(150); };
    const next = async () => { await p.locator('.nav .btn-primary').click(); await p.waitForTimeout(400); };
    await click('فيلا / بيت'); await next();
    await click('100–250م²'); await click('طابقان'); await click('2');
    await p.locator('.seg-block').nth(3).getByRole('button', { name: 'نعم', exact: true }).click();
    await click('في مرحلة التشطيب');
    await next();
    await p.getByRole('button', { name: /مراقبة المداخل/ }).click();
    await p.getByRole('button', { name: /واي فاي قوي/ }).click();
    await click('10–25'); await click('شهر');
    await p.locator('.seg-block', { hasText: 'إنترنت ثابت' }).getByRole('button', { name: 'نعم', exact: true }).click();
    const zoom = p.locator('.seg-block', { hasText: 'تقريب الصورة' });
    if (await zoom.count()) await zoom.getByRole('button', { name: 'لا', exact: true }).click();
    await next(); await next();
    const pkg = p.locator('.pkg').filter({ hasText: 'الباقة الاحترافية' }).first();
    await pkg.click();
    const shown = (await pkg.locator('.pkg-price').innerText()).replace(/[^\d.]/g, '');
    await p.fill('#name', 'عميل تجريبي'); await p.fill('#phone', '55512345');
    await p.screenshot({ path: path.join(outDir, 'screenshots', 'wizard·summary.png'), fullPage: true }).catch(() => {});
    await next(); await p.waitForTimeout(2000);
    await p.screenshot({ path: path.join(outDir, 'screenshots', 'wizard·done.png') }).catch(() => {});
    const j = leadJson || {};
    const serverPrice = String(j.data?.estimate ?? j.estimate ?? j.data?.price ?? '').replace(/[^\d.]/g, '');
    const ok = leadResponse && leadResponse.status < 400 && serverPrice && Number(serverPrice) === Number(shown);
    report.visit({ tag: 'wizard-parity', shown, serverPrice, lead: leadResponse?.status });
    if (!leadResponse || leadResponse.status >= 400) report.add({ id: 'WIZARD-LEAD-FAILED', severity: 'high', category: 'wizard', url: `${prefix}/ajax/vue/project-leads`, method: 'POST', evidence: { leadResponse } });
    else if (!ok) report.add({ id: 'WIZARD-PRICE-MISMATCH', severity: 'high', category: 'wizard', evidence: { shown, serverPrice, body: leadResponse.body.slice(0, 300) }, recommendation: 'Browser total must equal RecommendationService estimate.' });
    if (col.pageErrors.length) report.add({ id: 'WIZARD-PAGE-ERROR', severity: 'medium', category: 'js', evidence: { errors: col.pageErrors.slice(0, 3) } });
  } catch (e) {
    report.add({ id: 'WIZARD-FLOW-BROKEN', severity: 'high', category: 'wizard', evidence: { error: e.message.slice(0, 300), url: p.url() } });
  }
  await ctx.close();
}

module.exports = { run };

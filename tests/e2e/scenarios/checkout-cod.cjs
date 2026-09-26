// Full guest-free checkout as customer_1: add product → checkout → Kuwait address → COD → thank-you. Records order id for IDOR.
const path = require('path');
const { newContext, instrument } = require('../lib/browser.cjs');
const { login } = require('../lib/session.cjs');
const { rawKeys } = require('../lib/assertions.cjs');

async function run(ctx) {
  const { browser, base, prefixes, report, accounts, outDir, db } = ctx;
  const prefix = prefixes.ar ?? '';
  const bctx = await newContext(browser, { viewport: 'mobile', locale: 'ar', blockExternalFor: base });
  const page = await bctx.newPage();
  page.setDefaultTimeout(10000); // headless checkout automation is best-effort; don't hang 30s on a control
  const col = instrument(page);
  const r = await login(page, base, accounts.customer1, prefix);
  if (!r.ok) { report.add({ id: 'CHECKOUT-LOGIN-FAILED', severity: 'high', category: 'auth', evidence: { status: r.loginStatus } }); await bctx.close(); return; }

  // Add via the theme API (same call the SPA makes)
  const prodRes = await page.request.get(`${base}${prefix}/ajax/vue/products/${accounts.simpleProductSlug}`);
  const prod = prodRes.ok() ? (await prodRes.json()) : null;
  const productId = prod?.data?.id ?? prod?.id;
  if (!productId) { report.add({ id: 'CHECKOUT-PRODUCT-LOOKUP', severity: 'medium', category: 'shop', url: `${prefix}/ajax/vue/products/${accounts.simpleProductSlug}` }); await bctx.close(); return; }
  await page.goto(`${base}${prefix}/cart`, { waitUntil: 'networkidle' });
  const token = await page.evaluate(() => document.querySelector('meta[name="csrf-token"]')?.content || '');
  const add = await page.request.post(`${base}${prefix}/ajax/vue/cart/add`, { form: { id: productId, qty: 1, _token: token }, headers: { Accept: 'application/json', 'X-Requested-With': 'XMLHttpRequest' } });
  if (!add.ok()) report.add({ id: 'CHECKOUT-CART-ADD', severity: 'high', category: 'shop', url: `${prefix}/ajax/vue/cart/add`, method: 'POST', evidence: { status: add.status(), body: (await add.text()).slice(0, 200) } });

  // Checkout URL is exposed by the layout
  await page.goto(`${base}${prefix}/cart`, { waitUntil: 'networkidle' });
  const checkoutUrl = await page.evaluate(() => (window.BotbleData && window.BotbleData.checkoutUrl) || '');
  if (!checkoutUrl) { report.add({ id: 'CHECKOUT-URL-MISSING', severity: 'high', category: 'shop', url: `${prefix}/cart` }); await bctx.close(); return; }
  await page.goto(checkoutUrl, { waitUntil: 'networkidle', timeout: 60000 });
  await page.screenshot({ path: path.join(outDir, 'screenshots', 'checkout·1.png'), fullPage: true }).catch(() => {});
  const text1 = await page.evaluate(() => document.body.innerText || '');
  const rk1 = rawKeys(text1);
  if (rk1.length) report.add({ id: 'RAW-KEY-checkout', severity: 'low', category: 'i18n', url: checkoutUrl, evidence: { keys: rk1.slice(0, 10) } });

  // Fill address (fields per Botble checkout form)
  const fill = async (sel, val) => { const l = page.locator(sel).first(); if (await l.count()) await l.fill(val).catch(() => {}); };
  await fill('input[name="address[name]"]', 'E2E Buyer');
  await fill('input[name="address[email]"]', accounts.customer1.email);
  await fill('input[name="address[phone]"]', '55512345');
  await fill('input[name="address[address]"]', 'Block 1, Street 2, House 3');
  await fill('input[name="address[city]"]', 'Kuwait City');
  await fill('input[name="address[zip_code]"]', '00000');
  const country = page.locator('select[name="address[country]"]').first();
  if (await country.count()) await country.selectOption('KW').catch(() => {});
  const state = page.locator('select[name="address[state]"], input[name="address[state]"]').first();
  if (await state.count()) { try { await state.selectOption({ index: 1 }); } catch { await state.fill('Al Asimah').catch(() => {}); } }
  await page.waitForTimeout(1500);

  // COD
  const cod = page.locator('input[name="payment_method"][value="cod"]').first();
  if (!(await cod.count())) report.add({ id: 'CHECKOUT-NO-COD', severity: 'medium', category: 'shop', url: checkoutUrl, recommendation: 'COD payment method not offered at checkout.' });
  else await cod.check({ force: true }).catch(() => {});
  // Every configured method radio should render
  const methods = await page.locator('input[name="payment_method"]').evaluateAll((els) => els.map((e) => e.value));
  report.visit({ tag: 'checkout-methods', methods });
  await page.screenshot({ path: path.join(outDir, 'screenshots', 'checkout·2.png'), fullPage: true }).catch(() => {});

  const place = page.locator('button.payment-checkout-btn, button[type="submit"]:has-text("إتمام"), button[type="submit"]:has-text("Place"), #checkout-form button[type="submit"]').first();
  if (!(await place.count())) { report.add({ id: 'CHECKOUT-NO-PLACE-ORDER', severity: 'high', category: 'shop', url: checkoutUrl }); await bctx.close(); return; }
  await place.click();
  await page.waitForLoadState('networkidle', { timeout: 60000 }).catch(() => {});
  await page.waitForTimeout(1500);
  const finalUrl = page.url();
  const text2 = await page.evaluate(() => document.body.innerText || '');
  await page.screenshot({ path: path.join(outDir, 'screenshots', 'checkout·3-thankyou.png'), fullPage: true }).catch(() => {});
  const success = /success/.test(finalUrl) || /شكر|Thank/i.test(text2);
  if (!success) report.add({ id: 'CHECKOUT-NOT-COMPLETED', severity: 'high', category: 'shop', url: finalUrl, evidence: { text: text2.slice(0, 300), serverErrors: col.serverErrors.slice(0, 3) } });
  const rk2 = rawKeys(text2);
  if (rk2.length) report.add({ id: 'RAW-KEY-thank-you', severity: 'low', category: 'i18n', url: finalUrl, evidence: { keys: rk2.slice(0, 10) }, recommendation: 'Thank-you page renders raw order.checkout.* keys (see i18n plan A2).' });
  // Help/contact block on thank-you (Tier 1.10)
  if (success && !/تواصل|اتصل|Contact|Help|مساعدة/i.test(text2)) report.add({ id: 'THANKYOU-NO-HELP-BLOCK', severity: 'info', category: 'ux', url: finalUrl });

  const orders = db.orderIds(accounts.customer1.email);
  ctx.customer1OrderId = orders.length ? Math.max(...orders) : null;
  report.visit({ tag: 'checkout-cod', finalUrl, orderId: ctx.customer1OrderId });
  await bctx.close();
}

module.exports = { run };

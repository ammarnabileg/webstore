// Reflected/stored XSS canary probe: a canary in user-controlled inputs must never execute or land unescaped.
const canaries = require('../../config/canaries.json');
const { newContext } = require('../../lib/browser.cjs');

async function run({ browser, report, url, base, prefix, accounts }) {
  const ctx = await newContext(browser, { viewport: 'mobile', locale: 'ar' });
  const page = await ctx.newPage();
  let executed = false;
  page.on('dialog', async (d) => { executed = true; await d.dismiss().catch(() => {}); });
  await page.exposeFunction('__xssHit', () => { executed = true; }).catch(() => {});

  const spots = [
    ['SEARCH-Q', (c) => `/search?q=${encodeURIComponent(c)}`],
    ['PRODUCTS-CATEGORY', (c) => `/products?category=${encodeURIComponent(c)}`],
    ['PRODUCT-TAG', (c) => `/product-tags/${encodeURIComponent(c)}`],
    ['LOGIN-STEP', (c) => `/login?step=${encodeURIComponent(c)}`],
  ];

  for (const [id, make] of spots) {
    for (const payload of canaries.xss) {
      executed = false;
      const target = `${base}${prefix}${make(payload)}`;
      try {
        await page.goto(target, { waitUntil: 'networkidle', timeout: 30000 });
        await page.waitForTimeout(600);
      } catch { /* navigation errors are not XSS */ }
      const flagged = await page.evaluate(() => !!window.__xss).catch(() => false);
      // Raw, unescaped canary in the live DOM (outside attribute-encoded contexts) is a strong signal.
      const rawInDom = await page.evaluate((p) => document.documentElement.innerHTML.includes(p), payload).catch(() => false);
      if (executed || flagged) {
        report.add({ id: `XSS-EXEC-${id}`, severity: 'critical', category: 'xss', url: make(payload), evidence: { payload }, recommendation: 'Escape/sanitize reflected input; never render raw.' });
        break;
      }
      if (rawInDom) {
        report.add({ id: `XSS-REFLECT-${id}`, severity: 'high', category: 'xss', url: make(payload), evidence: { payload }, recommendation: 'Canary reflected unescaped; verify output encoding.' });
        break;
      }
    }
  }

  // Confirm stored product content is sanitized (the E2E variable product description is plain; check the API output too).
  const api = await page.request.get(url(`/ajax/vue/products/${accounts.variableProductSlug}`)).then((r) => (r.ok() ? r.text() : '')).catch(() => '');
  if (/<script>window\.__xss/i.test(api)) report.add({ id: 'XSS-STORED-PRODUCT', severity: 'critical', category: 'xss', url: `/ajax/vue/products/${accounts.variableProductSlug}`, recommendation: 'Product description must pass through BaseHelper::clean.' });

  await ctx.close();
}

module.exports = { run };

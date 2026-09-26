// Exercise every interactive control (mobile, ar) as guest and customer. Missing selectors are reported as info so drift is visible.
const path = require('path');
const { newContext, instrument } = require('../lib/browser.cjs');
const { login } = require('../lib/session.cjs');

async function run({ browser, base, prefixes, report, accounts, outDir }) {
  const prefix = prefixes.ar ?? '';
  for (const who of ['guest', 'customer']) {
    const ctx = await newContext(browser, { viewport: 'mobile', locale: 'ar', blockExternalFor: base });
    const page = await ctx.newPage();
    page.setDefaultTimeout(6000); // interaction timeouts are harness-sensitive; fail fast, don't hang 30s
    const col = instrument(page);
    if (who === 'customer') await login(page, base, accounts.customer1, prefix);
    const go = async (p) => { await page.goto(`${base}${prefix}${p}`, { waitUntil: 'domcontentloaded', timeout: 30000 }); await page.waitForTimeout(800); };
    const shot = (n) => page.screenshot({ path: path.join(outDir, 'screenshots', `action·${n}·${who}.png`) }).catch(() => {});
    const step = async (id, sel, fn, { optional = false } = {}) => {
      const loc = page.locator(sel).first();
      if (!(await loc.count())) { if (!optional) report.add({ id: `ACTION-MISSING-${id}`, severity: 'info', category: 'ux', url: page.url(), evidence: { selector: sel } }); return false; }
      const pe = col.pageErrors.length, se = col.serverErrors.length;
      try { await fn(loc); await page.waitForTimeout(700); }
      catch (e) { report.add({ id: `ACTION-FAIL-${id}-${who}`, severity: 'low', category: 'ux', url: page.url(), step: id, evidence: { error: e.message.slice(0, 200) } }); return false; }
      if (col.pageErrors.length > pe) report.add({ id: `ACTION-JSERR-${id}-${who}`, severity: 'medium', category: 'js', url: page.url(), step: id, evidence: { errors: col.pageErrors.slice(pe, pe + 3) } });
      if (col.serverErrors.length > se) report.add({ id: `ACTION-5XX-${id}-${who}`, severity: 'high', category: 'server', url: page.url(), step: id, evidence: { responses: col.serverErrors.slice(se, se + 3) } });
      return true;
    };
    const cartCount = async () => { const r = await page.request.get(`${base}${prefix}/ajax/vue/cart`); if (!r.ok()) return -1; const j = await r.json(); const d = j.data || j; return (d.items || d.cart_items || d.products || []).length ?? d.count ?? -1; };

    // Product detail: qty, add to cart, wishlist, quick specs, related
    await go(`/product/${accounts.simpleProductSlug}`);
    await step('qty-plus', '.qty-selector button:last-child', (l) => l.click());
    // qty must not exceed 100 / stock (Tier 1.5). Click + 5 times and read the value.
    for (let i = 0; i < 5; i++) await page.locator('.qty-selector button:last-child').first().click().catch(() => {});
    const qtyVal = await page.locator('.qty-selector input, .qty-selector span, .qty-selector .qty').first().innerText().catch(() => '');
    await step('add-to-cart', '.btn-add-cart', (l) => l.click());
    const after = await cartCount();
    if (after === 0) report.add({ id: `CART-ADD-NOOP-${who}`, severity: 'low', category: 'shop', url: page.url(), evidence: { qtyShown: qtyVal }, recommendation: 'Add to cart produced no cart item.' });
    await step('wishlist-toggle', '.wishlist-btn, .action-btn', (l) => l.click());
    await shot('product');

    // Cart: qty +/-, remove, checkout button present
    await go('/cart');
    await step('cart-qty-plus', '.qty-btn:last-child', (l) => l.click());
    await step('cart-qty-minus', '.qty-btn:first-child', (l) => l.click());
    await step('cart-checkout-present', '.checkout-btn', async () => {});
    await shot('cart');
    await step('cart-remove', '.ci-remove', (l) => l.click());

    // Listing: filters + load more + grid toggle
    await go('/products');
    await step('filter-open', '.filter-btn', (l) => l.click());
    await step('filter-pick', '.filter-label', (l) => l.click(), { optional: true });
    await step('filter-apply', 'button:has-text("تطبيق"), .apply-btn, .filter-apply', (l) => l.click(), { optional: true });
    await step('load-more', 'button:has-text("المزيد"), .load-more', (l) => l.click(), { optional: true });
    await shot('products');

    // Search page + live search in header
    await go('/search?q=cam');
    await step('search-input', 'input[type="search"], .search-input, input[placeholder]', (l) => l.fill('e2e'));
    await step('search-clear', '.clear-btn', (l) => l.click(), { optional: true });
    await go('/');
    await step('live-search', '.dh-search input, .dh-search', async (l) => { await l.click(); await page.keyboard.type('cam'); await page.waitForTimeout(900); }, { optional: true });
    await step('dark-toggle', '.dh-dark-btn, .theme-toggle', (l) => l.click(), { optional: true });
    await shot('home-dark');

    // Quick view
    await go('/products');
    await step('quick-view', '.quick-view, .action-btn.quick, button[aria-label*="عرض"]', (l) => l.click(), { optional: true });

    // Tab bar navigation must exist on SPA pages
    await go('/');
    await step('tabbar', '.tabbar', async (l) => { const n = await page.locator('.tabbar a').count(); if (n < 4) throw new Error(`tabbar has ${n} links`); });

    // Profile hub
    await go('/profile');
    const plCount = await page.locator('.pl-item').count();
    report.visit({ tag: `profile-links·${who}`, count: plCount });
    if (who === 'customer' && plCount < 5) report.add({ id: 'PROFILE-LINKS-SPARSE', severity: 'low', category: 'ux', url: page.url(), evidence: { links: plCount }, recommendation: 'Expose addresses, password, returns, downloads, reviews, tracking, delete-account (Tier 1.8).' });
    // Logout must not be a plain GET link (CSRF logout)
    const logoutGet = await page.locator('a[href$="/logout"]').count();
    if (logoutGet) report.add({ id: 'LOGOUT-IS-GET-LINK', severity: 'medium', category: 'security', url: page.url(), evidence: { anchors: logoutGet }, recommendation: 'Post a form with CSRF token; reject cross-site GET on the logout route (Tier 1.6).' });
    await shot('profile');

    // Auth negative flows (guest only)
    if (who === 'guest') {
      await go('/login');
      await step('login-bad', 'form input[type="email"], input[name="email"]', async (l) => {
        await l.fill('nobody@example.com');
        await page.locator('input[type="password"], input[name="password"]').first().fill('wrong-pass');
        await page.locator('button[type="submit"]').first().click();
        await page.waitForTimeout(1500);
      }, { optional: true });
      const stillGuest = (await page.request.get(`${base}${prefix}/customer/overview`, { maxRedirects: 0 })).status() !== 200;
      if (!stillGuest) report.add({ id: 'LOGIN-BAD-CREDS-ACCEPTED', severity: 'critical', category: 'auth', url: page.url() });
      await step('wa-bad-phone', 'input[name="wa_phone"], input#wa_phone', async (l) => { await l.fill('123'); await page.locator('button:has-text("إرسال"), button[type="submit"]').first().click(); await page.waitForTimeout(800); }, { optional: true });
      // Forgot-password link should exist on the login screen (Tier 1.7)
      const forgot = await page.locator('a[href*="password/reset"], a:has-text("نسيت")').count();
      if (!forgot) report.add({ id: 'NO-FORGOT-PASSWORD-LINK', severity: 'low', category: 'ux', url: page.url(), recommendation: 'Link to /password/reset from the login step (Tier 1.7).' });
      await shot('login');
    }

    // Notifications tabs
    await go('/notifications');
    await step('notif-tab', '.tabs button, .tab', (l) => l.click(), { optional: true });

    await ctx.close();
  }
}

module.exports = { run };

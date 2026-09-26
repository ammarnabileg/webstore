// Auth-gate probe: guest must be bounced from customer pages; a locked customer must be denied.
async function run({ guest, report, url, db, accounts, base, prefix, browser }) {
  const { newContext } = require('../../lib/browser.cjs');
  const { login } = require('../../lib/session.cjs');

  const customerPages = ['/customer/overview', '/customer/edit-account', '/customer/address', '/customer/orders', '/customer/downloads', '/customer/order-returns'];

  // 1. Guest → customer pages: HTML should 302 to login; JSON should be 401/403.
  for (const p of customerPages) {
    const html = await guest.page.request.get(url(p), { maxRedirects: 0 }).catch(() => ({ status: () => -1, headers: () => ({}) }));
    const loc = (html.headers?.() || {}).location || '';
    const okHtml = html.status() === 302 || html.status() === 301 || /login|تسجيل/i.test(loc) || html.status() === 401 || html.status() === 403;
    if (!okHtml && html.status() === 200) report.add({ id: `AUTHGATE-GUEST-${p.split('/').pop().toUpperCase()}`, severity: 'high', category: 'auth', url: p, evidence: { status: html.status(), location: loc }, recommendation: 'Require an authenticated customer.' });
    const json = await guest.page.request.get(url(p), { headers: { Accept: 'application/json', 'X-Requested-With': 'XMLHttpRequest' }, maxRedirects: 0 }).catch(() => ({ status: () => -1 }));
    if (json.status() === 200) report.add({ id: `AUTHGATE-GUEST-JSON-${p.split('/').pop().toUpperCase()}`, severity: 'medium', category: 'auth', url: p, evidence: { status: 200 } });
  }

  // 2. Locked customer: flip status, try to reach the dashboard, expect logout+redirect.
  db.setCustomerStatus(accounts.customer1.email, 'locked');
  try {
    const c = await newContext(browser, { viewport: 'mobile', locale: 'ar' });
    const page = await c.newPage();
    const r = await login(page, base, accounts.customer1, prefix);
    // Either login refuses, or the dashboard bounces a locked session.
    const overview = await page.request.get(url('/customer/overview'), { maxRedirects: 0 }).catch(() => ({ status: () => -1 }));
    const denied = !r.ok || overview.status() !== 200;
    if (!denied) report.add({ id: 'AUTHGATE-LOCKED-CUSTOMER', severity: 'high', category: 'auth', url: '/customer/overview', evidence: { loginOk: r.ok, overview: overview.status() }, recommendation: 'A locked (non-activated) customer must not reach the dashboard.' });
    await c.close();
  } finally {
    db.setCustomerStatus(accounts.customer1.email, 'activated');
  }
}

module.exports = { run };

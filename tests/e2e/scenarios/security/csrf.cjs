// CSRF regression probe (defensive): state-changing endpoints on the owner's own store must require a valid
// same-origin token. We confirm the server REJECTS token-less and foreign-origin writes (expected 419/4xx).
const AJAX = { Accept: 'application/json', 'X-Requested-With': 'XMLHttpRequest' };
const FOREIGN = { Origin: 'https://foreign.test', Referer: 'https://foreign.test/', 'Sec-Fetch-Site': 'cross-site' };

// Botble rejects CSRF/expired-token writes with HTTP 200 + {"error":true,"message":"session expired"},
// not a 419. A write is only "accepted" on a 2xx whose JSON is not an error envelope.
async function accepted(res) {
  const s = res.status();
  if (s < 200 || s >= 300) return false;
  const body = await res.text().catch(() => '');
  try { const j = JSON.parse(body); if (j.error === true || j.success === false) return false; } catch {}
  if (/انتهت صلاحية|صلاحية الجلسة|غير مصرح|token|csrf|expired|unauthorized|mismatch/i.test(body)) return false;
  return true;
}

async function run({ victim, report, url, accounts }) {
  const { page } = victim;

  const cartCount = async () => {
    const r = await page.request.get(url('/ajax/vue/cart'));
    if (!r.ok()) return -1;
    const j = await r.json();
    const d = j.data || j;
    return (d.items || d.cart_items || d.products || []).length;
  };

  const prod = await page.request.get(url(`/ajax/vue/products/${accounts.simpleProductSlug}`)).then((r) => (r.ok() ? r.json() : null)).catch(() => null);
  const pid = prod?.data?.id ?? prod?.id;

  // Writes that must be token-protected. Each is replayed WITHOUT a token, then with a foreign Origin/Referer.
  const writes = [
    ['CART-ADD', '/ajax/vue/cart/add', { id: pid, qty: 1 }, true],
    ['COUPON-APPLY', '/coupon/apply', { coupon_code: accounts.coupon }, false],
    ['EDIT-ACCOUNT', '/customer/edit-account', { name: 'E2E Customer 1', email: accounts.customer1.email }, false],
    ['ADDRESS-CREATE', '/customer/address/create', { name: 'X', phone: '55512345', email: accounts.customer1.email, country: 'KW', state: 'A', city: 'K', address: 'a', zip_code: '0' }, false],
  ];

  for (const [id, endpoint, form, cartSensitive] of writes) {
    const before = cartSensitive ? await cartCount() : null;
    const variants = [
      ['NOTOKEN', AJAX],
      ['FOREIGN-ORIGIN', { ...AJAX, ...FOREIGN }],
    ];
    for (const [variant, headers] of variants) {
      const res = await page.request.post(url(endpoint), { form, headers, maxRedirects: 0 }).catch(() => ({ status: () => -1, text: async () => '' }));
      const ok = await accepted(res);
      const changed = cartSensitive ? (await cartCount()) > before : ok;
      // Only a genuinely accepted write (2xx, non-error envelope) — or a real cart state change — is a finding.
      if (ok || changed) {
        report.add({
          id: `CSRF-${variant}-${id}`,
          severity: 'high',
          category: 'csrf',
          url: endpoint,
          method: 'POST',
          evidence: { status: res.status(), stateChanged: changed },
          recommendation: 'Reject token-less / cross-origin writes.',
        });
      }
    }
  }

  // State-changing GET routes (logout, cart remove/destroy) should not act on a cross-site GET.
  const stateGets = [
    ['LOGOUT', '/logout'],
    ['CART-DESTROY', '/cart/destroy'],
  ];
  for (const [id, endpoint] of stateGets) {
    const res = await page.request.get(url(endpoint), { headers: FOREIGN, maxRedirects: 0 }).catch(() => ({ status: () => -1 }));
    const acted = res.status() >= 200 && res.status() < 400 && !/login/i.test(res.headers?.().location || '');
    // Still logged in after a cross-site logout GET means the guard worked.
    const stillIn = (await page.request.get(url('/customer/overview'), { maxRedirects: 0 })).status() === 200;
    if (id === 'LOGOUT' && !stillIn) {
      report.add({ id: 'CSRF-GET-LOGOUT', severity: 'medium', category: 'csrf', url: endpoint, method: 'GET', evidence: { status: res.status() }, recommendation: 'Reject cross-site GET on logout (Sec-Fetch-Site/Referer check) and prefer POST + token.' });
    } else if (id !== 'LOGOUT' && acted) {
      report.add({ id: `CSRF-GET-${id}`, severity: 'medium', category: 'csrf', url: endpoint, method: 'GET', evidence: { status: res.status() }, recommendation: 'Reject cross-site GET on state-changing routes.' });
    }
  }
}

module.exports = { run };

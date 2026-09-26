// Rate-limit probe: OTP, login, coupon should throttle; cart-add is informational.
async function run({ guest, victim, report, url, accounts }) {
  const H = { Accept: 'application/json', 'X-Requested-With': 'XMLHttpRequest' };
  // A CSRF token is required or the write is rejected (Botble 200 + error envelope) before the
  // throttle middleware ever runs — so the probe must carry a real token.
  await guest.page.goto(url('/'), { waitUntil: 'domcontentloaded' }).catch(() => {});
  const token = await guest.page.evaluate(() => document.querySelector('meta[name="csrf-token"]')?.content || '').catch(() => '');
  const bodies = [];
  const burst = async (fn, n) => { const codes = []; for (let i = 0; i < n; i++) { const r = await fn().catch(() => ({ status: () => -1, text: async () => '' })); codes.push(r.status()); bodies[i] = (await r.text?.().catch(() => '')) || ''; } return codes; };
  // "Limited" = a 429, or a body that signals throttling (not the generic CSRF/expired envelope).
  const limited = (codes) => codes.includes(429) || bodies.some((b) => /too many|محاولات|rate limit|throttle|429|أكثر من اللازم/i.test(b));

  // OTP send: expect throttling within ~12 tries (limiter whatsapp-auth 10/min/IP).
  const otp = await burst(() => guest.page.request.post(url('/api/whatsapp/auth/send-otp'), { form: { phone: '96550009999', _token: token }, headers: H, maxRedirects: 0 }), 12);
  if (!limited(otp)) report.add({ id: 'RATE-OTP-SEND', severity: 'high', category: 'rate-limit', url: '/api/whatsapp/auth/send-otp', method: 'POST', evidence: { statuses: otp, sampleBody: (bodies[11] || '').slice(0, 120) }, recommendation: 'Throttle OTP send per phone and per IP.' });
  const logins = await burst(() => guest.page.request.post(url('/login'), { form: { email: accounts.customer1.email, password: 'wrong-pass', _token: token }, headers: H, maxRedirects: 0 }), 10);
  if (!logins.includes(429)) report.add({ id: 'RATE-LOGIN', severity: 'medium', category: 'rate-limit', url: '/login', method: 'POST', evidence: { statuses: logins }, recommendation: 'Ensure ThrottlesLogins locks repeated failures.' });

  // Coupon apply: limiter coupon 10/min.
  const coupons = await burst(() => victim.page.request.post(url('/coupon/apply'), { form: { coupon_code: 'NOPE', _token: victim.token }, headers: H, maxRedirects: 0 }), 12);
  if (!coupons.includes(429)) report.add({ id: 'RATE-COUPON', severity: 'medium', category: 'rate-limit', url: '/coupon/apply', method: 'POST', evidence: { statuses: coupons } });

  // Cart add: no limiter today — informational (recommend throttle:60,1).
  const prod = await guest.page.request.get(url(`/ajax/vue/products/${accounts.simpleProductSlug}`)).then((r) => (r.ok() ? r.json() : null)).catch(() => null);
  const pid = prod?.data?.id ?? prod?.id;
  if (pid) {
    const ct = await guest.page.evaluate(() => document.querySelector('meta[name="csrf-token"]')?.content || '').catch(() => '');
    const carts = await burst(() => guest.page.request.post(url('/ajax/vue/cart/add'), { form: { id: pid, qty: 1, _token: ct }, headers: H, maxRedirects: 0 }), 40);
    if (!carts.includes(429)) report.add({ id: 'RATE-CART-ADD', severity: 'info', category: 'rate-limit', url: '/ajax/vue/cart/add', method: 'POST', evidence: { count: carts.length }, recommendation: 'Optional: add throttle:60,1 to the cart ajax routes.' });
  }
}

module.exports = { run };

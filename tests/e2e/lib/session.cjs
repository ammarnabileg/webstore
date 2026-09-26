// Customer sessions + CSRF helpers. Uses page.request so cookies are shared with the browser context.
async function csrfToken(page, base, prefix = '') {
  await page.goto(`${base}${prefix}/login`, { waitUntil: 'domcontentloaded' });
  return page.evaluate(() =>
    document.querySelector('meta[name="csrf-token"]')?.content
    || document.querySelector('input[name="_token"]')?.value
    || (window.BotbleData && window.BotbleData.csrfToken) || '');
}

// Botble customer login: POST /customer/login {email,password,_token}
async function login(page, base, { email, password }, prefix = '') {
  const token = await csrfToken(page, base, prefix);
  const res = await page.request.post(`${base}${prefix}/login`, {
    form: { email, password, _token: token },
    headers: { Accept: 'application/json', 'X-Requested-With': 'XMLHttpRequest' },
    maxRedirects: 0,
  });
  // Ground truth is whether the session is authenticated (overview is 302→login when not).
  // Botble's JSON login can return a non-2xx body while still establishing the session, so we
  // trust the overview probe, not the POST status.
  const check = await page.request.get(`${base}${prefix}/customer/overview`, { maxRedirects: 0 });
  return { ok: check.status() === 200, loginStatus: res.status(), token };
}

async function logout(page, base, prefix = '') {
  await page.request.get(`${base}${prefix}/logout`, { maxRedirects: 0 }).catch(() => {});
}

module.exports = { csrfToken, login, logout };

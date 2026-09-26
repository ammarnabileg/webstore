// Open-redirect probe: redirect-ish params must not send the browser to a foreign host.
const canaries = require('../../config/canaries.json');

function foreignHost(location, base) {
  if (!location) return false;
  try {
    const u = new URL(location, base);
    const b = new URL(base);
    return u.host && u.host !== b.host;
  } catch { return false; }
}

async function run({ guest, report, url, base }) {
  const endpoints = ['/login', '/logout', '/customer/overview', '/currency/switch/KWD'];
  for (const endpoint of endpoints) {
    for (const param of canaries.openRedirectParams) {
      for (const target of canaries.openRedirectTargets) {
        const full = url(`${endpoint}?${param}=${encodeURIComponent(target)}`);
        const res = await guest.page.request.get(full, { maxRedirects: 0 }).catch(() => ({ status: () => -1, headers: () => ({}) }));
        const loc = (res.headers?.() || {}).location || '';
        if (res.status() >= 300 && res.status() < 400 && foreignHost(loc, base)) {
          report.add({ id: `OPEN-REDIRECT-${endpoint.replace(/\W+/g, '_').toUpperCase()}-${param.toUpperCase()}`, severity: 'high', category: 'open-redirect', url: `${endpoint}?${param}=`, method: 'GET', evidence: { target, location: loc }, recommendation: 'Only redirect to same-host / whitelisted paths.' });
        }
      }
    }
  }
}

module.exports = { run };

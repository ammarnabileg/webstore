// Browser/context factory + per-page collectors. Playwright is GLOBAL on this host.
const PW = process.env.PLAYWRIGHT_PATH || '/opt/node22/lib/node_modules/playwright';
const { chromium } = require(PW);

const VIEWPORTS = { mobile: { width: 390, height: 844 }, desktop: { width: 1280, height: 800 } };

// Console/network noise we never count as a defect (third parties, optional integrations).
const NOISE = [/widget\.deema\.me/i, /firebase/i, /gstatic\.com/i, /googleapis\.com/i, /tabler/i, /favicon/i, /net::ERR_(ABORTED|BLOCKED_BY_CLIENT)/i, /Failed to load resource.*(404|net::)/i];
const isNoise = (s) => NOISE.some((r) => r.test(s));

async function launch() {
  return chromium.launch();
}

async function newContext(browser, { viewport = 'mobile', locale = 'ar', theme = 'light', storageState, blockExternalFor } = {}) {
  const ctx = await browser.newContext({ viewport: VIEWPORTS[viewport], locale, storageState });
  // Optionally abort requests to third-party hosts (payment widgets, firebase, CDNs). These can
  // crash Chromium behind the agent proxy (TLS errors) and hang page loads; blocking them keeps
  // finding-detection stable. Same-origin, data:, blob: and about: are always allowed.
  if (blockExternalFor) {
    const host = (() => { try { return new URL(blockExternalFor).host; } catch { return null; } })();
    if (host) await ctx.route('**/*', (route) => {
      const u = route.request().url();
      if (/^(data|blob|about):/.test(u)) return route.continue();
      let h = ''; try { h = new URL(u).host; } catch {}
      return h && h !== host ? route.abort() : route.continue();
    });
  }
  await ctx.addInitScript((t) => {
    try {
      localStorage.setItem('hasSeenOnboarding_v1', 'true');
      localStorage.setItem('cookiesAccepted_v1', 'true');
      localStorage.setItem('pwaPromptDismissed_v1', String(Date.now()));
      sessionStorage.setItem('splashSeen_v1', '1');
      if (t === 'dark') { localStorage.setItem('theme', 'dark'); document.documentElement.setAttribute('data-theme', 'dark'); }
    } catch (e) {}
  }, theme);
  return ctx;
}

// Attach collectors to a page: page errors, console errors, 5xx responses, failed requests, state-changing requests.
function instrument(page) {
  const c = { pageErrors: [], consoleErrors: [], serverErrors: [], failedRequests: [], mutations: [] };
  page.on('pageerror', (e) => c.pageErrors.push(String(e.message || e).slice(0, 300)));
  page.on('console', (m) => { if (m.type() === 'error' && !isNoise(m.text())) c.consoleErrors.push(m.text().slice(0, 300)); });
  page.on('response', (r) => { if (r.status() >= 500) c.serverErrors.push(`${r.status()} ${r.request().method()} ${r.url()}`); });
  page.on('requestfailed', (r) => { const t = r.failure()?.errorText || ''; if (!isNoise(t) && !isNoise(r.url())) c.failedRequests.push(`${r.method()} ${r.url()} ${t}`); });
  page.on('request', (r) => {
    const m = r.method(); const u = r.url();
    const stateGet = /\/(logout|address\/delete\/|cart\/add\/|cart\/remove\/|cart\/destroy|currency\/switch\/)/.test(u);
    if (m !== 'GET' || stateGet) c.mutations.push({ method: m, url: u, headers: r.headers(), postData: r.postData() });
  });
  return c;
}

module.exports = { launch, newContext, instrument, VIEWPORTS, isNoise };

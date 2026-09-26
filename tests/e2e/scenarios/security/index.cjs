// Security probe layer: builds the three principals (customer_1 victim, customer_2 attacker, guest) and runs each probe.
const { newContext } = require('../../lib/browser.cjs');
const { login } = require('../../lib/session.cjs');

async function run(ctx) {
  const { browser, base, prefixes, report, accounts } = ctx;
  const prefix = prefixes.ar ?? '';
  const mk = async (who) => {
    const c = await newContext(browser, { viewport: 'mobile', locale: 'ar' });
    const page = await c.newPage();
    if (who) {
      const r = await login(page, base, accounts[who], prefix);
      if (!r.ok) report.add({ id: `SEC-LOGIN-${who}`, severity: 'high', category: 'auth', evidence: { status: r.loginStatus } });
    }
    await page.goto(`${base}${prefix}/`, { waitUntil: 'domcontentloaded' }).catch(() => {});
    const token = await page.evaluate(() => document.querySelector('meta[name="csrf-token"]')?.content || '');
    return { ctx: c, page, token, who };
  };
  const victim = await mk('customer1');
  const attacker = await mk('customer2');
  const guest = await mk(null);
  const env = { ...ctx, prefix, victim, attacker, guest, url: (p) => `${base}${prefix}${p}` };

  for (const name of ['csrf', 'idor', 'mass-assign', 'auth-gates', 'rate-limit', 'open-redirect', 'xss']) {
    console.log(`  [probe] ${name}`);
    try { await require(`./${name}.cjs`).run(env); }
    catch (e) { console.error(`  [probe:${name}] crashed:`, e.message); report.add({ id: `PROBE-CRASH-${name.toUpperCase()}`, severity: 'info', category: 'runner', evidence: { error: e.message.slice(0, 300) } }); }
  }
  await victim.ctx.close(); await attacker.ctx.close(); await guest.ctx.close();
}

module.exports = { run };

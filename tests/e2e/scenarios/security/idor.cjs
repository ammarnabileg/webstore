// IDOR probe: customer_2 (and guest) must not read/act on customer_1's id-bearing resources.
async function run({ victim, attacker, guest, report, url, db, accounts, customer1OrderId }) {
  const orderIds = db.orderIds(accounts.customer1.email);
  const addrIds = db.addressIds(accounts.customer1.email);
  const reviewIds = db.reviewIds(accounts.customer1.email);
  const oid = customer1OrderId || (orderIds.length ? Math.max(...orderIds) : null);
  const aid = addrIds.length ? Math.max(...addrIds) : null;
  const rid = reviewIds.length ? Math.max(...reviewIds) : null;

  // Read of the victim's own resource, to know what "leaked" looks like.
  const victimName = 'E2E Customer 1';

  const targets = [];
  if (oid) targets.push(['ORDER-VIEW', `/customer/orders/view/${oid}`], ['ORDER-PRINT', `/customer/orders/print/${oid}`], ['ORDER-INVOICE', `/customer/invoices/${oid}`]);
  if (aid) targets.push(['ADDRESS-EDIT', `/customer/address/edit/${aid}`]);

  for (const [id, endpoint] of targets) {
    for (const [who, principal] of [['ATTACKER', attacker], ['GUEST', guest]]) {
      const res = await principal.page.request.get(url(endpoint), { maxRedirects: 0 }).catch(() => ({ status: () => -1, text: async () => '' }));
      const status = res.status();
      const body = status === 200 ? await res.text().catch(() => '') : '';
      const leaked = status === 200 && body.includes(victimName);
      if (leaked || (who === 'ATTACKER' && status === 200 && body.length > 500 && !/login|تسجيل الدخول/i.test(body))) {
        report.add({ id: `IDOR-${id}-${who}`, severity: 'critical', category: 'idor', url: endpoint, method: 'GET', evidence: { status, leakedVictimName: leaked }, recommendation: 'Scope the lookup to the authenticated customer (where user_id = auth id).' });
      } else if (who === 'GUEST' && status === 200) {
        report.add({ id: `AUTHZ-GUEST-${id}`, severity: 'high', category: 'auth', url: endpoint, method: 'GET', evidence: { status } });
      }
    }
  }

  // Destructive IDOR (attacker tries to delete the victim's address / review). Only fire if we have a target id and a token.
  if (aid) {
    const res = await attacker.page.request.post(url(`/customer/address/delete/${aid}`), { form: { _token: attacker.token }, headers: { Accept: 'application/json', 'X-Requested-With': 'XMLHttpRequest' }, maxRedirects: 0 }).catch(() => ({ status: () => -1 }));
    const stillThere = db.addressIds(accounts.customer1.email).includes(aid);
    if (!stillThere) report.add({ id: 'IDOR-ADDRESS-DELETE-ATTACKER', severity: 'critical', category: 'idor', url: `/customer/address/delete/${aid}`, method: 'POST', evidence: { status: res.status() }, recommendation: 'Bind address delete to the owner.' });
  }
  if (rid) {
    const res = await attacker.page.request.delete(url(`/review/delete/${rid}`), { form: { _token: attacker.token }, headers: { Accept: 'application/json', 'X-Requested-With': 'XMLHttpRequest' }, maxRedirects: 0 }).catch(() => ({ status: () => -1 }));
    const stillThere = db.reviewIds(accounts.customer1.email).includes(rid);
    if (!stillThere) report.add({ id: 'IDOR-REVIEW-DELETE-ATTACKER', severity: 'critical', category: 'idor', url: `/review/delete/${rid}`, method: 'DELETE', evidence: { status: res.status() }, recommendation: 'Bind review delete to the owner.' });
  }

  if (!oid && !aid && !rid) report.add({ id: 'IDOR-NO-FIXTURES', severity: 'info', category: 'idor', evidence: { note: 'No victim order/address/review ids available; run checkout scenario first or seed them.' } });
}

module.exports = { run };

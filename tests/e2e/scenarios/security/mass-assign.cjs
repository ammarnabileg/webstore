// Mass-assignment probe: profile/address forms must ignore privilege/ownership fields.
async function run({ victim, report, url, db, accounts }) {
  const { page, token } = victim;
  const H = { Accept: 'application/json', 'X-Requested-With': 'XMLHttpRequest' };

  const before = db.tinker(`echo json_encode(\\Botble\\Ecommerce\\Models\\Customer::where('email','${accounts.customer1.email}')->first(['id','status','is_vendor']));`);
  let beforeObj = {}; try { beforeObj = JSON.parse(before); } catch {}

  // edit-account with extra privileged fields
  const res = await page.request.post(url('/customer/edit-account'), {
    form: { _token: token, name: 'E2E Customer 1', email: accounts.customer1.email, status: 'locked', is_vendor: '1', credits: '99999', confirmed_at: '2000-01-01 00:00:00', id: '1' },
    headers: H, maxRedirects: 0,
  }).catch(() => ({ status: () => -1 }));

  const after = db.tinker(`echo json_encode(\\Botble\\Ecommerce\\Models\\Customer::where('email','${accounts.customer1.email}')->first(['id','status','is_vendor']));`);
  let afterObj = {}; try { afterObj = JSON.parse(after); } catch {}

  const changed = [];
  for (const k of ['status', 'is_vendor']) if (String(beforeObj[k]) !== String(afterObj[k])) changed.push(`${k}: ${beforeObj[k]} -> ${afterObj[k]}`);
  if (changed.length) report.add({ id: 'MASS-ASSIGN-EDIT-ACCOUNT', severity: 'high', category: 'mass-assignment', url: '/customer/edit-account', method: 'POST', evidence: { status: res.status(), changed }, recommendation: 'Fill only validated fields (drop status/is_vendor/credits/id).' });

  // Restore state regardless (tests must be idempotent).
  db.setCustomerStatus(accounts.customer1.email, 'activated');
  db.tinker(`\\Botble\\Ecommerce\\Models\\Customer::where('email','${accounts.customer1.email}')->update(['is_vendor'=>0]); echo 'ok';`);

  // address create with foreign customer_id
  const victimId = db.customerId(accounts.customer2.email);
  const ares = await page.request.post(url('/customer/address/create'), {
    form: { _token: token, name: 'MA', phone: '55512345', email: accounts.customer1.email, country: 'KW', state: 'A', city: 'K', address: 'a', zip_code: '0', customer_id: String(victimId), is_default: '1' },
    headers: H, maxRedirects: 0,
  }).catch(() => ({ status: () => -1 }));
  // Did an address land on customer_2?
  const stolen = db.tinker(`echo \\Botble\\Ecommerce\\Models\\Address::where('customer_id',${victimId})->where('name','MA')->count();`);
  if (parseInt(stolen, 10) > 0) report.add({ id: 'MASS-ASSIGN-ADDRESS-CUSTOMER-ID', severity: 'high', category: 'mass-assignment', url: '/customer/address/create', method: 'POST', evidence: { status: ares.status(), landedOn: victimId }, recommendation: 'Force customer_id = auth id on address create.' });
  db.tinker(`\\Botble\\Ecommerce\\Models\\Address::where('name','MA')->delete(); echo 'ok';`);
}

module.exports = { run };

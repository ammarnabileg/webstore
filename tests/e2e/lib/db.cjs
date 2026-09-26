// Run small PHP snippets through artisan tinker (host only, local DB). Returns stdout.
const { execFileSync } = require('child_process');
const path = require('path');
const fs = require('fs');

const ROOT = path.resolve(__dirname, '../../..');

function tinker(code) {
  try {
    return execFileSync('php', ['artisan', 'tinker', '--execute=' + code], { cwd: ROOT, encoding: 'utf8', timeout: 120000, stdio: ['ignore', 'pipe', 'pipe'] }).trim();
  } catch (e) {
    return (e.stdout || '') + '\n[tinker error] ' + (e.stderr || e.message);
  }
}

function seed() {
  const code = fs.readFileSync(path.join(__dirname, '../fixtures/seed.php'), 'utf8').replace(/^<\?php\s*/, '');
  return tinker(code);
}

const safeArr = (s) => { const m = (s || '').match(/\[[^\]]*\]/); if (!m) return []; try { return JSON.parse(m[0]); } catch { return []; } };
const setCustomerStatus = (email, status) => tinker(`\\Botble\\Ecommerce\\Models\\Customer::where('email','${email}')->update(['status'=>'${status}']); echo 'ok';`);
const customerId = (email) => { const m = (tinker(`echo (int) optional(\\Botble\\Ecommerce\\Models\\Customer::where('email','${email}')->first())->id;`) || '').match(/\d+/); return m ? parseInt(m[0], 10) : null; };
// Query by the user_id/customer_id columns (avoids relation-name guessing that threw BadMethodCall).
const addressIds = (email) => { const id = customerId(email); return id ? safeArr(tinker(`echo json_encode(\\Botble\\Ecommerce\\Models\\Address::where('customer_id',${id})->pluck('id'));`)) : []; };
const orderIds = (email) => { const id = customerId(email); return id ? safeArr(tinker(`echo json_encode(\\Botble\\Ecommerce\\Models\\Order::where('user_id',${id})->pluck('id'));`)) : []; };
const reviewIds = (email) => { const id = customerId(email); return id ? safeArr(tinker(`echo json_encode(\\Botble\\Ecommerce\\Models\\Review::where('customer_id',${id})->pluck('id'));`)) : []; };
const laravelLogTail = (n = 200) => { const f = path.join(ROOT, 'storage/logs/laravel.log'); if (!fs.existsSync(f)) return ''; const lines = fs.readFileSync(f, 'utf8').split('\n'); return lines.slice(-n).join('\n'); };
const logSize = () => { const f = path.join(ROOT, 'storage/logs/laravel.log'); return fs.existsSync(f) ? fs.statSync(f).size : 0; };
const logSince = (offset) => { const f = path.join(ROOT, 'storage/logs/laravel.log'); if (!fs.existsSync(f)) return ''; const fd = fs.openSync(f, 'r'); const size = fs.statSync(f).size; const len = Math.max(0, size - offset); const buf = Buffer.alloc(len); fs.readSync(fd, buf, 0, len, offset); fs.closeSync(fd); return buf.toString('utf8'); };

module.exports = { tinker, seed, setCustomerStatus, customerId, addressIds, orderIds, reviewIds, laravelLogTail, logSize, logSince };

// Data-driven inventory of every storefront page. Dynamic slugs resolved at runtime via the theme's JSON API.
// kind: 'spa' (expects SPA chrome) | 'blade' (Botble/martfury fallback; expects at least a way home) | 'checkout'
// auth: 'guest' | 'customer' | 'both'
const accounts = require('../config/accounts.json');

const STATIC = [
  { id: 'home', path: '/', kind: 'spa', auth: 'both' },
  { id: 'products', path: '/products', kind: 'spa', auth: 'both' },
  { id: 'categories', path: '/categories', kind: 'spa', auth: 'both' },
  { id: 'product-simple', path: `/product/${accounts.simpleProductSlug}`, kind: 'spa', auth: 'both' },
  { id: 'product-variable', path: `/product/${accounts.variableProductSlug}`, kind: 'spa', auth: 'both' },
  { id: 'cart', path: '/cart', kind: 'spa', auth: 'both' },
  { id: 'search', path: '/search?q=cam', kind: 'spa', auth: 'both' },
  { id: 'profile', path: '/profile', kind: 'spa', auth: 'both' },
  { id: 'notifications', path: '/notifications', kind: 'spa', auth: 'both' },
  { id: 'wishlist', path: '/wishlist', kind: 'spa', auth: 'both' },
  { id: 'login', path: '/login', kind: 'spa', auth: 'guest' },
  { id: 'register', path: '/register', kind: 'spa', auth: 'guest' },
  { id: 'wizard', path: '/project-wizard', kind: 'spa', auth: 'both' },
  { id: 'cms-page', path: `/${accounts.cmsPageSlug}`, kind: 'spa', auth: 'both' },
  { id: 'not-found', path: '/no-such-page-e2e', kind: 'spa', auth: 'both', expectStatus: 404 },
  { id: 'product-tag', path: '/product-tags/e2e-tag', kind: 'spa', auth: 'both', dynamic: 'tag' },
  // Botble/martfury fallbacks
  { id: 'acct-overview', path: '/customer/overview', kind: 'blade', auth: 'customer' },
  { id: 'acct-edit', path: '/customer/edit-account', kind: 'blade', auth: 'customer' },
  { id: 'acct-password', path: '/customer/change-password', kind: 'blade', auth: 'customer' },
  { id: 'acct-address', path: '/customer/address', kind: 'blade', auth: 'customer' },
  { id: 'acct-address-create', path: '/customer/address/create', kind: 'blade', auth: 'customer' },
  { id: 'acct-orders', path: '/customer/orders', kind: 'blade', auth: 'customer' },
  { id: 'acct-returns', path: '/customer/order-returns', kind: 'blade', auth: 'customer' },
  { id: 'acct-downloads', path: '/customer/downloads', kind: 'blade', auth: 'customer' },
  { id: 'acct-reviews', path: '/customer/product-reviews', kind: 'blade', auth: 'customer' },
  { id: 'compare', path: '/compare', kind: 'blade', auth: 'both' },
  { id: 'order-tracking', path: '/orders/tracking', kind: 'blade', auth: 'both' },
  { id: 'password-reset', path: '/password/reset', kind: 'blade', auth: 'guest' },
  { id: 'stores', path: '/stores', kind: 'blade', auth: 'both', optional: true },
];

// Resolve dynamic entries (category slugs, a tag slug if any) from the live API.
async function resolve(page, base, prefix) {
  const list = STATIC.map((e) => ({ ...e }));
  const json = async (p) => { try { const r = await page.request.get(`${base}${prefix}${p}`); return r.ok() ? await r.json() : null; } catch { return null; } };
  const cats = await json('/ajax/vue/product-categories');
  const catList = Array.isArray(cats?.data) ? cats.data : Array.isArray(cats) ? cats : [];
  for (const c of catList.slice(0, 2)) if (c.slug) list.push({ id: `category-${c.slug}`, path: `/product-categories/${c.slug}`, kind: 'spa', auth: 'both' });
  const filters = await json('/ajax/vue/filters');
  const tag = (filters?.data?.tags || filters?.tags || [])[0];
  const tagEntry = list.find((e) => e.dynamic === 'tag');
  if (tag?.slug) tagEntry.path = `/product-tags/${tag.slug}`; else tagEntry.optional = true;
  return list;
}

module.exports = { STATIC, resolve };

// Helpers for links that come from the dashboard (banners, slides, menus): decide whether the
// SPA router can handle them, and normalise them to a router path.

const localePrefix = /^\/(ar|en)(\/|$)/;

export function isInternalUrl(url) {
    if (!url) return false;
    if (url.startsWith('#') || url.startsWith('javascript:')) return false;
    if (url.startsWith('/')) return true;
    try {
        return new URL(url, window.location.origin).host === window.location.host;
    } catch (e) {
        return false;
    }
}

// "/en/products?x=1" or "https://store/en/products" -> "/products?x=1"
export function toRouterPath(url) {
    let path = url;
    if (!url.startsWith('/')) {
        try {
            const u = new URL(url, window.location.origin);
            path = u.pathname + u.search + u.hash;
        } catch (e) {
            return '/';
        }
    }
    return path.replace(localePrefix, '/') || '/';
}

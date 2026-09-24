const CACHE_NAME = '{{ $cacheName }}';
const OFFLINE_URL = '/offline';

const PRECACHE_URLS = [
    '/',
    '/offline'
];

// Install event - cache essential resources
self.addEventListener('install', event => {
    console.log('PWA Service Worker: Installing...');
    event.waitUntil(
        caches.open(CACHE_NAME)
            .then(cache => {
                console.log('PWA Service Worker: Caching app shell');
                return cache.addAll(PRECACHE_URLS);
            })
            .then(() => self.skipWaiting())
            .catch(error => {
                console.error('PWA Service Worker: Cache failed', error);
            })
    );
});

// Activate event - clean up old caches
self.addEventListener('activate', event => {
    console.log('PWA Service Worker: Activating...');
    event.waitUntil(
        caches.keys().then(cacheNames => {
            return Promise.all(
                cacheNames.map(cacheName => {
                    if (cacheName !== CACHE_NAME) {
                        console.log('PWA Service Worker: Deleting old cache:', cacheName);
                        return caches.delete(cacheName);
                    }
                })
            );
        }).then(() => {
            console.log('PWA Service Worker: Activated');
            return self.clients.claim();
        })
    );
});

// Fetch event - network first, fallback to cache
self.addEventListener('fetch', event => {
    // Skip non-GET requests
    if (event.request.method !== 'GET') {
        return;
    }

    const url = new URL(event.request.url);

    // Only same-origin requests; never touch the admin panel.
    if (url.origin !== self.location.origin || url.pathname.startsWith('/{{ trim(BaseHelper::getAdminPrefix(), '/') }}')) {
        return;
    }

    // Only static assets are cached. Pages (account, orders, checkout, cart) may contain personal
    // data and must not stay on shared devices after logout.
    const isStaticAsset = ['style', 'script', 'image', 'font'].includes(event.request.destination)
        || /\.(css|js|png|jpe?g|gif|webp|svg|ico|woff2?|ttf)$/i.test(url.pathname);

    event.respondWith(
        fetch(event.request)
            .then(response => {
                if (isStaticAsset && response && response.status === 200 && response.type === 'basic') {
                    const responseToCache = response.clone();
                    caches.open(CACHE_NAME).then(cache => {
                        cache.put(event.request, responseToCache);
                    });
                }
                return response;
            })
            .catch(() => {
                // Network failed, try cache
                return caches.match(event.request).then(response => {
                    if (response) {
                        return response;
                    }
                    // If not in cache and it's a navigation request, show offline page
                    if (event.request.mode === 'navigate') {
                        return caches.match(OFFLINE_URL);
                    }
                });
            })
    );
});
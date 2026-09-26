/* Firebase Cloud Messaging worker for background push.
 * The storefront registers it as /firebase-messaging-sw.js?apiKey=...&projectId=... with the
 * public web-app config from the admin "Firebase push settings" page (laly-notifications plugin). */
importScripts('https://www.gstatic.com/firebasejs/10.7.1/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/10.7.1/firebase-messaging-compat.js');

const params = new URL(self.location.href).searchParams;
const config = {
  apiKey: params.get('apiKey'),
  authDomain: params.get('authDomain') || undefined,
  projectId: params.get('projectId'),
  messagingSenderId: params.get('messagingSenderId'),
  appId: params.get('appId'),
};

if (config.apiKey && config.projectId && config.messagingSenderId && config.appId) {
  firebase.initializeApp(config);

  firebase.messaging().onBackgroundMessage((payload) => {
    const title = payload.notification?.title || payload.data?.title || '';
    self.registration.showNotification(title, {
      body: payload.notification?.body || payload.data?.body || '',
      icon: '/storage/pwa-icon-192.png',
      data: { url: payload.fcmOptions?.link || payload.data?.url || '/' },
    });
  });
}

self.addEventListener('notificationclick', (event) => {
  event.notification.close();
  // Admin-set links may point to other sites; only http(s) is opened.
  const target = new URL(event.notification.data?.url || '/', self.location.origin);
  const url = /^https?:$/.test(target.protocol) ? target.href : self.location.origin + '/';
  event.waitUntil(clients.openWindow(url));
});

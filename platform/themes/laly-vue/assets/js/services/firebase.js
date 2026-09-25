import api from './api';

const SDK = 'https://www.gstatic.com/firebasejs/10.7.1';
let messaging = null;
let listening = false;

const getConfig = () => window.BotbleData?.firebase_config || null;

/** Push works only when the admin configured Firebase and the browser supports web push. */
export const pushSupported = () =>
    !!getConfig() && 'serviceWorker' in navigator && 'Notification' in window && 'PushManager' in window;

export const pushPermission = () => ('Notification' in window ? Notification.permission : 'denied');

/**
 * Subscribes this browser to push. Without `prompt` it only refreshes the token when the visitor
 * already allowed notifications, so nobody gets a permission popup on page load (browsers
 * penalise sites that do that). The Notifications page calls it with `prompt: true` from a click.
 */
export const initFirebase = async ({ prompt = false } = {}) => {
    const config = getConfig();
    if (!pushSupported()) return null;

    try {
        let permission = Notification.permission;
        if (permission === 'default' && prompt) {
            permission = await Notification.requestPermission();
        }
        if (permission !== 'granted') return null;

        const { initializeApp, getApps } = await import(/* webpackIgnore: true */ `${SDK}/firebase-app.js`);
        const { getMessaging, getToken, onMessage } = await import(/* webpackIgnore: true */ `${SDK}/firebase-messaging.js`);

        const app = getApps().length ? getApps()[0] : initializeApp(config);
        messaging = getMessaging(app);

        // The worker is a static file; it reads the (public) web config from its own URL.
        const params = new URLSearchParams({
            apiKey: config.apiKey,
            authDomain: config.authDomain || '',
            projectId: config.projectId,
            messagingSenderId: config.messagingSenderId,
            appId: config.appId,
        });
        const registration = await navigator.serviceWorker.register(`/firebase-messaging-sw.js?${params}`, {
            scope: '/firebase-cloud-messaging-push-scope',
        });

        const token = await getToken(messaging, { vapidKey: config.vapidKey, serviceWorkerRegistration: registration });
        if (token) {
            await sendTokenToServer(token);
        }

        if (!listening) {
            listening = true;
            onMessage(messaging, (payload) => {
                const title = payload.notification?.title || payload.data?.title || '';
                const body = payload.notification?.body || payload.data?.body || '';
                const url = payload.fcmOptions?.link || payload.data?.url || '/';
                window.dispatchEvent(new CustomEvent('fcm-notification', { detail: { title, body, url } }));
            });
        }

        return messaging;
    } catch (err) {
        return null;
    }
};

const sendTokenToServer = async (token) => {
    const ua = navigator.userAgent;
    const deviceType = /iPad|iPhone|iPod/.test(ua) ? 'ios' : (/Android/.test(ua) ? 'android' : 'web');

    try {
        await api.post('/fcm-token', { token, device_type: deviceType });
    } catch (err) {
        // A failed registration only means no push for this device; retried on the next visit.
    }
};

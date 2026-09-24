let messaging = null;

export const initFirebase = async (config) => {
    try {
        if (!config || !config.apiKey) {
            console.warn('[Firebase] Configuration missing, skipping initialization.');
            return null;
        }

        const { initializeApp } = await import(/* webpackIgnore: true */ 'https://www.gstatic.com/firebasejs/10.7.1/firebase-app.js');
        const { getMessaging, getToken, onMessage } = await import(/* webpackIgnore: true */ 'https://www.gstatic.com/firebasejs/10.7.1/firebase-messaging.js');

        const app = initializeApp(config);
        messaging = getMessaging(app);

        const permission = await Notification.requestPermission();
        if (permission === 'granted') {
            const token = await getToken(messaging, { vapidKey: config.vapidKey });
            if (token) {
                await sendTokenToServer(token);
            }
        }

        onMessage(messaging, (payload) => {
            console.log('[Firebase] Received foreground message ', payload);
            const title = payload.notification?.title || payload.data?.title || 'إشعار جديد';
            const body = payload.notification?.body || payload.data?.body || '';
            const url = payload.fcmOptions?.link || payload.data?.url || '/';
            
            window.dispatchEvent(new CustomEvent('fcm-notification', { detail: { title, body, url } }));
        });

        return messaging;
    } catch (err) {
        console.error('[Firebase] Initialization error: ', err);
        return null;
    }
};

const sendTokenToServer = async (token) => {
    try {
        const isIOS = /iPad|iPhone|iPod/.test(navigator.userAgent);
        const deviceType = isIOS ? 'ios' : (/Android/.test(navigator.userAgent) ? 'android' : 'web');
        
        await fetch('/ajax/vue/fcm-token', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]')?.getAttribute('content') || ''
            },
            body: JSON.stringify({ token, device_type: deviceType })
        });
    } catch (err) {
        console.error('[Firebase] Error sending token to server: ', err);
    }
};

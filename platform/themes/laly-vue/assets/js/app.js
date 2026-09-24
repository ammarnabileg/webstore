import { createApp } from 'vue';
import { createPinia } from 'pinia';
import router from './router';
import AppLayout from './layouts/AppLayout.vue';
import { __ } from './utils/i18n';

const app = createApp(AppLayout);

app.config.globalProperties.__ = __;

app.use(createPinia());
app.use(router);

app.mount('#app');
console.log("APP_JS_ENTRY_FILE_TEST");
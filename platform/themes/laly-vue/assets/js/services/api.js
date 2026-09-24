import axios from 'axios';

const match = window.location.pathname.match(/^\/(en|ar)(\/|$)/);
const localePrefix = match ? `/${match[1]}` : '';

const api = axios.create({
    baseURL: `${localePrefix}/ajax/vue`,
    headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
    }
});

export default api;

import axios from 'axios';

const api = axios.create({
    baseURL: '/api/v1/ecommerce',
    headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
    }
});

export default api;

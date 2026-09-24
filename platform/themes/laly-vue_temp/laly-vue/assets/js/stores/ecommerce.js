import { defineStore } from 'pinia';
import api from '../services/api';

export const useEcommerceStore = defineStore('ecommerce', {
    state: () => ({
        products: [],
        categories: [],
        loading: false,
    }),
    actions: {
        async fetchProducts(params = {}) {
            this.loading = true;
            try {
                const response = await api.get('/products', { params });
                this.products = response.data.data || [];
            } catch (err) {
                console.error('Error fetching products:', err);
            } finally {
                this.loading = false;
            }
        },
        async fetchCategories() {
            try {
                const response = await api.get('/product-categories');
                this.categories = response.data.data || [];
            } catch (err) {
                console.error('Error fetching categories:', err);
            }
        }
    }
});

import { defineStore } from 'pinia';
import api from '../services/api';

export const useEcommerceStore = defineStore('ecommerce', {
    state: () => ({
        products: [],
        productsMeta: null,
        loadingMore: false,
        categories: [],
        cart: null,
        cartCount: 0,
        currentProduct: null,
        searchResults: [],
        searchMeta: null,
        filters: { attributes: [], collections: [], tags: [] },
        wishlist: JSON.parse(localStorage.getItem('wishlist') || '[]'),
        compareList: JSON.parse(localStorage.getItem('compareList') || '[]'),
        loading: false,
        notifications: [],
        quickViewOpen: false,
        // Kept separate from currentProduct so opening quick view never replaces the product page.
        quickViewProduct: null,
        quickViewLoading: false,
    }),
    getters: {
        rootCategories: (state) => state.categories.filter(c => !c.parent_id),
        featuredRootCategories: (state) => state.categories.filter(c => !c.parent_id && c.is_featured == 1),
        getChildren: (state) => (parentId) => state.categories.filter(c => c.parent_id === parentId)
    },
    actions: {
        async fetchFilters(params = {}) {
            try {
                const response = await api.get('/filters', { params });
                this.filters = response.data.data || { attributes: [], collections: [], tags: [] };
            } catch (err) {
                console.error('Error fetching filters:', err);
            }
        },
        async fetchProducts(params = {}, { append = false } = {}) {
            if (append) {
                this.loadingMore = true;
            } else {
                this.loading = true;
            }
            try {
                const response = await api.get('/products', { params });
                const items = response.data.data || [];
                this.products = append ? [...this.products, ...items] : items;
                this.productsMeta = response.data.meta || null;
            } catch (err) {
                console.error('Error fetching products:', err);
            } finally {
                this.loading = false;
                this.loadingMore = false;
            }
        },
        async fetchCategories() {
            try {
                const response = await api.get('/product-categories');
                this.categories = response.data.data || [];
            } catch (err) {
                console.error('Error fetching categories:', err);
            }
        },
        async fetchProductBySlug(slug) {
            this.loading = true;
            try {
                const response = await api.get(`/products/${slug}`);
                this.currentProduct = response.data.data || null;
            } catch (err) {
                console.error('Error fetching product detail:', err);
            } finally {
                this.loading = false;
            }
        },
        async openQuickView(slug) {
            this.quickViewOpen = true;
            this.quickViewLoading = true;
            this.quickViewProduct = null;
            try {
                const response = await api.get(`/products/${slug}`);
                this.quickViewProduct = response.data.data || null;
            } catch (err) {
                console.error('Error fetching quick view product:', err);
            } finally {
                this.quickViewLoading = false;
            }
        },
        async searchProducts(query, { append = false, page = 1 } = {}) {
            if (append) {
                this.loadingMore = true;
            } else {
                this.loading = true;
            }
            try {
                const response = await api.get('/products', { params: { q: query, per_page: 20, page } });
                const items = response.data.data || [];
                this.searchResults = append ? [...this.searchResults, ...items] : items;
                this.searchMeta = response.data.meta || null;
            } catch (err) {
                console.error('Error searching products:', err);
            } finally {
                this.loading = false;
                this.loadingMore = false;
            }
        },
        async fetchCart() {
            try {
                const response = await api.get('/cart');
                this.cart = response.data.data || null;
                this.cartCount = this.cart?.count || 0;
            } catch (err) {
                console.error('Error fetching cart:', err);
            }
        },
        async addToCart(productId, qty = 1) {
            try {
                const response = await api.post('/cart/add', { id: productId, qty });
                if (response.data && !response.data.error) {
                    await this.fetchCart();
                    return true;
                }
                return false;
            } catch (err) {
                console.error('Error adding to cart:', err);
                return false;
            }
        },
        async removeCartItem(rowId) {
            try {
                await api.delete(`/cart/remove/${rowId}`);
                await this.fetchCart();
            } catch (err) {
                console.error('Error removing from cart:', err);
            }
        },
        async updateCartItem(rowId, qty) {
            try {
                const response = await api.post('/cart/update', { rowId, qty });
                if (response.data && !response.data.error) {
                    await this.fetchCart();
                    return true;
                }
                return false;
            } catch (err) {
                console.error('Error updating cart:', err);
                return false;
            }
        },
        async toggleWishlist(product) {
            // Optimistic local update (keeps the heart responsive and works offline).
            const index = this.wishlist.findIndex(item => item.id === product.id);
            if (index > -1) {
                this.wishlist.splice(index, 1);
            } else {
                this.wishlist.push(product);
            }
            localStorage.setItem('wishlist', JSON.stringify(this.wishlist));
            // Persist to the server (server-side toggle) so it survives reloads and,
            // for signed-in customers, syncs across devices.
            try {
                await api.post(`/wishlist/${product.id}`);
            } catch (err) {
                console.error('Error syncing wishlist:', err);
            }
        },
        async fetchWishlist() {
            try {
                const response = await api.get('/wishlist');
                const serverItems = response.data.data || [];
                const serverIds = new Set(serverItems.map(i => i.id));
                // One-time migration: push any localStorage-only items up to the server.
                const localOnly = this.wishlist.filter(i => !serverIds.has(i.id));
                for (const item of localOnly) {
                    try { await api.post(`/wishlist/${item.id}`); } catch (e) { /* keep going */ }
                }
                if (localOnly.length) {
                    const merged = await api.get('/wishlist');
                    this.wishlist = merged.data.data || serverItems;
                } else {
                    this.wishlist = serverItems;
                }
                localStorage.setItem('wishlist', JSON.stringify(this.wishlist));
            } catch (err) {
                console.error('Error fetching wishlist:', err);
            }
        },
        toggleCompare(product) {
            const index = this.compareList.findIndex(item => item.id === product.id);
            if (index > -1) {
                this.compareList.splice(index, 1);
            } else {
                this.compareList.push(product);
            }
            localStorage.setItem('compareList', JSON.stringify(this.compareList));
        },
        async submitReview({ product_id, star, comment }) {
            // Post to the top-level review endpoint so Botble's ReviewRequest validation
            // and purchase/eligibility policy are reused (baseURL override: this route is
            // not under /ajax/vue). Axios sends the XSRF cookie for CSRF.
            const match = window.location.pathname.match(/^\/(en|ar)(\/|$)/);
            const prefix = match ? `/${match[1]}` : '';
            try {
                const res = await api.post('/review/create', { product_id, star, comment }, { baseURL: prefix || '/' });
                if (res.data && !res.data.error) {
                    return { ok: true, message: res.data.message };
                }
                return { ok: false, message: res.data?.message };
            } catch (err) {
                const data = err?.response?.data;
                const msg = data?.message
                    || (data?.errors ? Object.values(data.errors).flat()[0] : null);
                return { ok: false, message: msg };
            }
        },
        notify(message, type = 'success', duration = 3000) {
            const id = Date.now() + Math.random().toString(36).substr(2, 9);
            this.notifications.push({ id, message, type });
            setTimeout(() => {
                this.removeNotification(id);
            }, duration);
        },
        removeNotification(id) {
            this.notifications = this.notifications.filter(n => n.id !== id);
        }
    }
});

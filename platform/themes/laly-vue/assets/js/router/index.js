import { createRouter, createWebHistory } from 'vue-router';
import { __ } from '../utils/i18n';
import Home from '../pages/Home.vue';
import Categories from '../pages/Categories.vue';
import Products from '../pages/Products.vue';
import ProductDetail from '../pages/ProductDetail.vue';
import Cart from '../pages/Cart.vue';
import Search from '../pages/Search.vue';
import Profile from '../pages/Profile.vue';
import Wishlist from '../pages/Wishlist.vue';
import Notifications from '../pages/Notifications.vue';
import SystemWizard from '../pages/SystemWizard.vue';
import NotFound from '../pages/NotFound.vue';
import CmsPage from '../pages/CmsPage.vue';

import Auth from '../pages/Auth.vue';

const routes = [
    { path: '/', name: 'Home', component: Home },
    { path: '/login', alias: '/register', name: 'Auth', component: Auth },
    { path: '/project-wizard', name: 'SystemWizard', component: SystemWizard },
    { path: '/categories', name: 'Categories', component: Categories },
    { path: '/products', name: 'Products', component: Products },
    { path: '/product-categories/:slug', name: 'CategoryProducts', component: Products },
    { path: '/product/:slug', alias: '/products/:slug', name: 'ProductDetail', component: ProductDetail },
    { path: '/cart', name: 'Cart', component: Cart },
    { path: '/search', name: 'Search', component: Search },
    { path: '/profile', name: 'Profile', component: Profile },
    { path: '/wishlist', name: 'Wishlist', component: Wishlist },
    { path: '/notifications', name: 'Notifications', component: Notifications },
    { path: '/:slug(.*)*', name: 'CmsPage', component: CmsPage },
];

const getBaseUrl = () => {
    let base = '/';
    if (window.BotbleData && window.BotbleData.baseUrl) {
        try {
            const urlObj = new URL(window.BotbleData.baseUrl);
            base = urlObj.pathname;
        } catch (e) {
            base = '/';
        }
    }
    if (!base.endsWith('/')) {
        base += '/';
    }

    const fullPath = window.location.pathname;
    const regex = new RegExp('^' + base.replace(/[.*+?^${}()|[\]\\]/g, '\\$&') + '(en|ar)(\\/|$)');
    const match = fullPath.match(regex);
    if (match) {
        base += match[1];
    }

    return base;
};

const router = createRouter({
    history: createWebHistory(getBaseUrl()),
    routes,
    scrollBehavior(to, from, savedPosition) {
        if (savedPosition) return savedPosition;
        return { top: 0 };
    }
});

const SITE_NAME = window.themeOptions?.site_title || 'Laly Kuwait';

router.afterEach((to) => {
    let routeName = to.name;
    let titleKey = '';
    
    switch (routeName) {
        case 'Home': titleKey = 'home'; break;
        case 'Categories': titleKey = 'categories'; break;
        case 'Products': titleKey = 'products'; break;
        case 'Cart': titleKey = 'cart'; break;
        case 'Search': titleKey = 'search'; break;
        case 'Profile': titleKey = 'profile'; break;
        case 'Wishlist': titleKey = 'wishlist'; break;
        case 'Notifications': titleKey = 'notifications'; break;
    }
    
    if (titleKey) {
        document.title = `${__(titleKey)} - ${SITE_NAME}`;
    } else {
        document.title = SITE_NAME;
    }
});

export default router;

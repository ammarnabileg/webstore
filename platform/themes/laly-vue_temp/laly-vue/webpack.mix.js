let mix = require('laravel-mix');
const path = require('path');

const dist = '../../../public/themes/laly-vue';

mix
    .sass('assets/sass/app.scss', dist + '/css')
    .js('assets/js/app.js', dist + '/js')
    .vue({ version: 3 });

mix.options({ autoprefixer: false });

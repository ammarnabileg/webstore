let mix = require('laravel-mix');

const path = require('path');
let directory = path.basename(path.resolve(__dirname));

const source = '.';
const dist = 'themes/' + directory;
const publicPath = '../../../public';

mix.setPublicPath(publicPath);

mix
    .sass(source + '/assets/sass/app.scss', dist + '/css')
    .js(source + '/assets/js/app.js', dist + '/js')
    .vue({ version: 3 })
    .copy(publicPath + '/' + dist + '/js/app.js', source + '/public/js/app.js')
    .copy(publicPath + '/' + dist + '/css/app.css', source + '/public/css/app.css');

mix.options({ autoprefixer: false });
mix.webpackConfig({ externals: {} });

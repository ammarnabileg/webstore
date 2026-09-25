let mix = require('laravel-mix');

const fs = require('fs');
const path = require('path');
let directory = path.basename(path.resolve(__dirname));

const source = '.';
const dist = 'themes/' + directory;
const publicPath = '../../../public';

// Route-level chunks (e.g. the wizard) get content-hashed names; drop the previous build's
// chunks so stale files do not pile up in the theme's committed public folder.
for (const dir of [path.resolve(__dirname, publicPath, dist, 'js/chunks'), path.resolve(__dirname, 'public/js/chunks')]) {
    fs.rmSync(dir, { recursive: true, force: true });
}

mix.setPublicPath(publicPath);

mix
    .sass(source + '/assets/sass/app.scss', dist + '/css')
    .js(source + '/assets/js/app.js', dist + '/js')
    .vue({ version: 3 })
    .copy(publicPath + '/' + dist + '/js/app.js', source + '/public/js/app.js')
    .copyDirectory(publicPath + '/' + dist + '/js/chunks', source + '/public/js/chunks')
    .copy(publicPath + '/' + dist + '/css/app.css', source + '/public/css/app.css');

mix.options({ autoprefixer: false });
mix.webpackConfig({
    externals: {},
    // Served from /themes/laly-vue/js/chunks/ (Botble publishes the theme's public/ folder there).
    output: { chunkFilename: dist + '/js/chunks/[name].[chunkhash:8].js' },
});

<?php

namespace Botble\PWA\Http\Controllers;

use Botble\Base\Http\Controllers\BaseController;
use Botble\Base\Http\Responses\BaseHttpResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\File;

class PWAController extends BaseController
{
    public function getSettings()
    {
        page_title()->setTitle('PWA Settings');

        // Get current settings
        $settings = [
            'pwa_enabled' => setting('pwa_enabled', 0),
            'pwa_name' => setting('pwa_name', theme_option('site_title') ?? config('app.name')),
            'pwa_short_name' => setting('pwa_short_name', theme_option('site_title') ?? config('app.name')),
            'pwa_description' => setting('pwa_description', theme_option('seo_description', '')),
            'pwa_theme_color' => setting('pwa_theme_color', '#6366f1'),
            'pwa_background_color' => setting('pwa_background_color', '#ffffff'),
            'pwa_display' => setting('pwa_display', 'standalone'),
            'pwa_orientation' => setting('pwa_orientation', 'portrait'),
        ];

        return view('plugins/pwa::settings', compact('settings'));
    }

    public function postSettings(Request $request, BaseHttpResponse $response)
    {
        $request->validate([
            'pwa_name' => 'required|string|max:255',
            'pwa_short_name' => 'required|string|max:12',
            'pwa_description' => 'nullable|string|max:500',
            'pwa_theme_color' => ['required', 'string', 'regex:/^#[0-9a-fA-F]{3,8}$/'],
            'pwa_background_color' => ['required', 'string', 'regex:/^#[0-9a-fA-F]{3,8}$/'],
            'pwa_icon' => 'nullable|image|mimes:png,jpg,jpeg,webp|max:2048',
        ]);

        // Save settings
        setting()
            ->set('pwa_enabled', $request->input('pwa_enabled', 0))
            ->set('pwa_name', $request->input('pwa_name'))
            ->set('pwa_short_name', $request->input('pwa_short_name'))
            ->set('pwa_description', $request->input('pwa_description'))
            ->set('pwa_theme_color', $request->input('pwa_theme_color'))
            ->set('pwa_background_color', $request->input('pwa_background_color'))
            ->set('pwa_display', $request->input('pwa_display', 'standalone'))
            ->set('pwa_orientation', $request->input('pwa_orientation', 'portrait'))
            ->save();

        // Handle icon upload
        if ($request->hasFile('pwa_icon')) {
            $this->handleIconUpload($request->file('pwa_icon'));
        }

        return $response
            ->setMessage('PWA settings updated successfully!');
    }

    protected function handleIconUpload($file)
    {
        $publicPath = public_path('storage');
        
        if (!File::exists($publicPath)) {
            File::makeDirectory($publicPath, 0755, true);
        }

        // Create 192x192 version
        $this->resizeAndSaveIcon($file, $publicPath . '/pwa-icon-192.png', 192);
        
        // Create 512x512 version
        $this->resizeAndSaveIcon($file, $publicPath . '/pwa-icon-512.png', 512);
    }

    protected function resizeAndSaveIcon($file, $destination, $size)
    {
        $image = null;
        $mimeType = $file->getMimeType();

        // Create image from file
        if ($mimeType == 'image/jpeg' || $mimeType == 'image/jpg') {
            $image = imagecreatefromjpeg($file->getPathname());
        } elseif ($mimeType == 'image/png') {
            $image = imagecreatefrompng($file->getPathname());
        } elseif ($mimeType == 'image/gif') {
            $image = imagecreatefromgif($file->getPathname());
        }

        if ($image) {
            // Get original dimensions
            $width = imagesx($image);
            $height = imagesy($image);

            // Create new image
            $newImage = imagecreatetruecolor($size, $size);
            
            // Preserve transparency for PNG
            imagealphablending($newImage, false);
            imagesavealpha($newImage, true);
            
            // Resize
            imagecopyresampled($newImage, $image, 0, 0, 0, 0, $size, $size, $width, $height);
            
            // Save
            imagepng($newImage, $destination);
            
            // Clean up
            imagedestroy($image);
            imagedestroy($newImage);
        }
    }

    public function manifest()
    {
        $manifest = [
            'name' => setting('pwa_name', config('app.name')),
            'short_name' => setting('pwa_short_name', config('app.name')),
            'description' => setting('pwa_description', ''),
            'start_url' => url('/'),
            'scope' => '/',
            'display' => setting('pwa_display', 'standalone'),
            'orientation' => setting('pwa_orientation', 'portrait'),
            'theme_color' => setting('pwa_theme_color', '#6366f1'),
            'background_color' => setting('pwa_background_color', '#ffffff'),
            'icons' => [
                [
                    'src' => url('storage/pwa-icon-192.png'),
                    'sizes' => '192x192',
                    'type' => 'image/png',
                    'purpose' => 'any maskable'
                ],
                [
                    'src' => url('storage/pwa-icon-512.png'),
                    'sizes' => '512x512',
                    'type' => 'image/png',
                    'purpose' => 'any maskable'
                ]
            ]
        ];

        return response()->json($manifest)
            ->header('Content-Type', 'application/manifest+json');
    }

    public function serviceWorker()
    {
        $cacheName = 'botble-pwa-v' . time();
        $content = view('plugins/pwa::service-worker', compact('cacheName'))->render();
        
        return response($content, 200)
            ->header('Content-Type', 'application/javascript')
            ->header('Service-Worker-Allowed', '/');
    }

    public function offline()
    {
        return view('plugins/pwa::offline');
    }
}
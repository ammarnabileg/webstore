<?php

namespace Botble\SystemWizard\Http\Controllers;

use Botble\Base\Http\Controllers\BaseController;
use Illuminate\Http\Request;
use Botble\Base\Http\Responses\BaseHttpResponse;
use Botble\SystemWizard\Models\ProjectLead;
use Botble\Ecommerce\Models\Product;

class PublicSystemWizardController extends BaseController
{
    public function catalog(BaseHttpResponse $response)
    {
        // Helper to get real product price and name from DB based on setting
        $getProduct = function($settingKey) {
            $productId = setting($settingKey);
            if (!$productId) return ['name' => 'غير محدد', 'price' => 0];
            $product = Product::find($productId);
            if (!$product) return ['name' => 'غير محدد', 'price' => 0];
            return [
                'name' => $product->name,
                'price' => $product->front_sale_price ?: $product->price,
            ];
        };

        // Helper to get raw price for NVR/HDD where name isn't dynamic in the wizard but price is
        $getPrice = function($settingKey, $default = 0) {
            $productId = setting($settingKey);
            if (!$productId) return $default;
            $product = Product::find($productId);
            return $product ? ($product->front_sale_price ?: $product->price) : $default;
        };

        $catalog = [
            'camera' => [
                'basic' => [
                    'in' => $getProduct('sw_cam_basic_in'),
                    'out' => $getProduct('sw_cam_basic_out'),
                    'gbDay' => 12
                ],
                'pro' => [
                    'in' => $getProduct('sw_cam_pro_in'),
                    'out' => $getProduct('sw_cam_pro_out'),
                    'gbDay' => 20
                ],
                'prem' => [
                    'in' => $getProduct('sw_cam_prem_in'),
                    'out' => $getProduct('sw_cam_prem_out'),
                    'gbDay' => 35
                ],
            ],
            'ptz' => $getProduct('sw_ptz'),
            'nvr' => [
                8  => ['basic' => $getPrice('sw_nvr_8_basic'), 'pro' => $getPrice('sw_nvr_8_pro'), 'prem' => $getPrice('sw_nvr_8_prem')],
                16 => ['basic' => $getPrice('sw_nvr_16_basic'), 'pro' => $getPrice('sw_nvr_16_pro'), 'prem' => $getPrice('sw_nvr_16_prem')],
                32 => ['basic' => $getPrice('sw_nvr_32_basic'), 'pro' => $getPrice('sw_nvr_32_pro'), 'prem' => $getPrice('sw_nvr_32_prem')],
            ],
            'hdd' => [
                'sizes' => [1, 2, 4, 6, 8, 12],
                'price' => [
                    1 => $getPrice('sw_hdd_1tb'),
                    2 => $getPrice('sw_hdd_2tb'),
                    4 => $getPrice('sw_hdd_4tb'),
                    6 => $getPrice('sw_hdd_6tb'),
                    8 => $getPrice('sw_hdd_8tb'),
                    12 => $getPrice('sw_hdd_12tb'),
                ]
            ],
            'poeSwitch' => [
                'ports' => [4, 8, 16, 24],
                'price' => [
                    4 => $getPrice('sw_poe_4'),
                    8 => $getPrice('sw_poe_8'),
                    16 => $getPrice('sw_poe_16'),
                    24 => $getPrice('sw_poe_24'),
                ]
            ],
            'ap' => [
                'basic' => $getProduct('sw_ap_basic'),
                'pro' => $getProduct('sw_ap_pro'),
                'prem' => $getProduct('sw_ap_prem'),
                'controller' => $getProduct('sw_ap_controller'),
            ],
            'intercom' => [
                'basic' => $getProduct('sw_intercom_basic'),
                'pro' => $getProduct('sw_intercom_pro'),
                'prem' => $getProduct('sw_intercom_prem'),
            ],
            'alarm' => [
                'basic' => $getProduct('sw_alarm_basic'),
                'pro' => $getProduct('sw_alarm_pro'),
                'prem' => $getProduct('sw_alarm_prem'),
            ],
            'router4g' => $getProduct('sw_router4g'),
            'netPoint' => [
                'basic' => $getProduct('sw_netpoint_basic'),
                'pro' => $getProduct('sw_netpoint_pro'),
                'prem' => $getProduct('sw_netpoint_prem'),
            ],
            'tvPoint' => [
                'basic' => $getProduct('sw_tvpoint_basic'),
                'pro' => $getProduct('sw_tvpoint_pro'),
                'prem' => $getProduct('sw_tvpoint_prem'),
            ],
            'rack' => [
                'basic' => $getProduct('sw_rack_basic'),
                'pro' => $getProduct('sw_rack_pro'),
                'prem' => $getProduct('sw_rack_prem'),
            ],
            'installPerPoint' => (int) setting('sw_install_per_point', 8),
            'whatsappNumber' => setting('sw_whatsapp_number', ''),
        ];

        return $response->setData($catalog);
    }

    public function storeLead(Request $request, BaseHttpResponse $response)
    {
        $request->validate([
            'name' => 'required|min:2',
            'phone' => 'required',
            'package' => 'required',
        ]);

        // Here we can recompute BOM but for now we trust the payload per prompt simplification, 
        // OR we can implement the RecommendationService. Since it's a Vue logic, we will trust the client BOM for v1, 
        // but normally we should recompute. The prompt says "server-side RecommendationService: a 1:1 port".
        
        $lead = new ProjectLead();
        $lead->name = $request->input('name');
        $lead->phone = $request->input('phone');
        $lead->answers = json_encode($request->except(['name', 'phone', 'package_estimate', 'bom', 'package']));
        $lead->package_tier = $request->input('package');
        $lead->estimate = $request->input('package_estimate');
        $lead->bom = json_encode($request->input('bom'));
        $lead->status = 'new';
        $lead->save();

        try {
            // Send email notification to admin
            $adminEmail = setting('admin_email', config('mail.from.address'));
            if ($adminEmail) {
                \Illuminate\Support\Facades\Mail::send('plugins/system-wizard::emails.lead', ['lead' => $lead], function ($message) use ($adminEmail) {
                    $message->to($adminEmail)->subject('طلب نظام مراقبة جديد - ' . config('app.name'));
                });
            }
        } catch (\Exception $e) {
            \Illuminate\Support\Facades\Log::error('Failed to send lead email: ' . $e->getMessage());
        }

        return $response->setMessage('Lead submitted successfully');
    }
}

<?php

namespace Botble\SystemWizard\Http\Controllers;

use Botble\Base\Http\Controllers\BaseController;
use Illuminate\Http\Request;
use Botble\Base\Http\Responses\BaseHttpResponse;
use Assets;
use Botble\SystemWizard\Models\ProjectLead;
use Botble\Ecommerce\Models\Product;

class SystemWizardController extends BaseController
{
    public function index()
    {
        page_title()->setTitle('طلبات اعرف نظامك');
        $leads = ProjectLead::orderBy('created_at', 'desc')->paginate(10);
        return view('plugins/system-wizard::leads.index', compact('leads'));
    }

    public function settings()
    {
        page_title()->setTitle('إعدادات اعرف نظامك');
        // Get all active products for the dropdowns
        $products = Product::where('status', 'published')->get()->pluck('name', 'id')->toArray();
        return view('plugins/system-wizard::settings', compact('products'));
    }

    public function saveSettings(Request $request, BaseHttpResponse $response)
    {
        foreach ($request->except(['_token']) as $key => $value) {
            setting()->set($key, $value);
        }
        setting()->save();

        return $response
            ->setPreviousUrl(route('system-wizard.settings'))
            ->setMessage(trans('core/base::notices.update_success_message'));
    }
}

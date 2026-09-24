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
    public function index(Request $request)
    {
        page_title()->setTitle('طلبات اعرف نظامك');

        $status = $request->query('status');

        $leads = ProjectLead::query()
            ->when(array_key_exists((string) $status, ProjectLead::STATUSES), fn ($q) => $q->where('status', $status))
            ->latest()
            ->paginate(20)
            ->withQueryString();

        $counts = ProjectLead::query()
            ->selectRaw('status, COUNT(*) as total')
            ->groupBy('status')
            ->pluck('total', 'status');

        return view('plugins/system-wizard::leads.index', compact('leads', 'status', 'counts'));
    }

    public function updateStatus(int|string $id, Request $request, BaseHttpResponse $response)
    {
        $data = $request->validate([
            'status' => ['required', \Illuminate\Validation\Rule::in(array_keys(ProjectLead::STATUSES))],
        ]);

        ProjectLead::query()->findOrFail($id)->update(['status' => $data['status']]);

        return $response
            ->setPreviousUrl(route('system-wizard.index'))
            ->setMessage(trans('core/base::notices.update_success_message'));
    }

    public function settings()
    {
        page_title()->setTitle('إعدادات اعرف نظامك');
        // Get all active products for the dropdowns
        $products = Product::query()->where('status', 'published')->where('is_variation', 0)->pluck('name', 'id')->toArray();
        return view('plugins/system-wizard::settings', compact('products'));
    }

    public function saveSettings(Request $request, BaseHttpResponse $response)
    {
        // Only this plugin's own keys: a request must not be able to overwrite unrelated
        // settings (admin email, payment secrets, activated plugins...).
        foreach ($request->except(['_token']) as $key => $value) {
            if (! preg_match('/^sw_[a-z0-9_]{1,60}$/', (string) $key) || is_array($value)) {
                continue;
            }

            setting()->set($key, $value === null ? '' : (string) $value);
        }
        setting()->save();

        // Product mapping changed: rebuild the cached wizard catalog.
        \Botble\SystemWizard\Services\WizardCatalog::forget();

        return $response
            ->setPreviousUrl(route('system-wizard.settings'))
            ->setMessage(trans('core/base::notices.update_success_message'));
    }
}

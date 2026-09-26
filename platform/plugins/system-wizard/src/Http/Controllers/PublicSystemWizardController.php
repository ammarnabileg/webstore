<?php

namespace Botble\SystemWizard\Http\Controllers;

use Botble\Base\Http\Controllers\BaseController;
use Botble\Base\Http\Responses\BaseHttpResponse;
use Botble\SystemWizard\Models\ProjectLead;
use Botble\SystemWizard\Services\RecommendationService;
use Botble\SystemWizard\Services\WizardCatalog;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Mail;
use Illuminate\Validation\Rule;

class PublicSystemWizardController extends BaseController
{
    public function catalog(BaseHttpResponse $response, WizardCatalog $catalog)
    {
        return $response->setData($catalog->get());
    }

    public function storeLead(Request $request, BaseHttpResponse $response, RecommendationService $recommendations)
    {
        // Honeypot: real users never see or fill this field.
        if ($request->filled('website')) {
            return $response->setMessage('Lead submitted successfully');
        }

        $data = $request->validate([
            'name' => ['required', 'string', 'min:2', 'max:100'],
            'phone' => ['required', 'string', 'max:20'],
            'package' => ['required', Rule::in(['basic', 'pro', 'prem', 'advise'])],

            'answers' => ['required', 'array'],
            'answers.place' => ['required', Rule::in(['apartment', 'villa', 'shop', 'office', 'warehouse', 'compound'])],
            'answers.area' => ['required', 'integer', 'between:0,3'],
            'answers.floors' => ['required', 'integer', 'between:0,2'],
            'answers.entrances' => ['required', 'integer', 'between:0,3'],
            'answers.outdoor' => ['required', 'boolean'],
            'answers.condition' => ['required', 'integer', 'between:0,2'],
            'answers.conduits' => ['nullable', Rule::in(['yes', 'no', 'unsure'])],
            'answers.goals' => ['required', 'array', 'min:1', 'max:6'],
            'answers.goals.*' => [Rule::in(['entry', 'indoor', 'perimeter', 'wifi', 'intercom', 'alarm'])],
            'answers.devices' => ['nullable', 'integer', 'between:0,2'],
            'answers.recordDays' => ['nullable', 'integer', 'between:0,4'],
            'answers.internet' => ['nullable', Rule::in(['yes', 'no'])],
            'answers.zoom' => ['nullable', 'boolean'],
            'answers.budget' => ['nullable', 'integer', 'between:0,3'],
            'answers.brand' => ['nullable', 'integer', 'between:0,4'],

            'sketch' => ['nullable', 'array'],
            'sketch.rooms' => ['array', 'max:80'],
            'sketch.rooms.*.x' => ['required', 'numeric', 'between:0,100'],
            'sketch.rooms.*.y' => ['required', 'numeric', 'between:0,100'],
            'sketch.rooms.*.w' => ['required', 'numeric', 'between:0,100'],
            'sketch.rooms.*.h' => ['required', 'numeric', 'between:0,100'],
            'sketch.rooms.*.label' => ['nullable', 'string', 'max:30'],
            'sketch.rooms.*.floor' => ['nullable', Rule::in(['g', 'f1', 'f2', 'roof'])],
            'sketch.pins' => ['array', 'max:150'],
            'sketch.pins.*.t' => ['required', Rule::in(['cam', 'ap', 'net', 'tv', 'rack', 'note'])],
            'sketch.pins.*.x' => ['required', 'numeric', 'between:0,100'],
            'sketch.pins.*.y' => ['required', 'numeric', 'between:0,100'],
            'sketch.pins.*.floor' => ['nullable', Rule::in(['g', 'f1', 'f2', 'roof'])],
            'sketch.generated' => ['nullable', 'boolean'],

            'plan_attached' => ['nullable', 'boolean'],
            'plan_pins' => ['nullable', 'array', 'max:150'],
            'plan_pins.*.t' => [Rule::in(['cam', 'ap', 'net', 'tv', 'rack', 'note'])],
            'plan_pins.*.x' => ['numeric', 'between:0,100'],
            'plan_pins.*.y' => ['numeric', 'between:0,100'],
        ]);

        $phone = $this->normalizeKuwaitiPhone($data['phone']);
        if (! $phone) {
            return $response
                ->setError()
                ->setCode(422)
                ->setMessage('رقم الهاتف غير صحيح. أدخل رقمًا كويتيًا من 8 أرقام.');
        }

        $answers = $data['answers'] + ['sketch' => $data['sketch'] ?? null];

        // Spec rule 4: the estimate and bill of materials are recomputed here.
        $package = $data['package'] !== 'advise'
            ? $recommendations->buildPackage($answers, $data['package'])
            : null;

        $lead = ProjectLead::query()->create([
            'name' => strip_tags($data['name']),
            'phone' => $phone,
            'answers' => [
                ...$data['answers'],
                'sketch' => $data['sketch'] ?? null,
                'plan_attached' => (bool) ($data['plan_attached'] ?? false),
                'plan_pins' => $data['plan_pins'] ?? [],
                'cams' => $recommendations->camCounts($answers),
                'aps' => $recommendations->apCount($answers),
            ],
            'package_tier' => $data['package'],
            'estimate' => $package['total'] ?? null,
            'bom' => $package['items'] ?? null,
            'status' => 'new',
        ]);

        $this->notifyAdmin($lead);

        return $response
            ->setData(['estimate' => $lead->estimate, 'package' => $package])
            ->setMessage('Lead submitted successfully');
    }

    protected function notifyAdmin(ProjectLead $lead): void
    {
        $adminEmail = setting('admin_email', config('mail.from.address'));

        if (! $adminEmail) {
            return;
        }

        $adminEmail = is_array($adminEmail) ? reset($adminEmail) : $adminEmail;

        // Sent after the response so a slow mail server never delays the customer.
        dispatch(function () use ($lead, $adminEmail): void {
            try {
                Mail::send('plugins/system-wizard::emails.lead', ['lead' => $lead], function ($message) use ($adminEmail): void {
                    $storeName = (function_exists('theme_option') ? theme_option('site_title') : null) ?: config('app.name');
                    $message->to($adminEmail)->subject('طلب نظام مراقبة جديد - ' . $storeName);
                });
            } catch (\Throwable $e) {
                Log::error('Failed to send lead email: ' . $e->getMessage());
            }
        })->afterResponse();
    }

    /**
     * Accepts 8-digit local numbers with or without +965/00965 and returns 965XXXXXXXX.
     */
    protected function normalizeKuwaitiPhone(string $phone): ?string
    {
        $normalized = \App\Support\KuwaitPhone::normalize($phone);

        return \App\Support\KuwaitPhone::isKuwaiti($normalized) ? $normalized : null;
    }
}

<?php

namespace Botble\Taly\Providers;

use Botble\Base\Facades\Html;
use Botble\Payment\Enums\PaymentMethodEnum;
use Botble\Payment\Facades\PaymentMethods;
use Botble\Taly\Forms\TalyPaymentMethodForm;
use Botble\Taly\Services\Gateways\TalyPaymentService;
use Illuminate\Http\Request;
use Illuminate\Support\ServiceProvider;

class HookServiceProvider extends ServiceProvider
{
    public function boot(): void
    {
        add_filter(PAYMENT_FILTER_ADDITIONAL_PAYMENT_METHODS, [$this, 'registerTalyMethod'], 1, 2);

        $this->app->booted(function (): void {
            add_filter(PAYMENT_FILTER_AFTER_POST_CHECKOUT, [$this, 'checkoutWithTaly'], 1, 2);
        });

        add_filter(PAYMENT_METHODS_SETTINGS_PAGE, [$this, 'addPaymentSettings'], 1);

        add_filter(BASE_FILTER_ENUM_ARRAY, function ($values, $class) {
            if ($class == PaymentMethodEnum::class) {
                $values['TALY'] = 'taly';
            }

            return $values;
        }, 1, 2);

        add_filter(BASE_FILTER_ENUM_LABEL, function ($value, $class) {
            if ($class == PaymentMethodEnum::class && $value == 'taly') {
                $value = 'Taly';
            }

            return $value;
        }, 1, 2);

        add_filter(BASE_FILTER_ENUM_HTML, function ($value, $class) {
            if ($class == PaymentMethodEnum::class && $value == 'taly') {
                $value = Html::tag(
                    'span',
                    PaymentMethodEnum::getLabel($value),
                    ['class' => 'label-success status-label']
                )
                    ->toHtml();
            }

            return $value;
        }, 1, 2);

        add_filter(PAYMENT_FILTER_GET_SERVICE_CLASS, function ($data, $value) {
            if ($value == 'taly') {
                $data = TalyPaymentService::class;
            }

            return $data;
        }, 1, 2);

        if (is_plugin_active('ecommerce')) {
            add_filter(ECOMMERCE_PRODUCT_DETAIL_EXTRA_HTML, [$this, 'renderTalyWidget'], 1, 2);
        }
    }

    public function renderTalyWidget(?string $html, $product): ?string
    {
        if (! get_payment_setting('status', 'taly')) {
            return $html;
        }

        $merchantId = get_payment_setting('merchant_id', 'taly');
        $currency = get_application_currency()->title;
        $lang = app()->getLocale();

        // Taly requires KWD ISO code
        if (strtoupper($currency) != 'KWD' && $currency == 'دينار كويتي') {
            $currency = 'KWD';
        }

        return $html . view('plugins/taly::widget', [
            'price' => $product->front_sale_price,
            'currency' => $currency,
            'merchantId' => $merchantId,
            'lang' => $lang,
        ])->render();
    }

    public function addPaymentSettings(?string $settings): string
    {
        return $settings . TalyPaymentMethodForm::create()->renderForm();
    }

    public function registerTalyMethod(?string $html, array $data): string
    {
        PaymentMethods::method('taly', [
            'html' => view('plugins/taly::methods', $data)->render(),
        ]);

        return $html;
    }

    public function checkoutWithTaly(array $data, Request $request): array
    {
        if ($data['type'] !== 'taly') {
            return $data;
        }

        $paymentData = apply_filters(PAYMENT_FILTER_PAYMENT_DATA, [], $request);

        $orderId = $paymentData['order_id'][0] ?? $paymentData['order_id'];

        $talyService = $this->app->make(TalyPaymentService::class);

        $checkoutUrl = $talyService->execute([
            'amount' => $paymentData['amount'],
            'currency' => $paymentData['currency'],
            'order_id' => $orderId,
            'callback_url' => route('payments.taly.status'),
            'address' => $paymentData['address'] ?? [],
        ]);

        if ($checkoutUrl) {
            $data['checkoutUrl'] = $checkoutUrl;
        } else {
            $data['error'] = true;
            $data['message'] = $talyService->getErrorMessage();
        }

        return $data;
    }
}

<?php

namespace Botble\Deema\Providers;

use Botble\Deema\Forms\DeemaPaymentMethodForm;
use Botble\Deema\Services\Gateways\DeemaPaymentService;
use Botble\Payment\Enums\PaymentMethodEnum;
use Botble\Payment\Facades\PaymentMethods;
use Illuminate\Http\Request;
use Illuminate\Support\ServiceProvider;

class HookServiceProvider extends ServiceProvider
{
    public function boot(): void
    {
        add_filter(PAYMENT_FILTER_ADDITIONAL_PAYMENT_METHODS, [$this, 'registerDeemaMethod'], 10, 2);
        
        $this->app->booted(function (): void {
            add_filter(PAYMENT_FILTER_AFTER_POST_CHECKOUT, [$this, 'checkoutWithDeema'], 10, 2);
        });

        add_filter(PAYMENT_METHODS_SETTINGS_PAGE, [$this, 'addDeemaSettings'], 1);

        add_filter(BASE_FILTER_ENUM_ARRAY, function ($values, $class) {
            if ($class == PaymentMethodEnum::class) {
                $values['DEEMA'] = 'deema';
            }

            return $values;
        }, 10, 2);

        add_filter(BASE_FILTER_ENUM_LABEL, function ($value, $class) {
            if ($class == PaymentMethodEnum::class && $value == 'deema') {
                $value = 'Deema';
            }

            return $value;
        }, 10, 2);

        if (get_payment_setting('status', 'deema')) {
            add_filter(THEME_FRONT_FOOTER, [$this, 'addDeemaWidgetScript'], 15);
            add_filter(ECOMMERCE_PRODUCT_DETAIL_EXTRA_HTML, [$this, 'addDeemaWidgetToProductPage'], 15, 2);
        }
    }

    public function addDeemaWidgetScript(?string $html): ?string
    {
        $publicKey = get_payment_setting('api_public_key', 'deema');

        if (! $publicKey) {
            return $html . '<!-- DEEMA WIDGET: NO PUBLIC KEY -->';
        }

        $url = get_payment_setting('mode', 'deema') === 'live'
            ? 'https://widget.deema.me/index.js'
            : 'https://sandbox-widget.deema.me/index.js';

        return $html . '<!-- DEEMA WIDGET SCRIPT -->' . view('plugins/deema::widget', compact('publicKey', 'url'))->render();
    }

    public function addDeemaWidgetToProductPage(?string $html, $product): ?string
    {
        if (! get_payment_setting('api_public_key', 'deema')) {
            return $html . '<!-- DEEMA WIDGET: NO PUBLIC KEY FOR TAG -->';
        }

        $amount = $product->front_sale_price;
        $currency = 'KWD'; // Deema mostly KWD

        return $html . '<!-- DEEMA WIDGET TAG -->' . sprintf('<div class="mt-3 mb-3" style="min-height: 50px;"><deema-widget amount="%s" currency="%s"></deema-widget></div>', $amount, $currency);
    }

    public function registerDeemaMethod(?string $html, array $data): string
    {
        PaymentMethods::method('deema', [
            'html' => view('plugins/deema::methods', $data)->render(),
        ]);

        return $html;
    }

    public function addDeemaSettings(?string $settings): string
    {
        return $settings . DeemaPaymentMethodForm::create()->renderForm();
    }

    public function checkoutWithDeema(array $data, Request $request): array
    {
        if ($data['type'] !== 'deema') {
            return $data;
        }

        $deemaPaymentService = $this->app->make(DeemaPaymentService::class);
        $checkoutUrl = $deemaPaymentService->makePayment($request);

        if ($checkoutUrl) {
            $data['checkoutUrl'] = $checkoutUrl;
        } else {
            $data['error'] = true;
            $data['message'] = __('Payment failed or cancelled!');
        }

        return $data;
    }
}

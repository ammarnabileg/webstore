<?php

namespace Botble\Klickpay\Providers;

use Botble\Base\Facades\Html;
use Botble\Payment\Enums\PaymentMethodEnum;
use Botble\Payment\Facades\PaymentMethods;
use Botble\Klickpay\Forms\KlickpayPaymentMethodForm;
use Botble\Klickpay\Services\Gateways\KlickpayPaymentService;
use Illuminate\Http\Request;
use Illuminate\Support\ServiceProvider;

class HookServiceProvider extends ServiceProvider
{
    public function boot(): void
    {
        add_filter(PAYMENT_FILTER_ADDITIONAL_PAYMENT_METHODS, [$this, 'registerklickpayMethod'], 1, 2);

        $this->app->booted(function (): void {
            add_filter(PAYMENT_FILTER_AFTER_POST_CHECKOUT, [$this, 'checkoutWithklickpay'], 1, 2);
        });

        add_filter(PAYMENT_METHODS_SETTINGS_PAGE, [$this, 'addPaymentSettings'], 1);

        add_filter(BASE_FILTER_ENUM_ARRAY, function ($values, $class) {
            if ($class == PaymentMethodEnum::class) {
                $values['klickpay'] = 'klickpay';
            }

            return $values;
        }, 1, 2);

        add_filter(BASE_FILTER_ENUM_LABEL, function ($value, $class) {
            if ($class == PaymentMethodEnum::class && $value == 'klickpay') {
                $value = 'klickpay';
            }

            return $value;
        }, 1, 2);

        add_filter(BASE_FILTER_ENUM_HTML, function ($value, $class) {
            if ($class == PaymentMethodEnum::class && $value == 'klickpay') {
                $value = Html::tag(
                    'span',
                    PaymentMethodEnum::getLabel($value),
                    ['class' => 'label-success status-label']
                )->toHtml();
            }

            return $value;
        }, 1, 2);

        add_filter(PAYMENT_FILTER_GET_SERVICE_CLASS, function ($data, $value) {
            if ($value == 'klickpay') {
                $data = klickpayPaymentService::class;
            }

            return $data;
        }, 1, 2);
    }

    public function addPaymentSettings(?string $settings): string
    {
        return $settings . klickpayPaymentMethodForm::create()->renderForm();
    }

    public function registerklickpayMethod(?string $html, array $data): string
    {
        PaymentMethods::method('klickpay', [
            'html' => view('plugins/klickpay::methods', $data)->render(),
        ]);

        return $html;
    }

    public function checkoutWithklickpay(array $data, Request $request): array
    {
        if ($data['type'] !== 'klickpay') {
            return $data;
        }

        $paymentData = apply_filters(PAYMENT_FILTER_PAYMENT_DATA, [], $request);

        $orderIds = (array)$paymentData['order_id'];
        $orderId = reset($orderIds);

        $klickpayService = $this->app->make(klickpayPaymentService::class);

        $checkoutUrl = $klickpayService->execute([
            'amount' => $paymentData['amount'],
            'currency' => $paymentData['currency'],
            'order_id' => $orderId,
            'callback_url' => route('payments.klickpay.status'),
            'address' => $paymentData['address'] ?? [],
        ]);

        if ($checkoutUrl) {
            $data['checkoutUrl'] = $checkoutUrl;
        } else {
            $data['error'] = true;
            $data['message'] = $klickpayService->getErrorMessage();
        }

        return $data;
    }
}

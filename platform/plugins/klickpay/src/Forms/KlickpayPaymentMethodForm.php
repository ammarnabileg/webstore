<?php

namespace Botble\Klickpay\Forms;

use Botble\Base\Forms\FieldOptions\TextFieldOption;
use Botble\Base\Forms\Fields\TextField;
use Botble\Payment\Forms\PaymentMethodForm;

class KlickpayPaymentMethodForm extends PaymentMethodForm
{
    public function setup(): void
    {
        parent::setup();

        $this
            ->paymentId('klickpay')
            ->paymentName('klickpay')
            ->paymentDescription('Customer can buy product and pay directly using klickpay (KNET, Apple Pay, etc).')
            ->paymentLogo(url('plugins/klickpay/images/klickpay.png'))
            ->paymentUrl('https://klickpay.com')
            ->add(
                'payment_klickpay_static_token',
                TextField::class,
                TextFieldOption::make()
                    ->label('Static Access Token (Optional)')
                    ->value(get_payment_setting('static_token', 'klickpay'))
                    ->helperText('If you provide a static web token (valid for years), it will be used instead of Client ID/Secret to generate tokens.')
                    ->toArray()
            )
            ->add(
                'payment_klickpay_client_id',
                TextField::class,
                TextFieldOption::make()
                    ->label('Client ID')
                    ->value(get_payment_setting('client_id', 'klickpay'))
                    ->toArray()
            )
            ->add(
                'payment_klickpay_client_secret',
                'password',
                TextFieldOption::make()
                    ->label('Client Secret')
                    ->value(get_payment_setting('client_secret', 'klickpay'))
                    ->toArray()
            )
            ->add(
                'payment_klickpay_webhook_secret',
                'password',
                TextFieldOption::make()
                    ->label('Webhook Secret')
                    ->value(get_payment_setting('webhook_secret', 'klickpay'))
                    ->toArray()
            )
            ->add(
                'payment_klickpay_environment',
                'select',
                [
                    'label' => 'Environment',
                    'choices' => [
                        'staging' => 'Staging (Sandbox)',
                        'production' => 'Production',
                    ],
                    'selected' => get_payment_setting('environment', 'klickpay', 'staging'),
                ]
            );
    }
}

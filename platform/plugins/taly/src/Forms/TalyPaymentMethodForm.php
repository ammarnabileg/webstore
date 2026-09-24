<?php

namespace Botble\Taly\Forms;

use Botble\Base\Facades\BaseHelper;
use Botble\Base\Forms\FieldOptions\CheckboxFieldOption;
use Botble\Base\Forms\FieldOptions\TextFieldOption;
use Botble\Base\Forms\Fields\OnOffCheckboxField;
use Botble\Base\Forms\Fields\TextField;
use Botble\Payment\Concerns\Forms\HasAvailableCountriesField;
use Botble\Payment\Forms\PaymentMethodForm;

class TalyPaymentMethodForm extends PaymentMethodForm
{
    use HasAvailableCountriesField;

    public function setup(): void
    {
        parent::setup();

        $this
            ->paymentId('taly')
            ->paymentName('Taly')
            ->paymentDescription('Taly Buy Now Pay Later - پرداخت اقساطی تالی')
            ->paymentLogo(url('vendor/core/plugins/taly/images/taly.png'))
            ->paymentFeeField('taly')
            ->paymentUrl('https://taly.io')
            ->defaultDescriptionValue('Redirecting to Taly for payment...')
            ->add(
                sprintf('payment_%s_merchant_id', 'taly'),
                TextField::class,
                TextFieldOption::make()
                    ->label('Merchant ID (Public Key)')
                    ->value(BaseHelper::hasDemoModeEnabled() ? '*******************************' : get_payment_setting('merchant_id', 'taly'))
            )
            ->add(
                sprintf('payment_%s_secret_key', 'taly'),
                'password',
                TextFieldOption::make()
                    ->label('Secret Key')
                    ->value(BaseHelper::hasDemoModeEnabled() ? '*******************************' : get_payment_setting('secret_key', 'taly'))
            )
            ->add(
                sprintf('payment_%s_mode', 'taly'),
                OnOffCheckboxField::class,
                CheckboxFieldOption::make()
                    ->label(trans('plugins/payment::payment.live_mode'))
                    ->value(get_payment_setting('mode', 'taly', true))
            )
            ->addAvailableCountriesField('taly');
    }
}

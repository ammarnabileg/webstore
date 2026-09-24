<?php

namespace Botble\Deema\Forms;

use Botble\Base\Facades\BaseHelper;
use Botble\Base\Forms\FieldOptions\SelectFieldOption;
use Botble\Base\Forms\FieldOptions\TextFieldOption;
use Botble\Base\Forms\Fields\SelectField;
use Botble\Base\Forms\Fields\TextField;
use Botble\Payment\Concerns\Forms\HasAvailableCountriesField;
use Botble\Payment\Forms\PaymentMethodForm;

class DeemaPaymentMethodForm extends PaymentMethodForm
{
    use HasAvailableCountriesField;

    public function setup(): void
    {
        parent::setup();

        $this
            ->paymentId('deema')
            ->paymentName('Deema')
            ->paymentDescription('Deema Buy Now Pay Later - اشتر الآن وادفع لاحقاً مع ديما')
            ->paymentLogo(url('vendor/core/plugins/deema/images/deema.png'))
            ->paymentFeeField('deema')
            ->paymentUrl('https://deema.me')
            ->defaultDescriptionValue('Redirecting to Deema for payment...')
            ->add(
                sprintf('payment_%s_api_key', 'deema'),
                'password',
                TextFieldOption::make()
                    ->label(trans('plugins/deema::deema.api_key'))
                    ->value(BaseHelper::hasDemoModeEnabled() ? '*******************************' : get_payment_setting('api_key', 'deema'))
            )
            ->add(
                sprintf('payment_%s_api_public_key', 'deema'),
                'password',
                TextFieldOption::make()
                    ->label(trans('plugins/deema::deema.api_public_key'))
                    ->value(BaseHelper::hasDemoModeEnabled() ? '*******************************' : get_payment_setting('api_public_key', 'deema'))
            )
            ->add(
                sprintf('payment_%s_mode', 'deema'),
                SelectField::class,
                SelectFieldOption::make()
                    ->label(trans('plugins/deema::deema.mode'))
                    ->choices([
                        'sandbox' => trans('plugins/deema::deema.sandbox'),
                        'live' => trans('plugins/deema::deema.live'),
                    ])
                    ->selected(get_payment_setting('mode', 'deema', 'sandbox'))
            )
            ->addAvailableCountriesField('deema');
    }
}

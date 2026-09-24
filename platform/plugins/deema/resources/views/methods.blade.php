@if (get_payment_setting('status', 'deema'))
    <x-plugins-payment::payment-method
        name="deema"
        :paymentName="trans('plugins/deema::deema.name')"
        :paymentLogo="url('vendor/core/plugins/deema/images/deema.png')"
    />
@endif

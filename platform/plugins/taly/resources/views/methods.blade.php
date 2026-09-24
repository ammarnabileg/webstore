@if (get_payment_setting('status', 'taly'))
    <x-plugins-payment::payment-method
        name="taly"
        :paymentName="trans('plugins/taly::taly.name')"
        :paymentLogo="url('vendor/core/plugins/taly/images/taly.png')"
    />
@endif

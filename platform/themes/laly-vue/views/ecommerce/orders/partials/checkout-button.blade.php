@php
    $checkoutOrderAmount = $orderAmount ?? Cart::instance('cart')->rawTotal();
    $isOrderFree = $checkoutOrderAmount == 0;
    $checkoutButtonText = $isOrderFree
        ? trans('plugins/ecommerce::ecommerce.complete_order')
        : trans('plugins/ecommerce::ecommerce.checkout');
@endphp

@if (EcommerceHelper::isValidToProcessCheckout())
    <button
        class="btn btn-checkout payment-checkout-btn payment-checkout-btn-step"
        data-processing-text="{{ __('Processing. Please wait...') }}"
        data-error-header="{{ __('Error') }}"
        type="submit"
    >
        {{ $checkoutButtonText }}
    </button>
@else
    <span class="btn btn-checkout payment-checkout-btn-step disabled">
        {{ $checkoutButtonText }}
    </span>
@endif



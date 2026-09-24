@if (get_payment_setting('status', 'klickpay') == 1)
    <li class="list-group-item">
        <input class="magic-radio js_payment_method" type="radio" name="payment_method" id="payment_klickpay"
               value="klickpay" @if ($selecting == 'klickpay') checked @endif>
        <label for="payment_klickpay" class="text-start">
            {{ get_payment_setting('name', 'klickpay', 'Pay securely with klickpay (KNET, Credit Card, Apple Pay)') }}
        </label>
        <div class="payment_klickpay_wrap payment_collapse_wrap collapse @if ($selecting == 'klickpay') show @endif" style="padding: 15px 0;">
            <p>{!! get_payment_setting('description', 'klickpay', __('You will be redirected to klickpay secure checkout page to complete your purchase.')) !!}</p>
            
            <div style="display: flex; gap: 10px; flex-wrap: wrap; margin-top: 10px;">
                <img src="{{ url('plugins/klickpay/images/klickpay.png') }}" alt="klickpay" style="height: 30px; object-fit: contain; border-radius: 4px; background: #fff; padding: 2px;">
                <img src="https://klickpay.com/KP-APID/images/knet.png" alt="KNET" style="height: 30px; object-fit: contain;" onerror="this.style.display='none'">
                <img src="https://klickpay.com/KP-APID/images/applepay.png" alt="Apple Pay" style="height: 30px; object-fit: contain;" onerror="this.style.display='none'">
                <img src="https://klickpay.com/KP-APID/images/visa.png" alt="Visa" style="height: 30px; object-fit: contain;" onerror="this.style.display='none'">
                <img src="https://klickpay.com/KP-APID/images/mastercard.png" alt="MasterCard" style="height: 30px; object-fit: contain;" onerror="this.style.display='none'">
            </div>
        </div>
    </li>
@endif

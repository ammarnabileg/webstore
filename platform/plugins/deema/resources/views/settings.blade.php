<table class="table payment-method-item">
    <tbody>
    <tr class="payment-method-header">
        <td class="payment-method-img">
            <img src="{{ url('vendor/core/plugins/deema/images/deema.png') }}"
                 alt="Deema">
        </td>
        <td class="payment-method-name">
            <div>
                <strong>Deema</strong>
                <p class="mb-0">{{ trans('plugins/deema::deema.description') }}</p>
            </div>
        </td>
        <td class="payment-method-action text-end">
            @if (get_payment_setting('status', 'deema'))
                <a class="btn btn-danger disable-payment-item"
                   data-type="deema"
                   data-name="Deema"
                   data-set-payment-url="{{ route('payments.methods.post') }}">
                    {{ trans('plugins/deema::deema.deactivate') }}
                </a>
            @else
                <a class="btn btn-info active-payment-item"
                   data-type="deema"
                   data-name="Deema"
                   data-set-payment-url="{{ route('payments.methods.post') }}">
                    {{ trans('plugins/deema::deema.activate') }}
                </a>
            @endif
        </td>
    </tr>
    <tr class="payment-method-content @if (!get_payment_setting('status', 'deema')) d-none @endif">
        <td colspan="3">
            <div class="payment-method-settings">
                <div class="mb-3">
                    <label class="text-title-field"
                           for="payment_deema_name">{{ trans('plugins/deema::deema.name') }}</label>
                    <input type="text" class="next-input" name="payment_deema_name"
                           id="payment_deema_name"
                           value="{{ get_payment_setting('name', 'deema', 'Deema') }}">
                </div>
                <div class="mb-3">
                    <label class="text-title-field"
                           for="payment_deema_api_key">{{ trans('plugins/deema::deema.api_key') }}</label>
                    <input type="password" class="next-input" name="payment_deema_api_key"
                           id="payment_deema_api_key"
                           value="{{ get_payment_setting('api_key', 'deema') }}"
                           placeholder="your_bearer_token">
                </div>
                <div class="mb-3">
                    <label class="text-title-field"
                           for="payment_deema_mode">{{ trans('plugins/deema::deema.mode') }}</label>
                    <select name="payment_deema_mode" class="next-input" id="payment_deema_mode">
                        <option value="sandbox"
                                @if (get_payment_setting('mode', 'deema', 'sandbox') == 'sandbox') selected @endif>
                            {{ trans('plugins/deema::deema.sandbox') }}
                        </option>
                        <option value="live"
                                @if (get_payment_setting('mode', 'deema') == 'live') selected @endif>
                            {{ trans('plugins/deema::deema.live') }}
                        </option>
                    </select>
                </div>

                @include('plugins/payment::partials.instructions', ['name' => 'deema'])
            </div>
        </td>
    </tr>
    </tbody>
</table>

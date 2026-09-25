<?php

namespace App\Http\Middleware;

use App\Support\KuwaitPhone;
use Botble\Ecommerce\Facades\EcommerceHelper;
use Botble\Ecommerce\Models\Customer;
use Closure;
use Illuminate\Http\Request;

/**
 * Phones are stored as 965XXXXXXXX, but Botble's customer forms compare what was typed.
 * - Login: when the typed login is not an email and its normalized form belongs to a customer,
 *   log in with that form ("5551 2345" and "+965 55512345" both work).
 * - Register / edit account: validate the normalized phone, so the unique-phone rule sees
 *   "55512345" and "96555512345" as the same number.
 */
class NormalizeCustomerPhoneInput
{
    public function handle(Request $request, Closure $next)
    {
        $phone = $request->input('phone');

        if (is_string($phone) && ($normalized = KuwaitPhone::normalize($phone))) {
            $request->merge(['phone' => $normalized]);
        }

        $typed = $request->input('email');

        if (is_string($typed) && ! str_contains($typed, '@')
            && in_array(EcommerceHelper::getLoginOption(), ['phone', 'email_or_phone'], true)) {
            $normalized = KuwaitPhone::normalize($typed);

            if ($normalized && $normalized !== $typed && Customer::query()->where('phone', $normalized)->exists()) {
                $request->merge(['email' => $normalized]);
            }
        }

        return $next($request);
    }
}

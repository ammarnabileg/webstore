<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Log;
use Botble\Ecommerce\Models\Customer;
use Botble\Ecommerce\Enums\CustomerStatusEnum;
use App\Services\EvolutionApiService;
use App\Support\KuwaitPhone;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Str;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\RateLimiter;

class WhatsAppAuthController extends Controller
{
    private const OTP_TTL_MINUTES = 15;

    /** Lets only this flow save the reserved "<phone>@whatsapp.local" placeholder email. */
    public static bool $creatingPlaceholderAccount = false;

    private const OTP_MAX_ATTEMPTS = 5;

    protected $evolutionApi;

    public function __construct(EvolutionApiService $evolutionApi)
    {
        $this->evolutionApi = $evolutionApi;
    }

    /**
     * Send OTP and Magic Link via WhatsApp
     */
    public function sendOtp(Request $request)
    {
        $request->validate([
            'phone' => 'required|string|max:20',
        ]);

        $phone = $this->formatPhoneNumber($request->input('phone'));

        if (! $phone) {
            return response()->json(['status' => 'error', 'message' => 'Invalid phone number'], 422);
        }

        if ($limited = $this->tooManySends($request, $phone)) {
            return $limited;
        }

        $otp = $this->issueOtp($phone);

        // Generate Magic Link
        $token = Str::random(60);
        Cache::put("wa_magic_{$token}", $phone, now()->addMinutes(self::OTP_TTL_MINUTES));
        $link = route('whatsapp.magic.login', ['token' => $token]);

        $storeName = $this->storeName();
        if (app()->getLocale() === 'en') {
            $message = "Welcome to {$storeName} 👋\n\n";
            $message .= "Use this one-time code to sign in:\n*{$otp}*\n\n";
            $message .= "Or sign in instantly with this link:\n{$link}\n\n";
            $message .= "_Valid for " . self::OTP_TTL_MINUTES . " minutes._";
        } else {
            $message = "مرحباً بك في {$storeName} 👋\n\n";
            $message .= "للدخول لحسابك، يمكنك استخدام الكود السري التالي:\n*{$otp}*\n\n";
            $message .= "أو يمكنك الدخول فوراً بالضغط على الرابط السحري:\n{$link}\n\n";
            $message .= "_صالح لمدة " . self::OTP_TTL_MINUTES . " دقيقة._";
        }

        $sent = $this->evolutionApi->sendMessage($phone, $message);

        if ($sent) {
            return response()->json(['status' => 'success', 'message' => 'Auth message sent successfully']);
        }

        return response()->json(['status' => 'error', 'message' => 'Failed to send Auth message'], 500);
    }

    /**
     * Verify OTP and Login/Register
     */
    public function verifyOtp(Request $request)
    {
        $request->validate([
            'phone' => 'required|string|max:20',
            'otp' => 'required|string|max:10',
        ]);

        $phone = $this->formatPhoneNumber($request->input('phone'));

        if (! $phone || ! $this->consumeOtp($phone, (string) $request->input('otp'))) {
            return response()->json(['status' => 'error', 'message' => 'Invalid or expired OTP'], 400);
        }

        $customer = $this->findOrCreateVerifiedCustomer($phone);

        if ($this->isLocked($customer)) {
            return response()->json(['status' => 'error', 'message' => 'هذا الحساب موقوف. يرجى التواصل مع الدعم'], 403);
        }

        $needsOnboarding = $this->needsOnboarding($customer);

        Auth::guard('customer')->login($customer, true);

        return response()->json([
            'status' => 'success',
            'message' => 'Logged in successfully',
            'needs_onboarding' => $needsOnboarding,
            'redirect' => route('customer.overview')
        ]);
    }

    /**
     * Send Magic Link via WhatsApp
     */
    public function sendMagicLink(Request $request)
    {
        $request->validate([
            'phone' => 'required|string|max:20',
        ]);

        $phone = $this->formatPhoneNumber($request->input('phone'));

        if (! $phone) {
            return response()->json(['status' => 'error', 'message' => 'Invalid phone number'], 422);
        }

        if ($limited = $this->tooManySends($request, $phone)) {
            return $limited;
        }

        $token = Str::random(60);

        // Cache Token for 15 minutes
        Cache::put("wa_magic_{$token}", $phone, now()->addMinutes(15));

        $link = route('whatsapp.magic.login', ['token' => $token]);
        if (app()->getLocale() === 'en') {
            $message = "Hello,\nClick the link below to sign in quickly:\n{$link}\n\nThis link is valid for 15 minutes.";
        } else {
            $message = "مرحباً،\nانقر على الرابط التالي لتسجيل الدخول السريع:\n{$link}\n\nهذا الرابط صالح لمدة 15 دقيقة.";
        }

        $sent = $this->evolutionApi->sendMessage($phone, $message);

        if ($sent) {
            return response()->json(['status' => 'success', 'message' => 'Magic Link sent successfully']);
        }

        return response()->json(['status' => 'error', 'message' => 'Failed to send Magic Link'], 500);
    }

    /**
     * Login via Magic Link
     */
    public function magicLogin($token)
    {
        // pull() reads and deletes in one step so a link can only be used once.
        $phone = Cache::pull("wa_magic_{$token}");

        if (!$phone) {
            return redirect()->route('customer.login')->with('error_msg', 'الرابط السحري غير صالح أو منتهي الصلاحية');
        }

        $customer = $this->findOrCreateVerifiedCustomer($phone);

        if ($this->isLocked($customer)) {
            return redirect()->route('customer.login')->with('error_msg', 'هذا الحساب موقوف. يرجى التواصل مع الدعم');
        }

        $needsOnboarding = $this->needsOnboarding($customer);

        Auth::guard('customer')->login($customer, true);

        if ($needsOnboarding) {
            return redirect(route('customer.login') . '?step=complete_profile');
        }

        return redirect()->route('public.index')->with('success_msg', 'تم تسجيل الدخول بنجاح');
    }
    
    /**
     * Complete Profile for new WhatsApp users
     */
    public function completeProfile(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
        ]);

        $customer = Auth::guard('customer')->user();
        if (!$customer) {
            return response()->json(['status' => 'error', 'message' => 'Unauthenticated'], 401);
        }

        // Email/password can be set without the current password only ONCE, while the account is
        // still finishing WhatsApp sign-up (profile_completed_at is null). Afterwards this endpoint
        // must not become a password reset for whoever holds the session. Using a one-time flag
        // instead of the placeholder email closes the permanent waiver on accounts that kept the
        // "<phone>@whatsapp.local" placeholder.
        $isOnboarding = $this->needsOnboarding($customer);

        if (! $isOnboarding && ($request->filled('email') || $request->filled('password'))) {
            $request->validate(['current_password' => 'required|string']);

            if (! Hash::check($request->input('current_password'), $customer->password)) {
                return response()->json(['status' => 'error', 'message' => 'كلمة المرور الحالية غير صحيحة'], 422);
            }
        }

        $customer->name = $request->input('name');

        if ($request->filled('email')) {
            $request->validate([
                'email' => 'email|max:255|unique:ec_customers,email,' . $customer->id,
            ]);
            $customer->email = $request->input('email');
        }
        
        if ($request->filled('password')) {
            $request->validate([
                'password' => 'string|min:6|confirmed',
            ]);
            $customer->password = bcrypt($request->input('password'));
        }

        // Onboarding is a one-time state: once the profile is completed, later credential changes
        // must supply the current password (handled by the $isOnboarding gate above).
        if ($isOnboarding) {
            $customer->profile_completed_at = now();
        }

        $customer->save();

        return response()->json([
            'status' => 'success',
            'message' => 'تم تحديث الملف الشخصي بنجاح',
            'redirect' => route('public.index')
        ]);
    }

    /**
     * A WhatsApp account is still "onboarding" until it has completed its profile once.
     * Tracked by profile_completed_at (set on first completeProfile / registerWithOtp) rather
     * than the placeholder email, so the no-current-password waiver cannot be reused.
     */
    private function needsOnboarding(Customer $customer): bool
    {
        return $customer->profile_completed_at === null;
    }

    /** Store name for outbound WhatsApp copy: the admin-set site title, not a hardcoded brand. */
    private function storeName(): string
    {
        $name = function_exists('theme_option') ? theme_option('site_title') : null;

        return $name ?: config('app.name', 'المتجر');
    }

    /** OTP / magic-link login must honour the same locked-account gate as password login. */
    private function isLocked(Customer $customer): bool
    {
        $status = $customer->status instanceof CustomerStatusEnum
            ? $customer->status->getValue()
            : $customer->status;

        return $status !== CustomerStatusEnum::ACTIVATED;
    }

    /**
     * Register with OTP verification
     */
    public function registerWithOtp(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'phone' => 'required|string|max:20',
            'otp' => 'required|string|max:10',
            'email' => 'nullable|email|max:255',
            'password' => 'required|string|min:6|confirmed',
        ]);

        $phone = $this->formatPhoneNumber($request->input('phone'));

        if (! $phone || ! $this->consumeOtp($phone, (string) $request->input('otp'))) {
            return response()->json(['status' => 'error', 'message' => 'Invalid or expired OTP'], 400);
        }

        // Only accounts that proved ownership of this number count as "already registered".
        $customer = Customer::where('phone', $phone)->whereNotNull('phone_verified_at')->first();

        if ($customer) {
            return response()->json(['status' => 'error', 'message' => 'رقم الهاتف مسجل مسبقاً'], 400);
        }
        
        $email = $request->input('email');
        if ($email) {
            $existingEmail = Customer::where('email', $email)->first();
            if ($existingEmail) {
                return response()->json(['status' => 'error', 'message' => 'البريد الإلكتروني مسجل مسبقاً'], 400);
            }
        } else {
            $email = $phone . '@whatsapp.local';
        }

        $customer = Customer::create([
            'name' => $request->input('name'),
            'email' => $email,
            'phone' => $phone,
            'password' => bcrypt($request->input('password')),
            'status' => 'activated',
        ]);
        // Registered directly with their own password + (optional) email -> profile is complete,
        // so future credential changes require the current password.
        $customer->forceFill(['phone_verified_at' => now(), 'profile_completed_at' => now()])->save();

        Auth::guard('customer')->login($customer, true);

        return response()->json([
            'status' => 'success',
            'message' => 'تم التسجيل بنجاح',
            'redirect' => route('customer.overview')
        ]);
    }

    /**
     * WhatsApp login only enters an account whose phone number was itself proven by an OTP or
     * magic link. The phone on normal accounts is free text: matching on it would let anyone
     * put a victim's number on their own account and receive the victim's WhatsApp login.
     */
    private function findOrCreateVerifiedCustomer(string $phone): Customer
    {
        $customer = Customer::where('phone', $phone)->whereNotNull('phone_verified_at')->first()
            // Accounts created by this flow before phone_verified_at existed (the migration
            // backfills these; this covers rows created between deploy and migrate).
            ?? Customer::where('email', $phone . '@whatsapp.local')->where('phone', $phone)->first();

        if (! $customer) {
            static::$creatingPlaceholderAccount = true;

            try {
                $customer = Customer::create([
                    'name' => 'User ' . substr($phone, -4),
                    'email' => $phone . '@whatsapp.local', // Placeholder email as Botble requires it
                    'phone' => $phone,
                    'password' => bcrypt(Str::random(16)),
                    'status' => 'activated',
                ]);
            } finally {
                static::$creatingPlaceholderAccount = false;
            }
        }

        if (! $customer->phone_verified_at) {
            $customer->forceFill(['phone_verified_at' => now(), 'phone' => $phone])->save();
        }

        return $customer;
    }

    private function issueOtp(string $phone): string
    {
        $otp = (string) random_int(100000, 999999);

        Cache::put("wa_otp_{$phone}", [
            'hash' => hash_hmac('sha256', $otp, (string) config('app.key')),
            'attempts' => 0,
        ], now()->addMinutes(self::OTP_TTL_MINUTES));

        return $otp;
    }

    /**
     * Checks an OTP and burns it after success or after too many wrong guesses.
     */
    private function consumeOtp(string $phone, string $otp): bool
    {
        $key = "wa_otp_{$phone}";

        return Cache::lock("{$key}_lock", 5)->block(3, function () use ($key, $otp) {
            $entry = Cache::get($key);

            if (! is_array($entry) || ! isset($entry['hash'])) {
                return false;
            }

            if (hash_equals($entry['hash'], hash_hmac('sha256', trim($otp), (string) config('app.key')))) {
                Cache::forget($key);

                return true;
            }

            $entry['attempts'] = ($entry['attempts'] ?? 0) + 1;

            if ($entry['attempts'] >= self::OTP_MAX_ATTEMPTS) {
                Cache::forget($key);
            } else {
                Cache::put($key, $entry, now()->addMinutes(self::OTP_TTL_MINUTES));
            }

            return false;
        });
    }

    /**
     * Limits how often WhatsApp messages can be triggered, per phone and per IP,
     * so the endpoints cannot be used to spam numbers or get the sender banned.
     */
    private function tooManySends(Request $request, string $phone): ?JsonResponse
    {
        $keys = [
            'wa_send_phone:' . $phone => 5,
            'wa_send_ip:' . $request->ip() => 10,
        ];

        foreach ($keys as $key => $max) {
            if (RateLimiter::tooManyAttempts($key, $max)) {
                return response()->json([
                    'status' => 'error',
                    'message' => 'محاولات كثيرة، حاول مرة أخرى بعد ' . ceil(RateLimiter::availableIn($key) / 60) . ' دقيقة',
                ], 429);
            }
        }

        foreach (array_keys($keys) as $key) {
            RateLimiter::hit($key, 3600);
        }

        return null;
    }

    private function formatPhoneNumber($phone): ?string
    {
        return is_string($phone) ? KuwaitPhone::normalize($phone) : null;
    }
}

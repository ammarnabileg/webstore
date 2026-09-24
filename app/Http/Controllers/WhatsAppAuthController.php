<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Log;
use Botble\Ecommerce\Models\Customer;
use App\Services\EvolutionApiService;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Str;
use Carbon\Carbon;

class WhatsAppAuthController extends Controller
{
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
            'phone' => 'required|string',
        ]);

        $phone = $this->formatPhoneNumber($request->input('phone'));
        
        // Generate OTP
        $otp = rand(100000, 999999);
        Cache::put("wa_otp_{$phone}", $otp, now()->addMinutes(15));
        
        // Generate Magic Link
        $token = Str::random(60);
        Cache::put("wa_magic_{$token}", $phone, now()->addMinutes(15));
        $link = route('whatsapp.magic.login', ['token' => $token]);

        $message = "مرحباً بك في موقعنا 👋\n\n";
        $message .= "للدخول لحسابك، يمكنك استخدام الكود السري التالي:\n*{$otp}*\n\n";
        $message .= "أو يمكنك الدخول فوراً بالضغط على الرابط السحري:\n{$link}\n\n";
        $message .= "_صالح لمدة 15 دقيقة._";
        
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
            'phone' => 'required|string',
            'otp' => 'required|string',
        ]);

        $phone = $this->formatPhoneNumber($request->input('phone'));
        $otp = $request->input('otp');

        $cachedOtp = Cache::get("wa_otp_{$phone}");

        if (!$cachedOtp || $cachedOtp != $otp) {
            return response()->json(['status' => 'error', 'message' => 'Invalid or expired OTP'], 400);
        }

        Cache::forget("wa_otp_{$phone}");

        // Find or create customer
        $customer = Customer::where('phone', $phone)->first();

        if (!$customer) {
            $customer = Customer::create([
                'name' => 'User ' . substr($phone, -4),
                'email' => $phone . '@whatsapp.local', // Placeholder email as Botble requires it
                'phone' => $phone,
                'password' => bcrypt(Str::random(16)),
                'status' => 'activated',
            ]);
        }

        $needsOnboarding = str_ends_with($customer->email, '@whatsapp.local');

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
            'phone' => 'required|string',
        ]);

        $phone = $this->formatPhoneNumber($request->input('phone'));
        $token = Str::random(60);

        // Cache Token for 15 minutes
        Cache::put("wa_magic_{$token}", $phone, now()->addMinutes(15));

        $link = route('whatsapp.magic.login', ['token' => $token]);
        $message = "مرحباً،\nانقر على الرابط التالي لتسجيل الدخول السريع:\n{$link}\n\nهذا الرابط صالح لمدة 15 دقيقة.";
        
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
        $phone = Cache::get("wa_magic_{$token}");

        if (!$phone) {
            return redirect()->route('customer.login')->with('error_msg', 'الرابط السحري غير صالح أو منتهي الصلاحية');
        }

        Cache::forget("wa_magic_{$token}");

        $customer = Customer::where('phone', $phone)->first();

        if (!$customer) {
            $customer = Customer::create([
                'name' => 'User ' . substr($phone, -4),
                'email' => $phone . '@whatsapp.local',
                'phone' => $phone,
                'password' => bcrypt(Str::random(16)),
                'status' => 'activated',
            ]);
        }
        
        $needsOnboarding = str_ends_with($customer->email, '@whatsapp.local');

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

        $customer->name = $request->input('name');
        
        if ($request->filled('email')) {
            $request->validate([
                'email' => 'email|unique:ec_customers,email,' . $customer->id,
            ]);
            $customer->email = $request->input('email');
        }
        
        if ($request->filled('password')) {
            $request->validate([
                'password' => 'string|min:6|confirmed',
            ]);
            $customer->password = bcrypt($request->input('password'));
        }

        $customer->save();

        return response()->json([
            'status' => 'success', 
            'message' => 'تم تحديث الملف الشخصي بنجاح',
            'redirect' => route('public.index')
        ]);
    }

    /**
     * Register with OTP verification
     */
    public function registerWithOtp(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'phone' => 'required|string',
            'otp' => 'required|string',
            'password' => 'required|string|min:6|confirmed',
        ]);

        $phone = $this->formatPhoneNumber($request->input('phone'));
        $otp = $request->input('otp');

        $cachedOtp = Cache::get("wa_otp_{$phone}");

        if (!$cachedOtp || $cachedOtp != $otp) {
            return response()->json(['status' => 'error', 'message' => 'Invalid or expired OTP'], 400);
        }

        Cache::forget("wa_otp_{$phone}");

        // Check if customer exists
        $customer = Customer::where('phone', $phone)->first();

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

        Auth::guard('customer')->login($customer, true);

        return response()->json([
            'status' => 'success', 
            'message' => 'تم التسجيل بنجاح',
            'redirect' => route('customer.overview')
        ]);
    }

    private function formatPhoneNumber($phone)
    {
        // Remove all non-numeric characters
        $phone = preg_replace('/[^0-9]/', '', $phone);
        // Ensure it has country code if needed (assuming defaults if required)
        return $phone;
    }
}

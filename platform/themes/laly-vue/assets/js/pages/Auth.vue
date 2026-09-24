<template>
  <div class="page">
    <div class="nbar">
      <div class="nbar-title">{{ __('login_register') || 'تسجيل الدخول / إنشاء حساب' }}</div>
    </div>
    
    <div class="scroll" style="padding: 16px;">
      
      <div class="auth-container mt-4 mb-5">
        <div class="row g-0 rounded-4 shadow-sm overflow-hidden" style="border: 1px solid var(--border2); background: var(--bg);">
            
            <!-- Main Content Area -->
            <div class="col-12 p-4 p-md-5">
                
                <!-- Classic Login Form -->
                <div v-if="step === 'classic_login'" class="text-center">
                    <h3 class="fw-bold mb-4">{{ __('تسجيل الدخول') }}</h3>
                    
                    <form @submit.prevent="classicLogin">
                        <div class="form-group mb-3 text-start">
                            <label class="mb-1 text-muted">{{ __('البريد الإلكتروني أو رقم الهاتف') }}</label>
                            <div class="d-flex align-items-center form-control form-control-lg p-0" :style="isPhoneInput ? 'border-radius: 12px; height: 50px; overflow: hidden; direction: ltr;' : 'border-radius: 12px; height: 50px; padding-left: 1rem !important; padding-right: 1rem !important; overflow: hidden; direction: ltr;'">
                                <span v-if="isPhoneInput" class="px-3 fw-bold" style="background-color: rgba(128,128,128,0.1); height: 100%; display: flex; align-items: center; border-right: 1px solid var(--border-color, #ced4da); white-space: nowrap; color: inherit;">🇰🇼 +965</span>
                                <input type="text" class="form-control form-control-lg border-0 shadow-none flex-grow-1 px-3 h-100 w-100" v-model="classicForm.email" @input="checkInputType" required style="background-color: transparent !important; color: inherit; outline: none;" :placeholder="__('Email or Phone')">
                            </div>
                        </div>
                        <div class="form-group mb-4 text-start">
                            <label class="mb-1 text-muted">{{ __('كلمة المرور') }}</label>
                            <input type="password" class="form-control form-control-lg" v-model="classicForm.password" required style="border-radius: 12px; height: 50px;">
                        </div>
                        <button type="submit" class="btn btn-primary btn-lg w-100 fw-bold mb-3 text-white" :disabled="loading" style="border-radius: 12px; height: 50px; background-color: var(--primary); border: none;">
                            <span v-if="!loading">{{ __('دخول') }}</span>
                            <span v-else>{{ __('جاري التحقق...') }}</span>
                        </button>
                    </form>

                    <div class="d-flex align-items-center my-4">
                        <hr class="flex-grow-1">
                        <span class="mx-3 text-muted">{{ __('أو الدخول بواسطة') }}</span>
                        <hr class="flex-grow-1">
                    </div>

                    <!-- Social Login Buttons -->
                    <div class="d-flex flex-column gap-3">
                        <button @click="step = 'wa_phone'" class="btn btn-lg w-100 fw-bold d-flex align-items-center justify-content-center gap-2" style="border-radius: 12px; height: 50px; background-color: #25D366; color: white; border: none;">
                            <i class="ti ti-brand-whatsapp fs-4"></i> {{ __('واتساب') }}
                        </button>
                        
                        <template v-if="botbleData.socialLogins && botbleData.socialLogins.length">
                            <a v-for="social in botbleData.socialLogins" :key="social.provider" :href="social.url" 
                               class="btn btn-lg w-100 fw-bold d-flex align-items-center justify-content-center gap-2" 
                               :style="getSocialButtonStyle(social.provider)">
                                <i :class="getSocialIcon(social.provider) + ' fs-4'"></i> 
                                {{ __('الدخول بواسطة') }} {{ social.name }}
                            </a>
                        </template>
                    </div>

                    <div class="mt-4">
                        <span class="text-muted">{{ __('ليس لديك حساب؟') }}</span> 
                        <a href="javascript:void(0)" @click="step = 'classic_register'" class="fw-bold text-decoration-none" style="color: var(--primary);">{{ __('إنشاء حساب كلاسيكي') }}</a>
                    </div>
                </div>
                
                <!-- Classic Register Form -->
                <div v-if="step === 'classic_register'" class="text-center">
                    <button @click="step = 'classic_login'" class="btn btn-link text-decoration-none text-muted position-absolute" style="top: 20px; right: 20px;">
                        <i class="ti ti-arrow-right"></i> {{ __('عودة') }}
                    </button>
                    <h3 class="fw-bold mb-4">{{ __('إنشاء حساب جديد') }}</h3>
                    
                    <form @submit.prevent="register">
                        <div class="form-group mb-3 text-start">
                            <label class="mb-1 text-muted">{{ __('الاسم') }} <span class="text-danger">*</span></label>
                            <input type="text" class="form-control form-control-lg" v-model="registerForm.name" required style="border-radius: 12px; height: 50px;">
                        </div>
                        <div class="form-group mb-3 text-start">
                            <label class="mb-1 text-muted">{{ __('البريد الإلكتروني') }} <span v-if="!botbleData.isPhoneLoginEnabled" class="text-danger">*</span><span v-else>({{ __('اختياري') }})</span></label>
                            <input type="email" class="form-control form-control-lg" v-model="registerForm.email" :required="!botbleData.isPhoneLoginEnabled" style="border-radius: 12px; height: 50px;">
                        </div>
                        <div class="form-group mb-3 text-start">
                            <label class="mb-1 text-muted">{{ __('رقم الهاتف') }} <span v-if="botbleData.isPhoneRequired" class="text-danger">*</span><span v-else>({{ __('اختياري') }})</span></label>
                            <div class="d-flex align-items-center form-control form-control-lg p-0" style="border-radius: 12px; height: 50px; overflow: hidden; direction: ltr;">
                                <span class="px-3 fw-bold" style="background-color: rgba(128,128,128,0.1); height: 100%; display: flex; align-items: center; border-right: 1px solid var(--border-color, #ced4da); white-space: nowrap; color: inherit;">🇰🇼 +965</span>
                                <input type="text" class="form-control form-control-lg border-0 shadow-none flex-grow-1 px-3 h-100 w-100" v-model="registerForm.phone" :required="botbleData.isPhoneRequired" style="background-color: transparent !important; color: inherit; outline: none;" placeholder="12345678">
                            </div>
                        </div>
                        <div class="form-group mb-3 text-start">
                            <label class="mb-1 text-muted">{{ __('كلمة المرور') }} <span class="text-danger">*</span></label>
                            <input type="password" class="form-control form-control-lg" v-model="registerForm.password" required style="border-radius: 12px; height: 50px;">
                        </div>
                        <div class="form-group mb-4 text-start">
                            <label class="mb-1 text-muted">{{ __('تأكيد كلمة المرور') }} <span class="text-danger">*</span></label>
                            <input type="password" class="form-control form-control-lg" v-model="registerForm.password_confirmation" required style="border-radius: 12px; height: 50px;">
                        </div>
                        <button type="submit" class="btn btn-primary btn-lg w-100 fw-bold mb-3 text-white" :disabled="loading" style="border-radius: 12px; height: 50px; background-color: var(--primary); border: none;">
                            <span v-if="!loading">{{ __('تسجيل') }}</span>
                            <span v-else>{{ __('جاري التسجيل...') }}</span>
                        </button>
                    </form>
                    <div class="mt-4">
                        <span class="text-muted">{{ __('لديك حساب بالفعل؟') }}</span> 
                        <a href="javascript:void(0)" @click="step = 'classic_login'" class="fw-bold text-decoration-none" style="color: var(--primary);">{{ __('تسجيل الدخول') }}</a>
                    </div>
                </div>

                <!-- Classic Register OTP Step -->
                <div v-if="step === 'classic_register_otp'" class="text-center">
                    <button @click="step = 'classic_register'" class="btn btn-link text-decoration-none text-muted position-absolute" style="top: 20px; right: 20px;">
                        <i class="ti ti-arrow-right"></i> {{ __('عودة والتعديل') }}
                    </button>

                    <div class="mb-4">
                        <i class="ti ti-shield-check" style="font-size: 50px; color: #25D366;"></i>
                    </div>
                    <h4 class="fw-bold mb-2">{{ __('تأكيد رقم الهاتف') }}</h4>
                    <p class="text-muted mb-4" style="font-size: 14px;">
                        {{ __('لقد أرسلنا لك رسالة عبر الواتساب تحتوي على كود التفعيل. يرجى إدخاله لإتمام التسجيل.') }}
                    </p>

                    <form @submit.prevent="verifyRegisterOtp">
                        <div class="form-group mb-3">
                            <input type="text" class="form-control form-control-lg text-center bg-light" v-model="registerForm.otp" :placeholder="__('أدخل الكود (6 أرقام)')" style="border-radius: 12px; font-weight: bold; letter-spacing: 5px; height: 50px;" dir="ltr" maxlength="6" required>
                        </div>
                        <button type="submit" class="btn btn-success btn-lg w-100 mb-3 fw-bold" :disabled="loading" style="border-radius: 12px; height: 50px; background-color: #25D366; border: none;">
                            <span v-if="!loading">{{ __('تأكيد الكود وإتمام التسجيل') }}</span>
                            <span v-else>{{ __('جاري التحقق...') }}</span>
                        </button>
                    </form>
                </div>

                <!-- WhatsApp Phone Step -->
                <div v-if="step === 'wa_phone'" class="text-center">
                    <button @click="step = 'classic_login'" class="btn btn-link text-decoration-none text-muted position-absolute" style="top: 20px; right: 20px;">
                        <i class="ti ti-arrow-right"></i> {{ __('عودة') }}
                    </button>

                    <i class="ti ti-brand-whatsapp mb-3" style="font-size: 60px; color: #25D366;"></i>
                    <h4 class="fw-bold mb-3">{{ __('الدخول بالواتساب') }}</h4>
                    <p class="text-muted mb-4">{{ __('أدخل رقمك وسنرسل لك كوداً ورابطاً للدخول المباشر.') }}</p>

                    <div class="form-group mb-3">
                        <div class="d-flex align-items-center form-control form-control-lg p-0" style="border-radius: 12px; height: 50px; overflow: hidden; direction: ltr;">
                            <span class="px-3 fw-bold" style="background-color: rgba(128,128,128,0.1); height: 100%; display: flex; align-items: center; border-right: 1px solid var(--border-color, #ced4da); white-space: nowrap; color: inherit;">🇰🇼 +965</span>
                            <input type="text" class="form-control form-control-lg border-0 shadow-none flex-grow-1 px-3 h-100 w-100 fw-bold" v-model="phone" :placeholder="__('12345678')" style="background-color: transparent !important; color: inherit; outline: none;">
                        </div>
                    </div>
                    <button class="btn btn-success btn-lg w-100 mb-3 fw-bold" @click="sendAuthMessage" :disabled="loading" style="border-radius: 12px; height: 50px; background-color: #25D366; border: none;">
                        <span v-if="!loading">{{ __('إرسال') }} <i class="ti ti-send"></i></span>
                        <span v-else>{{ __('جاري الإرسال...') }}</span>
                    </button>
                </div>

                <!-- WhatsApp OTP Step -->
                <div v-if="step === 'wa_otp'" class="text-center">
                    <button @click="step = 'wa_phone'" class="btn btn-link text-decoration-none text-muted position-absolute" style="top: 20px; right: 20px;">
                        <i class="ti ti-arrow-right"></i> {{ __('تعديل الرقم') }}
                    </button>

                    <div class="mb-4">
                        <i class="ti ti-mail-opened" style="font-size: 50px; color: #25D366;"></i>
                    </div>
                    <h4 class="fw-bold mb-2">{{ __('تم الإرسال بنجاح!') }}</h4>
                    <p class="text-muted mb-4" style="font-size: 14px;">
                        {{ __('لقد أرسلنا لك رسالة عبر الواتساب تحتوي على الكود السري ورابط الدخول السريع. يمكنك إدخال الكود هنا أو الضغط على الرابط من الواتساب.') }}
                    </p>

                    <div class="form-group mb-3">
                        <input type="text" class="form-control form-control-lg text-center bg-light" v-model="otp" :placeholder="__('أدخل الكود (6 أرقام)')" style="border-radius: 12px; font-weight: bold; letter-spacing: 5px; height: 50px;" dir="ltr" maxlength="6">
                    </div>
                    <button class="btn btn-success btn-lg w-100 mb-3 fw-bold" @click="verifyOtp" :disabled="loading" style="border-radius: 12px; height: 50px; background-color: #25D366; border: none;">
                        <span v-if="!loading">{{ __('تأكيد الدخول') }}</span>
                        <span v-else>{{ __('جاري التحقق...') }}</span>
                    </button>

                    <div class="alert alert-info mt-3 border-0" style="background-color: #e3f2fd; border-radius: 10px; font-size: 13px;">
                        <i class="ti ti-info-circle"></i> {{ __('يمكنك أيضاً فتح تطبيق الواتساب والضغط على الرابط السحري للدخول فوراً بدون كتابة الكود.') }}
                    </div>
                </div>

                <!-- Complete Profile Step -->
                <div v-if="step === 'complete_profile'" class="text-center">
                    <div class="mb-4">
                        <i class="ti ti-user-check" style="font-size: 50px; color: var(--primary);"></i>
                    </div>
                    <h3 class="fw-bold mb-2">{{ __('أكمل ملفك الشخصي') }}</h3>
                    <p class="text-muted mb-4" style="font-size: 14px;">
                        {{ __('أهلاً بك! لقد تم توثيق رقمك بنجاح. يرجى إدخال اسمك وبعض التفاصيل لإكمال تسجيل حسابك.') }}
                    </p>
                    
                    <form @submit.prevent="completeProfile">
                        <div class="form-group mb-3 text-start">
                            <label class="mb-1 text-muted">{{ __('الاسم') }} <span class="text-danger">*</span></label>
                            <input type="text" class="form-control form-control-lg" v-model="profileForm.name" required style="border-radius: 12px; height: 50px;" :placeholder="__('your_name')">
                        </div>
                        <div class="form-group mb-3 text-start">
                            <label class="mb-1 text-muted">{{ __('البريد الإلكتروني (اختياري)') }}</label>
                            <input type="email" class="form-control form-control-lg" v-model="profileForm.email" style="border-radius: 12px; height: 50px;" :placeholder="__('email_for_contact')">
                        </div>
                        <div class="form-group mb-3 text-start">
                            <label class="mb-1 text-muted">{{ __('كلمة المرور (اختياري)') }}</label>
                            <input type="password" class="form-control form-control-lg" v-model="profileForm.password" style="border-radius: 12px; height: 50px;" :placeholder="__('password_for_login')">
                        </div>
                        <div class="form-group mb-4 text-start" v-if="profileForm.password">
                            <label class="mb-1 text-muted">{{ __('تأكيد كلمة المرور') }}</label>
                            <input type="password" class="form-control form-control-lg" v-model="profileForm.password_confirmation" required style="border-radius: 12px; height: 50px;">
                        </div>
                        <button type="submit" class="btn btn-primary btn-lg w-100 fw-bold mb-3 text-white" :disabled="loading" style="border-radius: 12px; height: 50px; background-color: var(--primary); border: none;">
                            <span v-if="!loading">{{ __('حفظ ومتابعة التسوق') }}</span>
                            <span v-else>{{ __('جاري الحفظ...') }}</span>
                        </button>
                    </form>
                </div>

            </div>

        </div>
      </div>

      <div style="height: 80px;"></div>
    </div>
  </div>
</template>

<script setup>
import { __ } from '../utils/i18n';
import { ref, inject, reactive, onMounted } from 'vue';
import axios from 'axios';

const botbleData = window?.BotbleData || {};

const urlParams = new URLSearchParams(window.location.search);
const initialStep = urlParams.get('step') || 'classic_login';
const step = ref(initialStep);

const phone = ref('');
const otp = ref('');
const loading = ref(false);
const isPhoneInput = ref(false);

const getSocialButtonStyle = (provider) => {
    switch (provider) {
        case 'google':
            return 'border-radius: 12px; height: 50px; background-color: #fff; color: #757575; border: 1px solid #ddd;';
        case 'facebook':
            return 'border-radius: 12px; height: 50px; background-color: #1877F2; color: white; border: none;';
        case 'apple':
            return 'border-radius: 12px; height: 50px; background-color: #000; color: white; border: none;';
        case 'twitter':
            return 'border-radius: 12px; height: 50px; background-color: #1DA1F2; color: white; border: none;';
        case 'linkedin':
            return 'border-radius: 12px; height: 50px; background-color: #0077b5; color: white; border: none;';
        default:
            return 'border-radius: 12px; height: 50px; background-color: var(--surface2); color: var(--text); border: 1px solid var(--border);';
    }
};

const getSocialIcon = (provider) => {
    const icons = {
        'facebook': 'ti ti-brand-facebook-filled',
        'google': 'ti ti-brand-google',
        'apple': 'ti ti-brand-apple',
        'twitter': 'ti ti-brand-twitter',
        'linkedin': 'ti ti-brand-linkedin',
        'github': 'ti ti-brand-github'
    };
    return icons[provider] || 'ti ti-login';
};

const checkInputType = () => {
    if (/^\d/.test(classicForm.email)) {
        isPhoneInput.value = true;
    } else {
        isPhoneInput.value = false;
    }
};

const classicForm = reactive({
    email: '',
    password: ''
});

const registerForm = reactive({
    name: '',
    email: '',
    phone: '',
    password: '',
    password_confirmation: '',
    otp: ''
});

const profileForm = reactive({
    name: '',
    email: '',
    password: '',
    password_confirmation: ''
});

const getCsrfToken = () => {
    return document.querySelector('meta[name="csrf-token"]')?.getAttribute('content') || '';
};

const classicLogin = async () => {
    if (!classicForm.email || !classicForm.password) return alert(__('يرجى إدخال البريد وكلمة المرور'));
    loading.value = true;
    try {
        let loginId = classicForm.email;
        if (isPhoneInput.value) {
            loginId = '965' + loginId.replace(/^965/, ''); // Ensure we don't double prepend
        }

        const res = await axios.post('/customer/login', {
            email: loginId,
            password: classicForm.password,
            _token: getCsrfToken()
        }, {
            headers: { 'Accept': 'application/json' }
        });
        
        window.location.href = botbleData.baseUrl || '/';
    } catch (e) {
        let msg = __('بيانات الدخول غير صحيحة');
        if (e.response && e.response.data && e.response.data.errors) {
            const errors = e.response.data.errors;
            msg = Object.values(errors)[0][0] || msg;
        }
        alert(msg);
    }
    loading.value = false;
};

const register = async () => {
    if (!registerForm.name || !registerForm.password) return alert(__('يرجى إدخال الحقول المطلوبة'));
    if (!botbleData.isPhoneLoginEnabled && !registerForm.email) return alert(__('البريد الإلكتروني مطلوب'));
    if (botbleData.isPhoneRequired && !registerForm.phone) return alert(__('رقم الهاتف مطلوب'));
    if (registerForm.password !== registerForm.password_confirmation) return alert(__('كلمتا المرور غير متطابقتين'));
    
    let finalPhone = registerForm.phone ? '965' + registerForm.phone.replace(/^965/, '') : '';

    // If phone login is enabled and phone is provided, send OTP first
    if (botbleData.isPhoneLoginEnabled && finalPhone) {
        loading.value = true;
        try {
            const res = await axios.post('/api/whatsapp/auth/send-otp', { phone: finalPhone });
            if (res.data.status === 'success') {
                step.value = 'classic_register_otp';
            }
        } catch (e) {
            alert(__('حدث خطأ أثناء إرسال الكود'));
        }
        loading.value = false;
        return;
    }

    // Direct registration (no OTP needed if only email is used)
    loading.value = true;
    try {
        const res = await axios.post('/customer/register', {
            name: registerForm.name,
            email: registerForm.email,
            phone: finalPhone,
            password: registerForm.password,
            password_confirmation: registerForm.password_confirmation,
            _token: getCsrfToken()
        }, {
            headers: { 'Accept': 'application/json' }
        });
        
        if (res.data && res.data.message) {
            alert(res.data.message);
        }
        window.location.href = botbleData.baseUrl || '/';
    } catch (e) {
        let msg = __('حدث خطأ أثناء التسجيل');
        if (e.response && e.response.data && e.response.data.errors) {
            const errors = e.response.data.errors;
            msg = Object.values(errors)[0][0] || msg;
        }
        alert(msg);
    }
    loading.value = false;
};

const verifyRegisterOtp = async () => {
    if (!registerForm.otp) return alert(__('يرجى إدخال الكود'));
    
    let finalPhone = registerForm.phone ? '965' + registerForm.phone.replace(/^965/, '') : '';

    loading.value = true;
    try {
        const res = await axios.post('/api/whatsapp/auth/register-with-otp', {
            name: registerForm.name,
            email: registerForm.email,
            phone: finalPhone,
            password: registerForm.password,
            password_confirmation: registerForm.password_confirmation,
            otp: registerForm.otp,
            _token: getCsrfToken()
        });
        
        if (res.data.status === 'success') {
            window.location.href = res.data.redirect || '/';
        }
    } catch (e) {
        let msg = __('الكود غير صحيح أو حدث خطأ أثناء التسجيل');
        if (e.response && e.response.data && e.response.data.errors) {
            const errors = e.response.data.errors;
            msg = Object.values(errors)[0][0] || msg;
        } else if (e.response && e.response.data && e.response.data.message) {
            msg = e.response.data.message;
        }
        alert(msg);
    }
    loading.value = false;
};

const sendAuthMessage = async () => {
    if (!phone.value) return alert(__('يرجى إدخال رقم الهاتف'));
    
    let finalPhone = phone.value ? '965' + phone.value.replace(/^965/, '') : '';

    loading.value = true;
    try {
        const res = await axios.post('/api/whatsapp/auth/send-otp', { phone: finalPhone });
        if (res.data.status === 'success') {
            step.value = 'wa_otp';
        }
    } catch (e) {
        alert(__('حدث خطأ أثناء إرسال الكود'));
    }
    loading.value = false;
};

const verifyOtp = async () => {
    if (!otp.value) return alert(__('يرجى إدخال كود التحقق'));
    
    let finalPhone = phone.value ? '965' + phone.value.replace(/^965/, '') : '';

    loading.value = true;
    try {
        const res = await axios.post('/api/whatsapp/auth/verify-otp', { phone: finalPhone, otp: otp.value });
        if (res.data.status === 'success') {
            if (res.data.needs_onboarding) {
                step.value = 'complete_profile';
            } else {
                window.location.href = res.data.redirect || '/';
            }
        }
    } catch (e) {
        alert(__('كود التحقق غير صحيح أو منتهي الصلاحية'));
    }
    loading.value = false;
};

const completeProfile = async () => {
    if (!profileForm.name) return alert(__('الاسم مطلوب'));
    if (profileForm.password && profileForm.password !== profileForm.password_confirmation) {
        return alert(__('كلمتا المرور غير متطابقتين'));
    }
    
    loading.value = true;
    try {
        const res = await axios.post('/api/whatsapp/auth/complete-profile', { 
            name: profileForm.name,
            email: profileForm.email,
            password: profileForm.password,
            password_confirmation: profileForm.password_confirmation,
            _token: getCsrfToken()
        });
        if (res.data.status === 'success') {
            alert(__('تم تحديث الملف الشخصي بنجاح'));
            window.location.href = res.data.redirect || '/';
        }
    } catch (e) {
        let msg = __('حدث خطأ أثناء تحديث البيانات');
        if (e.response && e.response.data && e.response.data.errors) {
            const errors = e.response.data.errors;
            msg = Object.values(errors)[0][0] || msg;
        } else if (e.response && e.response.data && e.response.data.message) {
            msg = e.response.data.message;
        }
        alert(msg);
    }
    loading.value = false;
};

</script>

<style scoped>
.auth-container {
    max-width: 450px;
    margin: 0 auto;
    position: relative;
}
.btn-outline-primary:hover {
    color: white !important;
}
/* Force text colors to adapt to Laly theme variables (Light/Dark mode) */
h3, h4 {
    color: var(--text) !important;
}
.text-muted {
    color: var(--text2) !important;
}
/* Force inputs to use theme variables */
.form-control {
    background-color: var(--surface) !important;
    color: var(--text) !important;
    border-color: var(--border) !important;
}
.form-control::placeholder {
    color: var(--text3) !important;
}
</style>

<template>
  <transition name="onboarding-fade">
    <div v-if="isVisible" class="mobile-onboarding">
      
      <!-- Step 1: Intro Slider -->
      <div v-if="currentStep === 1" class="onboarding-step step-slider">
        <button class="btn-skip" @click="currentStep = 2">{{ __('skip') || 'تخطي' }}</button>
        
        <div class="slides-container" ref="slidesContainer" @scroll="onScroll">
          <div class="slide">
            <div class="slide-img">
              <i :class="onboardingData.slide1.icon" style="font-size: 80px; color: var(--primary);"></i>
            </div>
            <h3>{{ onboardingData.slide1.title }}</h3>
            <p>{{ onboardingData.slide1.desc }}</p>
          </div>
          
          <div class="slide">
            <div class="slide-img">
              <i :class="onboardingData.slide2.icon" style="font-size: 80px; color: var(--primary);"></i>
            </div>
            <h3>{{ onboardingData.slide2.title }}</h3>
            <p>{{ onboardingData.slide2.desc }}</p>
          </div>
          
          <div class="slide">
            <div class="slide-img">
              <i :class="onboardingData.slide3.icon" style="font-size: 80px; color: var(--primary);"></i>
            </div>
            <h3>{{ onboardingData.slide3.title }}</h3>
            <p>{{ onboardingData.slide3.desc }}</p>
          </div>
        </div>
        
        <div class="slider-controls">
          <div class="dots">
            <div class="dot" :class="{ active: activeSlide === 0 }"></div>
            <div class="dot" :class="{ active: activeSlide === 1 }"></div>
            <div class="dot" :class="{ active: activeSlide === 2 }"></div>
          </div>
          <button class="btn-next" @click="nextSlide">
            {{ activeSlide === 2 ? (__('continue') || 'متابعة') : (__('next') || 'التالي') }}
          </button>
        </div>
      </div>
      
      <!-- Step 2: Preferences -->
      <div v-if="currentStep === 2" class="onboarding-step step-prefs">
        <div class="prefs-header">
          <div class="prefs-img">
            <i class="ti ti-settings" style="font-size: 60px; color: var(--primary);"></i>
          </div>
          <h3>{{ __('setup_preferences') || 'إعدادات التطبيق' }}</h3>
          <p>{{ __('setup_preferences_desc') || 'اختر اللغة والمظهر المفضل لك.' }}</p>
        </div>
        
        <div class="prefs-options">
          <div class="pref-group">
            <h4>{{ __('choose_language') || 'اختر اللغة' }}</h4>
            <div class="pref-cards">
              <div class="pref-card" :class="{ active: selectedLang === 'ar' }" @click="selectLang('ar')">
                <i class="ti ti-language"></i>
                <span>العربية</span>
              </div>
              <div class="pref-card" :class="{ active: selectedLang === 'en' }" @click="selectLang('en')">
                <i class="ti ti-language"></i>
                <span>English</span>
              </div>
            </div>
          </div>
          
          <div class="pref-group">
            <h4>{{ __('choose_theme') || 'اختر المظهر' }}</h4>
            <div class="pref-cards">
              <div class="pref-card" :class="{ active: selectedTheme === 'light' }" @click="selectTheme('light')">
                <i class="ti ti-sun"></i>
                <span>{{ __('light_mode') || 'فاتح' }}</span>
              </div>
              <div class="pref-card" :class="{ active: selectedTheme === 'dark' }" @click="selectTheme('dark')">
                <i class="ti ti-moon"></i>
                <span>{{ __('dark_mode') || 'داكن' }}</span>
              </div>
            </div>
          </div>
        </div>
        
        <div class="prefs-footer">
          <button class="btn-start" @click="finishOnboarding">
            {{ __('start_shopping') || 'ابدأ التسوق' }}
          </button>
        </div>
      </div>
      
    </div>
  </transition>
</template>

<script setup>
import { __ } from '../utils/i18n';
import { ref, onMounted, inject, defineEmits } from 'vue';

const emit = defineEmits(['finished']);
const botbleData = window?.BotbleData || {};

const onboardingData = botbleData?.onboarding || {
  slide1: { title: 'تسوق بسهولة', desc: 'اكتشف آلاف المنتجات بأسعار تنافسية وتجربة تسوق لا مثيل لها.', icon: 'ti ti-shopping-cart' },
  slide2: { title: 'توصيل سريع', desc: 'نوفر لك خيارات توصيل سريعة وموثوقة لجميع أنحاء البلاد.', icon: 'ti ti-truck-delivery' },
  slide3: { title: 'دفع آمن', desc: 'طرق دفع متعددة وآمنة لتضمن راحة بالك أثناء التسوق.', icon: 'ti ti-shield-check' }
};

const isVisible = ref(false);
const currentStep = ref(1);
const activeSlide = ref(0);
const slidesContainer = ref(null);

const selectedLang = ref(botbleData?.locale || 'ar');
const selectedTheme = ref(localStorage.getItem('theme') || 'light');

onMounted(() => {
  if (window.innerWidth <= 768) {
    const hasSeenOnboarding = localStorage.getItem('hasSeenOnboarding_v1');
    if (!hasSeenOnboarding) {
      isVisible.value = true;
    } else {
      emit('finished');
    }
  } else {
    emit('finished');
  }
});

const onScroll = (e) => {
  const container = e.target;
  const slideWidth = container.offsetWidth;
  const scrollLeft = container.scrollLeft;
  // Handle RTL scrolling (could be negative in some browsers)
  const absoluteScroll = Math.abs(scrollLeft);
  activeSlide.value = Math.round(absoluteScroll / slideWidth);
};

const nextSlide = () => {
  if (activeSlide.value === 2) {
    currentStep.value = 2;
  } else {
    const container = slidesContainer.value;
    if (container) {
      const slideWidth = container.offsetWidth;
      // Scroll direction depends on RTL/LTR, usually standard scrollLeft handles it
      // but in RTL, we might need to scroll negative or positive depending on browser.
      // To be safe, we just use scrollTo with smooth behavior.
      const isRtl = botbleData?.is_rtl;
      const targetScroll = (activeSlide.value + 1) * slideWidth;
      container.scrollTo({
        left: isRtl ? -targetScroll : targetScroll,
        behavior: 'smooth'
      });
    }
  }
};

const selectLang = (lang) => {
  selectedLang.value = lang;
};

const selectTheme = (theme) => {
  selectedTheme.value = theme;
  if (theme === 'dark') {
    document.documentElement.setAttribute('data-theme', 'dark');
    localStorage.setItem('theme', 'dark');
  } else {
    document.documentElement.removeAttribute('data-theme');
    localStorage.setItem('theme', 'light');
  }
};

const finishOnboarding = () => {
  localStorage.setItem('hasSeenOnboarding_v1', 'true');
  isVisible.value = false;
  emit('finished');
  
  // If language changed, redirect
  if (selectedLang.value !== botbleData?.locale) {
    const langObj = botbleData?.languages?.find(l => l.code === selectedLang.value);
    if (langObj && langObj.url) {
      window.location.href = langObj.url;
    }
  }
};
</script>

<style scoped>
.mobile-onboarding {
  position: fixed;
  inset: 0;
  background-color: var(--surface, #fff);
  z-index: 999995;
  display: flex;
  flex-direction: column;
}

.onboarding-step {
  flex: 1;
  display: flex;
  flex-direction: column;
  height: 100%;
}

/* Slider Step */
.btn-skip {
  position: absolute;
  top: 20px;
  right: 20px;
  background: none;
  border: none;
  font-size: 16px;
  color: var(--text2, #666);
  z-index: 10;
}
[dir="ltr"] .btn-skip { right: auto; left: 20px; }

.slides-container {
  flex: 1;
  display: flex;
  overflow-x: auto;
  scroll-snap-type: x mandatory;
  scrollbar-width: none; /* Firefox */
  -ms-overflow-style: none; /* IE/Edge */
}
.slides-container::-webkit-scrollbar {
  display: none;
}

.slide {
  flex: 0 0 100%;
  width: 100%;
  scroll-snap-align: center;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 40px 20px;
  text-align: center;
}

.slide-img {
  width: 150px;
  height: 150px;
  background: var(--bg, #f5f5f5);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 40px;
}

.slide h3 {
  font-size: 24px;
  font-weight: bold;
  margin-bottom: 15px;
  color: var(--text, #333);
}

.slide p {
  font-size: 15px;
  color: var(--text2, #666);
  line-height: 1.6;
}

.slider-controls {
  padding: 30px 20px;
  display: flex;
  flex-direction: column;
  gap: 30px;
  align-items: center;
}

.dots {
  display: flex;
  gap: 8px;
}
.dot {
  width: 10px;
  height: 10px;
  border-radius: 5px;
  background-color: var(--border, #ddd);
  transition: all 0.3s;
}
.dot.active {
  width: 24px;
  background-color: var(--primary, #172B85);
}

.btn-next {
  width: 100%;
  padding: 16px;
  background-color: var(--primary, #172B85);
  color: #fff;
  border: none;
  border-radius: 12px;
  font-size: 16px;
  font-weight: bold;
}

/* Prefs Step */
.step-prefs {
  padding: 40px 20px 20px;
}
.prefs-header {
  text-align: center;
  margin-bottom: 40px;
}
.prefs-img {
  width: 100px;
  height: 100px;
  background: var(--bg, #f5f5f5);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto 20px;
}
.prefs-header h3 {
  font-size: 22px;
  margin-bottom: 10px;
}
.prefs-header p {
  color: var(--text2, #666);
}

.prefs-options {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 30px;
}

.pref-group h4 {
  font-size: 16px;
  margin-bottom: 15px;
}
.pref-cards {
  display: flex;
  gap: 15px;
}
.pref-card {
  flex: 1;
  border: 2px solid var(--border, #eee);
  border-radius: 12px;
  padding: 20px 10px;
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 10px;
  cursor: pointer;
  transition: all 0.2s;
}
.pref-card i {
  font-size: 30px;
  color: var(--text2, #666);
}
.pref-card span {
  font-weight: bold;
  font-size: 15px;
}
.pref-card.active {
  border-color: var(--primary, #172B85);
  background-color: rgba(23, 43, 133, 0.05);
}
.pref-card.active i {
  color: var(--primary, #172B85);
}

.prefs-footer {
  margin-top: auto;
  padding-top: 20px;
}
.btn-start {
  width: 100%;
  padding: 16px;
  background-color: var(--primary, #172B85);
  color: #fff;
  border: none;
  border-radius: 12px;
  font-size: 18px;
  font-weight: bold;
}

.onboarding-fade-enter-active,
.onboarding-fade-leave-active {
  transition: opacity 0.5s ease;
}
.onboarding-fade-enter-from,
.onboarding-fade-leave-to {
  opacity: 0;
}
</style>

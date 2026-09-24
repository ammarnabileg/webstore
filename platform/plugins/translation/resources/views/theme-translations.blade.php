@extends(BaseHelper::getAdminMasterLayoutTemplate())

@section('content')
    <x-core::alert type="warning">
        {{ trans('plugins/translation::translation.theme_translations_instruction') }}

        <p class="mt-3 mb-0">
            {!! BaseHelper::clean(trans('plugins/translation::translation.re_import_alert', [
                'here' => Html::link('#', trans('plugins/translation::translation.here'), [
                    'data-bs-toggle' => 'modal',
                    'data-bs-target' => '#confirm-re-import-modal',
                ]),
            ])) !!}
        </p>
    </x-core::alert>

    <div class="theme-translation">
        <div class="row">
            <div class="col-md-6">
                <p>{{ trans('plugins/translation::translation.translate_from') }}
                    <strong class="text-info">{{ $defaultLanguage ? $defaultLanguage['name'] : 'en' }}</strong>
                    {{ trans('plugins/translation::translation.to') }}
                    <strong class="text-info">{{ $group['name'] }}</strong>
                </p>
            </div>
            <div class="col-md-6">
                <div class="text-end d-flex align-items-center justify-content-end">
                    <button type="button" class="btn btn-info btn-ai-translate me-2" 
                            data-url="{{ route('translations.theme-translations.ai-translate') }}"
                            data-locale="{{ $group['locale'] }}">
                        <i class="fa fa-magic"></i> {{ __('AI Translate (Kuwait Style)') }}
                    </button>
                    @include('plugins/translation::partials.list-theme-languages-to-translate', [
                        'groups' => $groups,
                        'group' => $group,
                        'route' => 'translations.theme-translations',
                    ])
                </div>
            </div>
        </div>

        @if (count($groups) < 1)
            <p class="text-warning">{{ trans('plugins/translation::translation.no_other_languages') }}</p>
        @endif

        @if (count($groups) > 0 && $group)
            {!! apply_filters('translation_theme_translation_header', null, $groups, $group) !!}

            {!! $translationTable->renderTable() !!}
        @endif
    </div>
@endsection

@push('footer')
    <x-core::modal.action
        id="confirm-re-import-modal"
        :title="trans('plugins/translation::translation.import_translations')"
        :description="trans('plugins/translation::translation.import_translations_description')"
        type="warning"
        :submit-button-attrs="['class' => 'button-re-import', 'data-url' => route('translations.theme-translations.re-import')]"
        :submit-button-label="trans('core/base::base.yes')"
    />

    <script>
        $(document).ready(function() {
            $(document).on('click', '.btn-ai-translate', function(e) {
                e.preventDefault();
                var $btn = $(this);
                var url = $btn.data('url');
                var locale = $btn.data('locale');
                
                var $editables = $('.editable');
                var keys = [];
                
                $editables.each(function() {
                    var key = $(this).data('name');
                    var currentVal = $(this).text().trim();
                    if (currentVal === '' || currentVal === 'Empty' || currentVal === key) {
                        keys.push(key);
                    }
                });
                
                if (keys.length === 0) {
                    Botble.showNotice('info', 'All visible fields are already translated.');
                    return;
                }

                Botble.showNotice('info', 'Translating ' + keys.length + ' strings with AI...');
                
                $httpClient.make().withButtonLoading($btn).post(url, {
                    keys: keys,
                    locale: locale
                }).then(function(response) {
                    var translations = response.data.data;
                    var count = 0;
                    
                    $.each(translations, function(key, value) {
                        var $el = $editables.filter(function() {
                            return $(this).data('name') === key;
                        });
                        
                        if ($el.length && value) {
                            // Using x-editable's setValue and then manually triggering the save to ensure it persists
                            $el.editable('setValue', value);
                            
                            // Trigger the save request manually for each field
                            $.ajax({
                                url: '{{ route('translations.theme-translations.post') }}',
                                type: 'POST',
                                data: {
                                    pk: locale,
                                    name: key,
                                    value: value,
                                    _token: '{{ csrf_token() }}'
                                }
                            });
                            
                            $el.addClass('text-info').css('font-weight', 'bold'); 
                            count++;
                        }
                    });
                    
                    Botble.showSuccess('Successfully translated ' + count + ' strings with Kuwaiti context!');
                }).catch(function(error) {
                    var message = error.response ? (error.response.data.message || error.message) : error.message;
                    Botble.showError('AI translation failed: ' + message);
                });
            });
        });
    </script>
@endpush

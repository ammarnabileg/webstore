@extends(BaseHelper::getAdminMasterLayoutTemplate())

@section('content')
    <div class="row justify-content-center">
        <div class="col-lg-8">
            @if (session('success_msg'))
                <div class="alert alert-success">{{ session('success_msg') }}</div>
            @endif
            @if ($errors->any())
                <div class="alert alert-danger">{{ $errors->first() }}</div>
            @endif

            <form method="POST" action="{{ route('laly-notifications.settings.update') }}">
                @csrf

                <div class="card mb-3">
                    <div class="card-header">
                        <h4 class="card-title mb-0">{{ trans('plugins/laly-notifications::notifications.web_config') }}</h4>
                    </div>
                    <div class="card-body">
                        <p class="text-muted">{{ trans('plugins/laly-notifications::notifications.web_config_help') }}</p>
                        <div class="alert {{ $webConfigured ? 'alert-success' : 'alert-warning' }}">
                            {{ $webConfigured ? trans('plugins/laly-notifications::notifications.web_configured') : trans('plugins/laly-notifications::notifications.web_not_configured') }}
                        </div>

                        @foreach ([
                            'laly_fcm_api_key' => 'apiKey',
                            'laly_fcm_auth_domain' => 'authDomain',
                            'laly_fcm_project_id' => 'projectId',
                            'laly_fcm_sender_id' => 'messagingSenderId',
                            'laly_fcm_app_id' => 'appId',
                            'laly_fcm_vapid_key' => 'VAPID key (Web Push certificate)',
                        ] as $key => $label)
                            <div class="mb-3">
                                <label class="form-label" for="{{ $key }}">{{ $label }}</label>
                                <input type="text" class="form-control" dir="ltr" id="{{ $key }}" name="{{ $key }}" value="{{ old($key, $values[$key]) }}" autocomplete="off">
                            </div>
                        @endforeach
                    </div>
                </div>

                <div class="card mb-3">
                    <div class="card-header">
                        <h4 class="card-title mb-0">{{ trans('plugins/laly-notifications::notifications.service_account') }}</h4>
                    </div>
                    <div class="card-body">
                        <p class="text-muted">{{ trans('plugins/laly-notifications::notifications.service_account_help') }}</p>

                        @if ($serviceAccountEmail)
                            <div class="alert alert-success" dir="ltr">{{ $serviceAccountEmail }}</div>
                            <label class="form-check mb-3">
                                <input class="form-check-input" type="checkbox" name="remove_service_account" value="1">
                                <span class="form-check-label">{{ trans('plugins/laly-notifications::notifications.remove_service_account') }}</span>
                            </label>
                        @elseif ($envFallback)
                            <div class="alert alert-info">{{ trans('plugins/laly-notifications::notifications.using_env') }}</div>
                        @else
                            <div class="alert alert-warning">{{ trans('plugins/laly-notifications::notifications.no_service_account') }}</div>
                        @endif

                        <textarea class="form-control" name="service_account" rows="6" dir="ltr" autocomplete="off"
                                  placeholder='{"type": "service_account", "project_id": "...", "private_key": "...", "client_email": "..."}'></textarea>
                    </div>
                </div>

                <button type="submit" class="btn btn-primary">{{ trans('core/base::forms.save') }}</button>
            </form>
        </div>
    </div>
@stop

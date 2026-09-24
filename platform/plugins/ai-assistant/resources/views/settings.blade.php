@extends(BaseHelper::getAdminMasterLayoutTemplate())

@section('content')
    <div class="max-width-1200">
        <div class="flexbox-annotated-section">
            <div class="flexbox-annotated-section-annotation">
                <div class="annotated-section-title-wrapper">
                    <h3 class="annotated-section-title">AI Assistant Settings</h3>
                </div>
                <div class="annotated-section-description">
                    <p>Configure your OpenRouter API settings to enable AI assistance across the dashboard.</p>
                </div>
            </div>

            <div class="flexbox-annotated-section-content">
                <div class="wrapper-content pd-all-20">
                    <form action="{{ route('ai-assistant.settings.post') }}" method="POST">
                        @csrf
                        <div class="form-group mb-3">
                            <label class="text-title-field">OpenRouter API Key</label>
                            <input type="password" class="form-control" name="ai_assistant_openrouter_api_key" value="{{ setting('ai_assistant_openrouter_api_key', config('plugins.ai-assistant.general.openrouter_api_key')) }}" placeholder="sk-or-v1-...">
                            <small class="form-text text-muted">
                                Get your API key from <a href="https://openrouter.ai/" target="_blank">OpenRouter.ai</a>.
                            </small>
                        </div>

                        <div class="form-group mb-3">
                            <label class="text-title-field">Default AI Model</label>
                            <input type="text" class="form-control" name="ai_assistant_openrouter_model" value="{{ setting('ai_assistant_openrouter_model', config('plugins.ai-assistant.general.openrouter_model')) }}" placeholder="e.g. openai/gpt-3.5-turbo">
                            <small class="form-text text-muted">
                                Common models: <code>openai/gpt-3.5-turbo</code>, <code>google/gemini-pro-1.5</code>, or <code>nvidia/llama-nemotron-embed-vl-1b-v2:free</code>.
                            </small>
                        </div>

                        <div class="form-actions text-end">
                            <button type="submit" class="btn btn-primary">
                                <i class="ti ti-device-floppy"></i> Save Settings
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
@stop

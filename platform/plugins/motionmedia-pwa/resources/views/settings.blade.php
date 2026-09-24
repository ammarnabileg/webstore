@extends(BaseHelper::getAdminMasterLayoutTemplate())

@section('content')
    <div class="max-width-1200">
        {!! Form::open(['route' => 'pwa.settings', 'method' => 'POST', 'files' => true]) !!}
            <div class="flexbox-annotated-section">
                <div class="flexbox-annotated-section-annotation">
                    <div class="annotated-section-title pd-all-20">
                        <h2>PWA Settings</h2>
                    </div>
                    <div class="annotated-section-description pd-all-20 p-none-t">
                        <p class="color-note">Configure Progressive Web App settings to make your website installable on mobile devices and enable offline support.</p>
                    </div>
                </div>

                <div class="flexbox-annotated-section-content">
                    <div class="wrapper-content pd-all-20">
                        
                        <div class="form-group mb-3">
                            <label class="text-title-field">
                                Enable PWA
                            </label>
                            <label class="me-2">
                                <input type="radio" name="pwa_enabled" value="1" @if($settings['pwa_enabled'] == 1) checked @endif>
                                Yes
                            </label>
                            <label>
                                <input type="radio" name="pwa_enabled" value="0" @if($settings['pwa_enabled'] == 0) checked @endif>
                                No
                            </label>
                        </div>

                        <div class="form-group mb-3">
                            <label for="pwa_name" class="text-title-field required">Application Name</label>
                            <input type="text" class="form-control" name="pwa_name" id="pwa_name" value="{{ $settings['pwa_name'] }}" required>
                            <span class="help-block">Full name of your application</span>
                        </div>

                        <div class="form-group mb-3">
                            <label for="pwa_short_name" class="text-title-field required">Short Name</label>
                            <input type="text" class="form-control" name="pwa_short_name" id="pwa_short_name" value="{{ $settings['pwa_short_name'] }}" maxlength="12" required>
                            <span class="help-block">Max 12 characters - Used on home screen</span>
                        </div>

                        <div class="form-group mb-3">
                            <label for="pwa_description" class="text-title-field">Description</label>
                            <textarea class="form-control" name="pwa_description" id="pwa_description" rows="3">{{ $settings['pwa_description'] }}</textarea>
                            <span class="help-block">Brief description of your app</span>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group mb-3">
                                    <label for="pwa_theme_color" class="text-title-field required">Theme Color</label>
                                    <input type="color" class="form-control" style="height: 50px;" name="pwa_theme_color" id="pwa_theme_color" value="{{ $settings['pwa_theme_color'] }}" required>
                                    <span class="help-block">Browser toolbar color</span>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group mb-3">
                                    <label for="pwa_background_color" class="text-title-field required">Background Color</label>
                                    <input type="color" class="form-control" style="height: 50px;" name="pwa_background_color" id="pwa_background_color" value="{{ $settings['pwa_background_color'] }}" required>
                                    <span class="help-block">Splash screen background</span>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group mb-3">
                                    <label for="pwa_display" class="text-title-field">Display Mode</label>
                                    <select class="form-control" name="pwa_display" id="pwa_display">
                                        <option value="fullscreen" @if($settings['pwa_display'] == 'fullscreen') selected @endif>Fullscreen</option>
                                        <option value="standalone" @if($settings['pwa_display'] == 'standalone') selected @endif>Standalone (Recommended)</option>
                                        <option value="minimal-ui" @if($settings['pwa_display'] == 'minimal-ui') selected @endif>Minimal UI</option>
                                        <option value="browser" @if($settings['pwa_display'] == 'browser') selected @endif>Browser</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group mb-3">
                                    <label for="pwa_orientation" class="text-title-field">Orientation</label>
                                    <select class="form-control" name="pwa_orientation" id="pwa_orientation">
                                        <option value="any" @if($settings['pwa_orientation'] == 'any') selected @endif>Any</option>
                                        <option value="natural" @if($settings['pwa_orientation'] == 'natural') selected @endif>Natural</option>
                                        <option value="landscape" @if($settings['pwa_orientation'] == 'landscape') selected @endif>Landscape</option>
                                        <option value="portrait" @if($settings['pwa_orientation'] == 'portrait') selected @endif>Portrait</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="form-group mb-3">
                            <label for="pwa_icon" class="text-title-field">App Icon (Optional)</label>
                            <input type="file" class="form-control" name="pwa_icon" id="pwa_icon" accept="image/png,image/jpeg,image/jpg">
                            <span class="help-block">Upload a square image (PNG, JPG). Will be resized to 192x192 and 512x512 automatically. If not uploaded, a default icon will be used.</span>
                            @if(file_exists(public_path('storage/pwa-icon-192.png')))
                                <div class="mt-2">
                                    <p>Current icon:</p>
                                    <img src="{{ url('storage/pwa-icon-192.png') }}" alt="PWA Icon" style="width: 100px; height: 100px; border: 1px solid #ddd; border-radius: 8px;">
                                </div>
                            @endif
                        </div>

                        <div class="alert alert-info">
                            <strong>How to test your PWA:</strong>
                            <ol class="mb-0 mt-2">
                                <li>Enable PWA and save settings</li>
                                <li>Open your website in Chrome or Edge browser</li>
                                <li>Look for "Install" button in the address bar</li>
                                <li>On mobile devices, you'll see "Add to Home Screen" prompt</li>
                                <li>The app will work offline after first visit</li>
                            </ol>
                        </div>

                    </div>
                </div>
            </div>

            <div class="flexbox-annotated-section" style="border: none">
                <div class="flexbox-annotated-section-annotation">
                    &nbsp;
                </div>
                <div class="flexbox-annotated-section-content">
                    <button class="btn btn-info" type="submit">
                        <i class="fa fa-save"></i> Save Settings
                    </button>
                </div>
            </div>
        {!! Form::close() !!}
    </div>
@endsection
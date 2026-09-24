@extends(BaseHelper::getAdminMasterLayoutTemplate())

@section('content')
    <form action="{{ route('system-wizard.settings.post') }}" method="POST">
        @csrf
        <div class="row">
            <div class="col-md-9">
                <div class="card">
                    <div class="card-header">
                        <h4 class="card-title">إعدادات اعرف نظامك (ربط المنتجات)</h4>
                    </div>
                    <div class="card-body">
                        
                        <div class="row">
                            <div class="col-md-4">
                                <h5 class="mb-3 mt-4 text-primary">الباقة الأساسية (Basic)</h5>
                                <div class="form-group mb-3">
                                    <label class="control-label">كاميرا داخلية</label>
                                    <select name="sw_cam_basic_in" class="form-control select-search-full">
                                        <option value="">-- اختر منتج --</option>
                                        @foreach($products as $id => $name)
                                            <option value="{{ $id }}" @if(setting('sw_cam_basic_in') == $id) selected @endif>{{ $name }}</option>
                                        @endforeach
                                    </select>
                                </div>
                                <div class="form-group mb-3">
                                    <label class="control-label">كاميرا خارجية</label>
                                    <select name="sw_cam_basic_out" class="form-control select-search-full">
                                        <option value="">-- اختر منتج --</option>
                                        @foreach($products as $id => $name)
                                            <option value="{{ $id }}" @if(setting('sw_cam_basic_out') == $id) selected @endif>{{ $name }}</option>
                                        @endforeach
                                    </select>
                                </div>
                                <div class="form-group mb-3">
                                    <label class="control-label">أكسس بوينت (AP)</label>
                                    <select name="sw_ap_basic" class="form-control select-search-full">
                                        <option value="">-- اختر منتج --</option>
                                        @foreach($products as $id => $name)
                                            <option value="{{ $id }}" @if(setting('sw_ap_basic') == $id) selected @endif>{{ $name }}</option>
                                        @endforeach
                                    </select>
                                </div>
                            </div>
                            
                            <div class="col-md-4">
                                <h5 class="mb-3 mt-4 text-info">الباقة المحترفة (Pro)</h5>
                                <div class="form-group mb-3">
                                    <label class="control-label">كاميرا داخلية</label>
                                    <select name="sw_cam_pro_in" class="form-control select-search-full">
                                        <option value="">-- اختر منتج --</option>
                                        @foreach($products as $id => $name)
                                            <option value="{{ $id }}" @if(setting('sw_cam_pro_in') == $id) selected @endif>{{ $name }}</option>
                                        @endforeach
                                    </select>
                                </div>
                                <div class="form-group mb-3">
                                    <label class="control-label">كاميرا خارجية</label>
                                    <select name="sw_cam_pro_out" class="form-control select-search-full">
                                        <option value="">-- اختر منتج --</option>
                                        @foreach($products as $id => $name)
                                            <option value="{{ $id }}" @if(setting('sw_cam_pro_out') == $id) selected @endif>{{ $name }}</option>
                                        @endforeach
                                    </select>
                                </div>
                                <div class="form-group mb-3">
                                    <label class="control-label">أكسس بوينت (AP)</label>
                                    <select name="sw_ap_pro" class="form-control select-search-full">
                                        <option value="">-- اختر منتج --</option>
                                        @foreach($products as $id => $name)
                                            <option value="{{ $id }}" @if(setting('sw_ap_pro') == $id) selected @endif>{{ $name }}</option>
                                        @endforeach
                                    </select>
                                </div>
                            </div>
                            
                            <div class="col-md-4">
                                <h5 class="mb-3 mt-4 text-success">الباقة الممتازة (Premium)</h5>
                                <div class="form-group mb-3">
                                    <label class="control-label">كاميرا داخلية</label>
                                    <select name="sw_cam_prem_in" class="form-control select-search-full">
                                        <option value="">-- اختر منتج --</option>
                                        @foreach($products as $id => $name)
                                            <option value="{{ $id }}" @if(setting('sw_cam_prem_in') == $id) selected @endif>{{ $name }}</option>
                                        @endforeach
                                    </select>
                                </div>
                                <div class="form-group mb-3">
                                    <label class="control-label">كاميرا خارجية</label>
                                    <select name="sw_cam_prem_out" class="form-control select-search-full">
                                        <option value="">-- اختر منتج --</option>
                                        @foreach($products as $id => $name)
                                            <option value="{{ $id }}" @if(setting('sw_cam_prem_out') == $id) selected @endif>{{ $name }}</option>
                                        @endforeach
                                    </select>
                                </div>
                                <div class="form-group mb-3">
                                    <label class="control-label">أكسس بوينت (AP)</label>
                                    <select name="sw_ap_prem" class="form-control select-search-full">
                                        <option value="">-- اختر منتج --</option>
                                        @foreach($products as $id => $name)
                                            <option value="{{ $id }}" @if(setting('sw_ap_prem') == $id) selected @endif>{{ $name }}</option>
                                        @endforeach
                                    </select>
                                </div>
                            </div>
                        </div>
                        
                        <hr>
                        
                        <h5 class="mb-3 mt-4 text-warning">أجهزة التسجيل (NVR)</h5>
                        <p class="text-muted text-sm">حدد المنتج الخاص بكل جهاز لتسعيره في الباقات، أو يمكنك إدخال منتج واحد ليتم سحب سعره.</p>
                        <div class="row">
                            <div class="col-md-4 form-group mb-3">
                                <label class="control-label">NVR 8 قنوات</label>
                                <select name="sw_nvr_8_basic" class="form-control select-search-full">
                                    <option value="">-- اختر منتج --</option>
                                    @foreach($products as $id => $name)
                                        <option value="{{ $id }}" @if(setting('sw_nvr_8_basic') == $id) selected @endif>{{ $name }}</option>
                                    @endforeach
                                </select>
                            </div>
                            <div class="col-md-4 form-group mb-3">
                                <label class="control-label">NVR 16 قناة</label>
                                <select name="sw_nvr_16_basic" class="form-control select-search-full">
                                    <option value="">-- اختر منتج --</option>
                                    @foreach($products as $id => $name)
                                        <option value="{{ $id }}" @if(setting('sw_nvr_16_basic') == $id) selected @endif>{{ $name }}</option>
                                    @endforeach
                                </select>
                            </div>
                            <div class="col-md-4 form-group mb-3">
                                <label class="control-label">NVR 32 قناة</label>
                                <select name="sw_nvr_32_basic" class="form-control select-search-full">
                                    <option value="">-- اختر منتج --</option>
                                    @foreach($products as $id => $name)
                                        <option value="{{ $id }}" @if(setting('sw_nvr_32_basic') == $id) selected @endif>{{ $name }}</option>
                                    @endforeach
                                </select>
                            </div>
                        </div>

                        <hr>
                        
                        <h5 class="mb-3 mt-4 text-danger">مساحات التخزين (هارد مراقبة)</h5>
                        <div class="row">
                            @foreach(\Botble\SystemWizard\Services\WizardCatalog::HDD_SIZES as $tb)
                                <div class="col-md-4 form-group mb-3">
                                    <label class="control-label">هارد {{ $tb }} تيرا</label>
                                    <select name="sw_hdd_{{ $tb }}tb" class="form-control select-search-full">
                                        <option value="">-- اختر منتج --</option>
                                        @foreach($products as $id => $name)
                                            <option value="{{ $id }}" @if(setting('sw_hdd_'.$tb.'tb') == $id) selected @endif>{{ $name }}</option>
                                        @endforeach
                                    </select>
                                </div>
                            @endforeach
                        </div>
                        
                        <hr>
                        
                        <h5 class="mb-3 mt-4 text-primary">نقاط الشبكة (Net Points)</h5>
                        <div class="row">
                            <div class="col-md-4 form-group mb-3">
                                <label class="control-label">نقطة شبكة (Basic - Cat5e)</label>
                                <select name="sw_netpoint_basic" class="form-control select-search-full">
                                    <option value="">-- اختر منتج --</option>
                                    @foreach($products as $id => $name)
                                        <option value="{{ $id }}" @if(setting('sw_netpoint_basic') == $id) selected @endif>{{ $name }}</option>
                                    @endforeach
                                </select>
                            </div>
                            <div class="col-md-4 form-group mb-3">
                                <label class="control-label">نقطة شبكة (Pro - Cat6)</label>
                                <select name="sw_netpoint_pro" class="form-control select-search-full">
                                    <option value="">-- اختر منتج --</option>
                                    @foreach($products as $id => $name)
                                        <option value="{{ $id }}" @if(setting('sw_netpoint_pro') == $id) selected @endif>{{ $name }}</option>
                                    @endforeach
                                </select>
                            </div>
                            <div class="col-md-4 form-group mb-3">
                                <label class="control-label">نقطة شبكة (Premium - Cat6A)</label>
                                <select name="sw_netpoint_prem" class="form-control select-search-full">
                                    <option value="">-- اختر منتج --</option>
                                    @foreach($products as $id => $name)
                                        <option value="{{ $id }}" @if(setting('sw_netpoint_prem') == $id) selected @endif>{{ $name }}</option>
                                    @endforeach
                                </select>
                            </div>
                        </div>

                        <hr>
                        
                        <h5 class="mb-3 mt-4 text-info">نقاط التلفزيون (TV Points)</h5>
                        <div class="row">
                            <div class="col-md-4 form-group mb-3">
                                <label class="control-label">نقطة تلفزيون (Basic)</label>
                                <select name="sw_tvpoint_basic" class="form-control select-search-full">
                                    <option value="">-- اختر منتج --</option>
                                    @foreach($products as $id => $name)
                                        <option value="{{ $id }}" @if(setting('sw_tvpoint_basic') == $id) selected @endif>{{ $name }}</option>
                                    @endforeach
                                </select>
                            </div>
                            <div class="col-md-4 form-group mb-3">
                                <label class="control-label">نقطة تلفزيون (Pro - HD)</label>
                                <select name="sw_tvpoint_pro" class="form-control select-search-full">
                                    <option value="">-- اختر منتج --</option>
                                    @foreach($products as $id => $name)
                                        <option value="{{ $id }}" @if(setting('sw_tvpoint_pro') == $id) selected @endif>{{ $name }}</option>
                                    @endforeach
                                </select>
                            </div>
                            <div class="col-md-4 form-group mb-3">
                                <label class="control-label">نقطة تلفزيون (Premium - 4K)</label>
                                <select name="sw_tvpoint_prem" class="form-control select-search-full">
                                    <option value="">-- اختر منتج --</option>
                                    @foreach($products as $id => $name)
                                        <option value="{{ $id }}" @if(setting('sw_tvpoint_prem') == $id) selected @endif>{{ $name }}</option>
                                    @endforeach
                                </select>
                            </div>
                        </div>

                        <hr>
                        
                        <h5 class="mb-3 mt-4 text-warning">كبائن الشبكة (Racks)</h5>
                        <div class="row">
                            <div class="col-md-4 form-group mb-3">
                                <label class="control-label">كبينة صغيرة (Basic)</label>
                                <select name="sw_rack_basic" class="form-control select-search-full">
                                    <option value="">-- اختر منتج --</option>
                                    @foreach($products as $id => $name)
                                        <option value="{{ $id }}" @if(setting('sw_rack_basic') == $id) selected @endif>{{ $name }}</option>
                                    @endforeach
                                </select>
                            </div>
                            <div class="col-md-4 form-group mb-3">
                                <label class="control-label">كبينة 6U (Pro)</label>
                                <select name="sw_rack_pro" class="form-control select-search-full">
                                    <option value="">-- اختر منتج --</option>
                                    @foreach($products as $id => $name)
                                        <option value="{{ $id }}" @if(setting('sw_rack_pro') == $id) selected @endif>{{ $name }}</option>
                                    @endforeach
                                </select>
                            </div>
                            <div class="col-md-4 form-group mb-3">
                                <label class="control-label">كبينة 9U (Premium)</label>
                                <select name="sw_rack_prem" class="form-control select-search-full">
                                    <option value="">-- اختر منتج --</option>
                                    @foreach($products as $id => $name)
                                        <option value="{{ $id }}" @if(setting('sw_rack_prem') == $id) selected @endif>{{ $name }}</option>
                                    @endforeach
                                </select>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            
            <div class="col-md-3">
                <div class="card">
                    <div class="card-header">
                        <h4 class="card-title">ثوابت عامة</h4>
                    </div>
                    <div class="card-body">
                        <div class="form-group mb-3">
                            <label class="control-label">سعر التركيب لكل نقطة (د.ك)</label>
                            <input type="number" name="sw_install_per_point" class="form-control" value="{{ setting('sw_install_per_point', 8) }}">
                        </div>
                        <div class="form-group mb-3">
                            <label class="control-label">رقم الواتساب (للتواصل)</label>
                            <input type="text" name="sw_whatsapp_number" class="form-control" placeholder="مثال: 965XXXXXXXX" value="{{ setting('sw_whatsapp_number', '') }}">
                            <small class="text-muted">بدون علامة + أو أصفار في البداية.</small>
                        </div>
                    </div>
                    <div class="card-footer">
                        <button type="submit" class="btn btn-primary w-100">حفظ الإعدادات</button>
                    </div>
                </div>
            </div>
        </div>
    </form>
@endsection

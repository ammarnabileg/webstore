@extends(BaseHelper::getAdminMasterLayoutTemplate())

@section('content')
    <div class="row">
        <div class="col-md-8 mx-auto">
            <div class="widget meta-boxes">
                <div class="widget-title">
                    <h4><i class="ti ti-brand-whatsapp"></i> {{ trans('WhatsApp Marketing Campaign') }}</h4>
                </div>
                <div class="widget-body">
                    @if(session('success_msg'))
                        <div class="alert alert-success">{{ session('success_msg') }}</div>
                    @endif
                    @if(session('error_msg'))
                        <div class="alert alert-danger">{{ session('error_msg') }}</div>
                    @endif
                    @if($queueIsSync)
                        <div class="alert alert-warning">QUEUE_CONNECTION=sync: الإرسال الجماعي متوقف. اضبطه على database وأضف cron لـ <code>php artisan schedule:run</code> كل دقيقة.</div>
                    @endif

                    <div class="alert alert-info">
                        <strong>{{ $customersCount }}</strong> {{ trans('customers with valid phone numbers will receive this message.') }}
                    </div>

                    <form action="{{ route('whatsapp.marketing.send') }}" method="POST">
                        @csrf
                        <div class="form-group mb-3">
                            <label class="control-label required">{{ trans('Message Content') }}</label>
                            <textarea name="message" class="form-control" rows="6" required placeholder="{{ trans('Type your promotional message here...') }}"></textarea>
                            <small class="form-text text-muted">{{ trans('You can use WhatsApp formatting like *bold*, _italic_, ~strikethrough~') }}</small>
                        </div>
                        
                        <div class="form-group">
                            <button type="submit" class="btn btn-info" onclick="return confirm('{{ trans('Are you sure you want to send this broadcast to all customers?') }}')">
                                <i class="fa fa-paper-plane"></i> {{ trans('Send Broadcast') }}
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <div class="col-12 mt-3 order-last">
            <div class="widget meta-boxes">
                <div class="widget-title">
                    <h4><i class="ti ti-history"></i> آخر الرسائل الجماعية</h4>
                </div>
                <div class="widget-body">
                    @if($broadcasts->isEmpty())
                        <p class="text-muted mb-0">لا توجد رسائل جماعية بعد.</p>
                    @else
                        <table class="table table-sm mb-0">
                            <thead>
                                <tr><th>#</th><th>الرسالة</th><th>الحالة</th><th>المستلمون</th><th>اتبعتت</th><th>فشلت</th><th>التاريخ</th></tr>
                            </thead>
                            <tbody>
                                @foreach($broadcasts as $broadcast)
                                    <tr>
                                        <td>{{ $broadcast->id }}</td>
                                        <td>{{ \Illuminate\Support\Str::limit($broadcast->message, 60) }}</td>
                                        <td>{{ ['queued' => 'في الطابور', 'sending' => 'بيتبعت', 'done' => 'خلص'][$broadcast->status] ?? $broadcast->status }}</td>
                                        <td>{{ $broadcast->total }}</td>
                                        <td class="text-success">{{ $broadcast->sent }}</td>
                                        <td class="text-danger">{{ $broadcast->failed }}</td>
                                        <td>{{ $broadcast->created_at?->format('Y-m-d H:i') }}</td>
                                    </tr>
                                @endforeach
                            </tbody>
                        </table>
                    @endif
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="widget meta-boxes">
                <div class="widget-title">
                    <h4><i class="ti ti-test-pipe"></i> {{ trans('Test WhatsApp Message') }}</h4>
                </div>
                <div class="widget-body">
                    <p class="text-muted">{{ trans('Send a test message to your own number to verify the API connection.') }}</p>

                    <form action="{{ route('whatsapp.marketing.test') }}" method="POST">
                        @csrf
                        <div class="form-group mb-3">
                            <label class="control-label required">{{ trans('Your Phone Number') }}</label>
                            <input type="text" name="test_phone" class="form-control" required placeholder="96512345678">
                        </div>
                        <div class="form-group mb-3">
                            <label class="control-label required">{{ trans('Test Message') }}</label>
                            <textarea name="test_message" class="form-control" rows="3" required>مرحباً، هذه رسالة تجريبية من النظام للتأكد من عمل الربط بنجاح!</textarea>
                        </div>
                        <div class="form-group">
                            <button type="submit" class="btn btn-warning w-100">
                                <i class="fa fa-vial"></i> {{ trans('Send Test') }}
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
@stop

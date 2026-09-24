@extends(BaseHelper::getAdminMasterLayoutTemplate())

@section('content')
    <div class="card">
        <div class="card-header">
            <h4 class="card-title">طلبات النظام الواردة</h4>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>الاسم</th>
                            <th>الموبايل</th>
                            <th>الباقة</th>
                            <th>التكلفة (د.ك)</th>
                            <th>تاريخ الطلب</th>
                            <th>التفاصيل والمكونات</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach($leads as $lead)
                            <tr>
                                <td>{{ $lead->name }}</td>
                                <td>{{ $lead->phone }}</td>
                                <td>
                                    @if($lead->package_tier == 'basic') الأساسية
                                    @elseif($lead->package_tier == 'pro') المحترفة
                                    @elseif($lead->package_tier == 'prem') الممتازة
                                    @else استشارة
                                    @endif
                                </td>
                                <td>{{ $lead->estimate ?? '-' }}</td>
                                <td>{{ $lead->created_at->format('Y-m-d H:i') }}</td>
                                <td>
                                    <button class="btn btn-sm btn-info" data-bs-toggle="modal" data-bs-target="#leadModal{{ $lead->id }}">عرض التفاصيل</button>
                                </td>
                            </tr>

                            <!-- Modal -->
                            <div class="modal fade" id="leadModal{{ $lead->id }}" tabindex="-1" aria-hidden="true">
                                <div class="modal-dialog modal-lg">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title">تفاصيل طلب {{ $lead->name }}</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <h6>إجابات العميل:</h6>
                                            @php $answers = is_string($lead->answers) ? json_decode($lead->answers, true) : $lead->answers; @endphp
                                            <ul>
                                                @if($answers)
                                                    @foreach($answers as $k => $v)
                                                        @if(!is_array($v))
                                                            <li><strong>{{ $k }}:</strong> {{ $v }}</li>
                                                        @endif
                                                    @endforeach
                                                @endif
                                            </ul>
                                            <hr>
                                            <h6>مكونات النظام (BOM):</h6>
                                            @php $bom = is_string($lead->bom) ? json_decode($lead->bom, true) : $lead->bom; @endphp
                                            @if($bom)
                                                <ul>
                                                @foreach($bom as $item)
                                                    <li>{{ $item['name'] ?? '' }} (العدد: {{ $item['qty'] ?? 1 }})</li>
                                                @endforeach
                                                </ul>
                                            @endif
                                        </div>
                                    </div>
                                </div>
                            </div>
                        @endforeach
                    </tbody>
                </table>
            </div>
            
            <div class="mt-3">
                {{ $leads->links() }}
            </div>
        </div>
    </div>
@endsection

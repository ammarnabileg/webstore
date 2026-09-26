@extends(BaseHelper::getAdminMasterLayoutTemplate())

@php
    use Botble\SystemWizard\Models\ProjectLead;

    $placeLabels = ['apartment' => 'شقة', 'villa' => 'فيلا / بيت', 'shop' => 'محل', 'office' => 'مكتب / شركة', 'warehouse' => 'مخزن / مصنع', 'compound' => 'عمارة / مجمع'];
    $goalLabels = ['entry' => 'مراقبة المداخل', 'indoor' => 'مراقبة داخلية', 'perimeter' => 'تأمين المحيط', 'wifi' => 'واي فاي', 'intercom' => 'إنتركم', 'alarm' => 'إنذار'];
    $areaLabels = ['أقل من 100م²', '100–250م²', '250–500م²', 'أكثر من 500م²'];
    $conditionLabels = ['قيد الإنشاء', 'في مرحلة التشطيب', 'جاهز ومُشطّب'];
    $recordLabels = ['أسبوع', 'أسبوعان', 'شهر', '3 أشهر', '6 أشهر'];
    $statusColors = ['new' => 'primary', 'contacted' => 'info', 'surveyed' => 'warning', 'quoted' => 'secondary', 'won' => 'success', 'lost' => 'danger'];
@endphp

@section('content')
    <div class="card">
        <div class="card-header d-flex flex-wrap gap-2 align-items-center justify-content-between">
            <h4 class="card-title mb-0">طلبات النظام الواردة</h4>
            <div class="btn-group flex-wrap" role="group" aria-label="تصفية حسب الحالة">
                <a href="{{ route('system-wizard.index') }}" class="btn btn-sm {{ $status ? 'btn-outline-secondary' : 'btn-secondary' }}">
                    الكل ({{ $counts->sum() }})
                </a>
                @foreach(ProjectLead::STATUSES as $key => $label)
                    <a href="{{ route('system-wizard.index', ['status' => $key]) }}" class="btn btn-sm {{ $status === $key ? 'btn-secondary' : 'btn-outline-secondary' }}">
                        {{ $label }} ({{ $counts[$key] ?? 0 }})
                    </a>
                @endforeach
            </div>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-striped table-hover align-middle">
                    <thead>
                        <tr>
                            <th>الاسم</th>
                            <th>الموبايل</th>
                            <th>المكان</th>
                            <th>الباقة</th>
                            <th>التقدير (د.ك)</th>
                            <th>الحالة</th>
                            <th>تاريخ الطلب</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($leads as $lead)
                            @php
                                $answers = $lead->answersData();
                                $bom = $lead->bomData();
                                $sketch = $answers['sketch'] ?? null;
                            @endphp
                            <tr>
                                <td>{{ $lead->name }}</td>
                                <td dir="ltr"><a href="https://wa.me/{{ preg_replace('/\D/', '', $lead->phone) }}" target="_blank" rel="noopener">{{ $lead->phone }}</a></td>
                                <td>{{ $placeLabels[$answers['place'] ?? ''] ?? ($answers['place'] ?? '—') }}</td>
                                <td>{{ ProjectLead::TIER_LABELS[$lead->package_tier] ?? $lead->package_tier }}</td>
                                <td>{{ $lead->estimate !== null ? number_format((float) $lead->estimate, 3) : '—' }}</td>
                                <td><span class="badge bg-{{ $statusColors[$lead->status] ?? 'secondary' }} text-white">{{ ProjectLead::STATUSES[$lead->status] ?? $lead->status }}</span></td>
                                <td>{{ $lead->created_at->format('Y-m-d H:i') }}</td>
                                <td>
                                    <button class="btn btn-sm btn-info" data-bs-toggle="modal" data-bs-target="#leadModal{{ $lead->id }}">عرض التفاصيل</button>
                                </td>
                            </tr>

                            <div class="modal fade" id="leadModal{{ $lead->id }}" tabindex="-1" aria-hidden="true">
                                <div class="modal-dialog modal-lg">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title">طلب {{ $lead->name }}</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="إغلاق"></button>
                                        </div>
                                        <div class="modal-body">
                                            <form method="POST" action="{{ route('system-wizard.leads.status', $lead->id) }}" class="d-flex gap-2 align-items-end mb-3">
                                                @csrf
                                                <div class="flex-grow-1">
                                                    <label class="form-label" for="status{{ $lead->id }}">حالة الطلب</label>
                                                    <select name="status" id="status{{ $lead->id }}" class="form-select">
                                                        @foreach(ProjectLead::STATUSES as $key => $label)
                                                            <option value="{{ $key }}" @selected($lead->status === $key)>{{ $label }}</option>
                                                        @endforeach
                                                    </select>
                                                </div>
                                                <button type="submit" class="btn btn-primary">حفظ</button>
                                            </form>

                                            <h6>إجابات العميل</h6>
                                            <ul>
                                                @if(isset($answers['area']) && is_int($answers['area']))
                                                    <li><strong>المساحة:</strong> {{ $areaLabels[$answers['area']] ?? '—' }}</li>
                                                @endif
                                                @if(isset($answers['condition']) && is_int($answers['condition']))
                                                    <li><strong>حالة المكان:</strong> {{ $conditionLabels[$answers['condition']] ?? '—' }}</li>
                                                @endif
                                                @if(! empty($answers['goals']) && is_array($answers['goals']))
                                                    <li><strong>الاحتياج:</strong> {{ collect($answers['goals'])->map(fn ($g) => $goalLabels[$g] ?? $g)->implode('، ') }}</li>
                                                @endif
                                                @if(isset($answers['recordDays']) && is_int($answers['recordDays']))
                                                    <li><strong>مدة التسجيل:</strong> {{ $recordLabels[$answers['recordDays']] ?? '—' }}</li>
                                                @endif
                                                @if(isset($answers['cams']))
                                                    <li><strong>الكاميرات المقترحة:</strong> {{ $answers['cams']['indoor'] ?? 0 }} داخلية · {{ $answers['cams']['outdoor'] ?? 0 }} خارجية</li>
                                                @endif
                                                @if(! empty($answers['aps']))
                                                    <li><strong>نقاط الواي فاي:</strong> {{ $answers['aps'] }}</li>
                                                @endif
                                                @if($sketch)
                                                    <li><strong>المخطط:</strong> {{ count($sketch['rooms'] ?? []) }} منطقة و{{ count($sketch['pins'] ?? []) }} علامة</li>
                                                @endif
                                                {{-- Leads submitted before the new format stored readable labels directly --}}
                                                @foreach($answers as $k => $v)
                                                    @if(! is_array($v) && ! in_array($k, ['place', 'area', 'condition', 'recordDays', 'aps'], true) && $v !== null && $v !== '')
                                                        <li><strong>{{ $k }}:</strong> {{ is_bool($v) ? ($v ? 'نعم' : 'لا') : $v }}</li>
                                                    @endif
                                                @endforeach
                                            </ul>

                                            @if($bom)
                                                <hr>
                                                <h6>مكونات النظام</h6>
                                                <ul>
                                                    @foreach($bom as $item)
                                                        <li>{{ $item['name'] ?? '' }} × {{ $item['qty'] ?? 1 }}</li>
                                                    @endforeach
                                                </ul>
                                            @endif
                                        </div>
                                    </div>
                                </div>
                            </div>
                        @empty
                            <tr><td colspan="8" class="text-center text-muted py-4">لا توجد طلبات{{ $status ? ' بهذه الحالة' : '' }}.</td></tr>
                        @endforelse
                    </tbody>
                </table>
            </div>

            <div class="mt-3">
                {{ $leads->links() }}
            </div>
        </div>
    </div>
@endsection

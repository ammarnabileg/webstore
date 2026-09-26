<!DOCTYPE html>
<html lang="ar" dir="rtl">
<head>
    <meta charset="utf-8">
    <style>
        body { font-family: Tahoma, Arial, sans-serif; line-height: 1.6; color: #333; direction: rtl; text-align: right; }
        .container { max-width: 600px; margin: 0 auto; padding: 20px; border: 1px solid #ddd; border-radius: 8px; }
        .header { background: #0e6b62; color: #fff; padding: 15px; text-align: center; border-radius: 8px 8px 0 0; }
        .content { padding: 20px; }
        .row { margin-bottom: 10px; border-bottom: 1px solid #eee; padding-bottom: 10px; }
        .label { font-weight: bold; color: #555; }
        .val { font-size: 16px; color: #000; }
        .btn { display: inline-block; padding: 10px 20px; background: #25D366; color: #fff; text-decoration: none; border-radius: 5px; font-weight: bold; margin-top: 20px; text-align: center;}
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h2>طلب نظام مراقبة جديد</h2>
        </div>
        <div class="content">
            <div class="row">
                <span class="label">اسم العميل:</span>
                <span class="val">{{ $lead->name }}</span>
            </div>
            <div class="row">
                <span class="label">رقم الهاتف:</span>
                <span class="val" dir="ltr">{{ $lead->phone }}</span>
            </div>
            <div class="row">
                <span class="label">الباقة المختارة:</span>
                <span class="val">{{ \Botble\SystemWizard\Models\ProjectLead::TIER_LABELS[$lead->package_tier] ?? $lead->package_tier }}</span>
            </div>
            <div class="row">
                <span class="label">التكلفة التقديرية:</span>
                <span class="val">{{ $lead->estimate !== null ? $lead->estimate . ' د.ك (تقديري)' : '—' }}</span>
            </div>
            
            @php
                $bom = $lead->bomData();
            @endphp
            @if($bom)
            <div class="row">
                <span class="label">المكونات (BOM):</span>
                <ul style="margin-top:5px; padding-right:20px;">
                    @foreach($bom as $item)
                        <li>{{ $item['qty'] ?? 1 }}x {{ $item['name'] ?? '' }}</li>
                    @endforeach
                </ul>
            </div>
            @endif

            <div style="text-align: center;">
                <a href="https://wa.me/{{ preg_replace('/[^0-9]/', '', $lead->phone) }}" class="btn">تواصل مع العميل عبر واتساب</a>
            </div>
        </div>
    </div>
</body>
</html>

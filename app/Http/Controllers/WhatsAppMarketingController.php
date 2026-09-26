<?php

namespace App\Http\Controllers;

use App\Jobs\SendWhatsAppBroadcastJob;
use App\Models\WhatsAppBroadcast;
use App\Services\EvolutionApiService;
use Botble\Base\Http\Controllers\BaseController;
use Botble\Ecommerce\Models\Customer;
use Illuminate\Http\Request;

class WhatsAppMarketingController extends BaseController
{
    public function getIndex()
    {
        page_title()->setTitle('WhatsApp Marketing');

        $customersCount = Customer::query()->whereNotNull('phone')->where('phone', '!=', '')->count();
        $broadcasts = WhatsAppBroadcast::query()->latest('id')->limit(10)->get();
        $queueIsSync = config('queue.default') === 'sync';

        return view('whatsapp-marketing', compact('customersCount', 'broadcasts', 'queueIsSync'));
    }

    public function postSend(Request $request)
    {
        $data = $request->validate([
            'message' => ['required', 'string', 'max:4000'],
        ]);

        // With the sync driver the whole broadcast would run inside this request again.
        if (config('queue.default') === 'sync') {
            return redirect()->back()->with('error_msg', 'لا يمكن الإرسال الجماعي والـ queue على sync. اضبط QUEUE_CONNECTION=database وشغّل الـ cron.');
        }

        // One broadcast at a time: a double-click or a second admin must not send twice.
        if (WhatsAppBroadcast::query()->whereIn('status', ['queued', 'sending'])->exists()) {
            return redirect()->back()->with('error_msg', 'فيه رسالة جماعية لسه بتتبعت. استنى لحد ما تخلص.');
        }

        $broadcast = WhatsAppBroadcast::query()->create([
            'message' => $data['message'],
            'status' => 'queued',
            'created_by' => $request->user()?->getKey(),
        ]);

        SendWhatsAppBroadcastJob::dispatch($broadcast->id);

        return redirect()->back()->with('success_msg', 'الرسالة اتحطت في الطابور وهتبدأ تتبعت خلال دقيقة. تابع العدادات في الجدول تحت.');
    }

    public function postSendTest(Request $request, EvolutionApiService $evolutionApi)
    {
        $request->validate([
            'test_phone' => ['required', 'string', 'max:30'],
            'test_message' => ['required', 'string', 'max:4000'],
        ]);

        $result = $evolutionApi->sendMessage($request->input('test_phone'), $request->input('test_message'));

        if ($result) {
            return redirect()->back()->with('success_msg', 'تم إرسال الرسالة التجريبية بنجاح!');
        }

        return redirect()->back()->with('error_msg', 'فشل إرسال الرسالة التجريبية. يرجى مراجعة سجل الأخطاء.');
    }
}

<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Services\EvolutionApiService;
use Botble\Ecommerce\Models\Customer;
use Botble\Base\Http\Controllers\BaseController;

class WhatsAppMarketingController extends BaseController
{
    public function getIndex()
    {
        page_title()->setTitle('WhatsApp Marketing');
        $customersCount = Customer::whereNotNull('phone')->count();

        return view('whatsapp-marketing', compact('customersCount'));
    }

    public function postSend(Request $request, EvolutionApiService $evolutionApi)
    {
        $request->validate([
            'message' => 'required|string',
        ]);

        $message = $request->input('message');
        
        // Fetch all customers with phone numbers
        $customers = Customer::whereNotNull('phone')->get();
        $sentCount = 0;

        foreach ($customers as $customer) {
            if ($customer->phone) {
                // Ideally this should be queued (Bus::dispatch(new SendWhatsAppMessageJob(...)))
                // For demonstration, sending directly or queuing inline
                $evolutionApi->sendMessage($customer->phone, $message);
                $sentCount++;
            }
        }

        return redirect()->back()->with('success_msg', "تم إرسال الرسالة بنجاح إلى {$sentCount} عميل.");
    }

    public function postSendTest(Request $request, EvolutionApiService $evolutionApi)
    {
        $request->validate([
            'test_phone' => 'required|string',
            'test_message' => 'required|string',
        ]);

        $phone = $request->input('test_phone');
        $message = $request->input('test_message');

        $result = $evolutionApi->sendMessage($phone, $message);

        if ($result) {
            return redirect()->back()->with('success_msg', 'تم إرسال الرسالة التجريبية بنجاح!');
        } else {
            return redirect()->back()->with('error_msg', 'فشل إرسال الرسالة التجريبية. يرجى مراجعة سجل الأخطاء.');
        }
    }
}

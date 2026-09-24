<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class WhatsAppWebhookController extends Controller
{
    public function handle(Request $request)
    {
        // 1. Only accept calls that carry the shared token configured in Evolution's webhook headers
        //    (EVOLUTION_WEBHOOK_TOKEN). Without it anyone could post fake events.
        $expected = (string) config('services.evolution.webhook_token');
        // Header only: a token in the query string ends up in web server access logs.
        $given = (string) $request->header('X-Webhook-Token', '');

        if ($expected === '' || ! hash_equals($expected, $given)) {
            return response()->json(['status' => 'unauthorized'], 401);
        }

        // 2. التحقق من نوع الحدث (Evolution API يرسل أحداثاً مختلفة)
        $event = $request->input('event');

        // الحدث الخاص بالرسائل الواردة الجديدة هو messages.upsert
        if ($event === 'messages.upsert') {
            $messageData = $request->input('data');
            
            // استخراج بيانات المرسل (رقم الهاتف متبوعاً بـ @s.whatsapp.net)
            $remoteJid = $messageData['key']['remoteJid'] ?? '';
            
            // تجاهل رسائل الحالة (Status) أو المجموعات (Groups) إذا كنت تستهدف المحادثات الفردية فقط
            if (str_contains($remoteJid, '@g.us') || $remoteJid === 'status@broadcast') {
                return response()->json(['status' => 'ignored']);
            }

            // استخراج نوع الرسالة والنص
            $messageType = $messageData['messageType'] ?? '';
            $text = '';

            if ($messageType === 'conversation') {
                $text = $messageData['message']['conversation'] ?? '';
            } elseif ($messageType === 'extendedTextMessage') {
                $text = $messageData['message']['extendedTextMessage']['text'] ?? '';
            }

            // --- هنا يمكنك كتابة الكود الخاص بك ---
            // Do not log message bodies or full numbers: they are customer personal data.
            Log::info('WhatsApp message received', ['type' => $messageType, 'from_suffix' => substr($remoteJid, -6)]);
            // مثلاً: حفظ الرسالة في قاعدة البيانات، أو استدعاء دالة لإرسال رد تلقائي
            
        }

        // 3. الأهم: يجب دائماً إرجاع استجابة 200 OK بسرعة حتى لا يعتبر السيرفر أن الطلب فشل
        return response()->json(['status' => 'success'], 200);
    }
}

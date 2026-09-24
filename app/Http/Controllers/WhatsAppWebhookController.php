<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class WhatsAppWebhookController extends Controller
{
    public function handle(Request $request)
    {
        // 1. تسجيل البيانات الواردة في ملف الـ Log لفهم الهيكلة (مفيد جداً في مرحلة التطوير)
        Log::info('WhatsApp Webhook Received:', $request->all());

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
            Log::info("New Message from $remoteJid: $text");
            // مثلاً: حفظ الرسالة في قاعدة البيانات، أو استدعاء دالة لإرسال رد تلقائي
            
        }

        // 3. الأهم: يجب دائماً إرجاع استجابة 200 OK بسرعة حتى لا يعتبر السيرفر أن الطلب فشل
        return response()->json(['status' => 'success'], 200);
    }
}

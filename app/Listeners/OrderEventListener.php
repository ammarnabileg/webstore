<?php

namespace App\Listeners;

use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\RateLimiter;
use Botble\Ecommerce\Events\OrderPlacedEvent;
use App\Services\EvolutionApiService;
use App\Support\KuwaitPhone;

class OrderEventListener implements ShouldQueue
{
    use InteractsWithQueue;

    protected $evolutionApi;

    public function __construct(EvolutionApiService $evolutionApi)
    {
        $this->evolutionApi = $evolutionApi;
    }

    public function handleOrderPlaced(OrderPlacedEvent $event)
    {
        $order = $event->order;
        $customer = $order->user;
        $address = $order->address;

        // The order-address phone is free text typed at checkout (guest COD included), so it is an
        // attacker-chosen recipient. Confirmations are delivered from the store's own WhatsApp
        // Business number, so an unrestricted send lets anyone use it to message arbitrary numbers
        // (harassment / spam / getting the business number rate-limited or banned). Two guards:
        //   1. Only send to a valid Kuwaiti number — the store's only market.
        //   2. Cap sends per recipient so the store cannot be driven as a bulk relay.
        $phone = KuwaitPhone::normalize($address->phone ?? ($customer->phone ?? null));

        if (! $phone || ! KuwaitPhone::isKuwaiti($phone)) {
            return;
        }

        $executed = RateLimiter::attempt(
            'wa-order-confirm:' . $phone,
            maxAttempts: 5,
            callback: function () use ($order, $phone): void {
                $orderCode = $order->code;
                $amount = format_price($order->amount);
                // Use the admin-set store title, not a hardcoded brand. Message stays Arabic:
                // this runs in a queued listener (no reliable request locale) and confirmations
                // only go to Kuwaiti numbers, so Arabic is the right default for this market.
                $storeName = (function_exists('theme_option') ? theme_option('site_title') : null) ?: config('app.name', 'متجرنا');

                $message = "شكراً لك على طلبك من {$storeName}!\n\n";
                $message .= "🛒 رقم الطلب: *{$orderCode}*\n";
                $message .= "💰 الإجمالي: *{$amount}*\n\n";
                $message .= "سنقوم بتجهيز طلبك بأسرع وقت. يمكنك تتبع طلبك عبر حسابك في الموقع.";

                $this->evolutionApi->sendMessage($phone, $message);
            },
            decaySeconds: 3600,
        );

        if (! $executed) {
            Log::warning('Order confirmation WhatsApp suppressed: recipient send rate exceeded.');
        }
    }
}

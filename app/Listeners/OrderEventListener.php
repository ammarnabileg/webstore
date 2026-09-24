<?php

namespace App\Listeners;

use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Queue\InteractsWithQueue;
use Botble\Ecommerce\Events\OrderPlacedEvent;
use App\Services\EvolutionApiService;

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

        $phone = $address->phone ?? ($customer->phone ?? null);

        if (!$phone) {
            return; // No phone to send to
        }

        $orderCode = $order->code;
        $amount = format_price($order->amount);

        $message = "شكراً لك على طلبك من Laly Kuwait!\n\n";
        $message .= "🛒 رقم الطلب: *{$orderCode}*\n";
        $message .= "💰 الإجمالي: *{$amount}*\n\n";
        $message .= "سنقوم بتجهيز طلبك بأسرع وقت. يمكنك تتبع طلبك عبر حسابك في الموقع.";

        $this->evolutionApi->sendMessage($phone, $message);
    }
}

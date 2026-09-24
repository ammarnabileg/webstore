<?php

namespace Botble\Ecommerce\Jobs;

use Botble\Ecommerce\Models\CustomerFcmToken;
use Botble\Ecommerce\Models\Notification;
use Botble\Ecommerce\Services\FirebaseMessagingService;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Log;
use Throwable;

class SendFCMNotificationJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected Notification $notification;

    public function __construct(Notification $notification)
    {
        $this->notification = $notification;
    }

    public function handle(FirebaseMessagingService $messagingService): void
    {
        try {
            $query = CustomerFcmToken::query();

            if ($this->notification->type === 'guest') {
                $query->whereNull('customer_id');
            } elseif ($this->notification->type === 'logged_in') {
                $query->whereNotNull('customer_id');
            }

            $query->chunk(500, function ($tokens) use ($messagingService) {
                $tokenList = $tokens->pluck('token')->all();
                $messagingService->sendMulticast($tokenList, $this->notification);
            });

            $this->notification->update(['status' => 'published']);
        } catch (Throwable $exception) {
            Log::error('SendFCMNotificationJob Failed: ' . $exception->getMessage(), ['exception' => $exception]);
            $this->notification->update(['status' => 'failed']);
        }
    }

    public function failed(Throwable $exception): void
    {
        $this->notification->update(['status' => 'failed']);
    }
}

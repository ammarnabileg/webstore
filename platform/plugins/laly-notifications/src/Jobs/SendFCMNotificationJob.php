<?php

namespace Botble\LalyNotifications\Jobs;

use Botble\LalyNotifications\Models\CustomerFcmToken;
use Botble\LalyNotifications\Models\Notification;
use Botble\LalyNotifications\Services\FirebaseMessagingService;
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

            $sent = 0;
            $failed = 0;

            // chunkById: invalid tokens are deleted while iterating, which would make offset paging skip rows.
            $query->chunkById(500, function ($tokens) use ($messagingService, &$sent, &$failed) {
                $result = $messagingService->sendMulticast($tokens->pluck('token')->all(), $this->notification);
                $sent += $result['success'];
                $failed += $result['failure'];
            });

            Log::info('Push notification sent', ['notification' => $this->notification->id, 'sent' => $sent, 'failed' => $failed]);
        } catch (Throwable $exception) {
            Log::error('SendFCMNotificationJob failed: ' . $exception->getMessage(), ['notification' => $this->notification->id]);
        }

        // "published" also makes it visible in the storefront list, which must not depend on push delivery.
        $this->notification->update(['status' => 'published']);
    }

    public function failed(Throwable $exception): void
    {
        $this->notification->update(['status' => 'published']);
    }
}

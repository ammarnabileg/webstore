<?php

namespace Botble\Ecommerce\Commands;

use Botble\Ecommerce\Jobs\SendFCMNotificationJob;
use Botble\Ecommerce\Models\Notification;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Log;

class SendScheduledNotificationsCommand extends Command
{
    protected $signature = 'ecommerce:notifications:send';

    protected $description = 'Send scheduled ecommerce notifications via FCM Queue Jobs with atomic lock';

    public function handle(): int
    {
        $this->info('Starting scheduled notifications dispatch...');

        $now = now();

        $updated = Notification::query()
            ->where('status', 'scheduled')
            ->where('scheduled_at', '<=', $now)
            ->update(['status' => 'sending']);

        if ($updated === 0) {
            $this->info('No scheduled notifications to send.');
            return self::SUCCESS;
        }

        $notifications = Notification::query()
            ->where('status', 'sending')
            ->where('scheduled_at', '<=', $now)
            ->get();

        foreach ($notifications as $notification) {
            $this->info("Dispatching SendFCMNotificationJob for notification ID: {$notification->id}");
            dispatch(new SendFCMNotificationJob($notification));
        }

        $this->info('Scheduled notifications dispatched successfully.');

        return self::SUCCESS;
    }
}

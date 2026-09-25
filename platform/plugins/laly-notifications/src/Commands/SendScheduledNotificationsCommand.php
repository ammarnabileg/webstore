<?php

namespace Botble\LalyNotifications\Commands;

use Botble\LalyNotifications\Jobs\SendFCMNotificationJob;
use Botble\LalyNotifications\Models\Notification;
use Illuminate\Console\Command;

class SendScheduledNotificationsCommand extends Command
{
    protected $signature = 'laly-notifications:send-scheduled';

    protected $description = 'Queue push notifications whose scheduled time has come';

    public function handle(): int
    {
        $due = Notification::query()
            ->where('status', 'scheduled')
            ->where('scheduled_at', '<=', now())
            ->pluck('id');

        $queued = 0;

        foreach ($due as $id) {
            // Claim each row atomically so an overlapping run cannot queue it twice.
            $claimed = Notification::query()->whereKey($id)->where('status', 'scheduled')->update(['status' => 'sending']);

            if ($claimed) {
                SendFCMNotificationJob::dispatch(Notification::query()->find($id));
                $queued++;
            }
        }

        $this->info("Queued {$queued} scheduled notification(s).");

        return self::SUCCESS;
    }
}

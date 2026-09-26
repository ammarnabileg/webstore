<?php

namespace App\Jobs;

use App\Models\WhatsAppBroadcast;
use App\Models\WhatsAppBroadcastRecipient;
use App\Services\EvolutionApiService;
use App\Support\KuwaitPhone;
use Botble\Ecommerce\Models\Customer;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;

/**
 * Sends one broadcast in small batches: each run sends BATCH messages and queues the next run,
 * so a job never outlives the queue's retry_after and a crash resumes where it stopped.
 * Every recipient row moves pending -> sending -> sent/failed, and only "pending" rows are
 * picked up, so a retried job never messages the same number twice.
 */
class SendWhatsAppBroadcastJob implements ShouldQueue
{
    use Dispatchable;
    use InteractsWithQueue;
    use Queueable;
    use SerializesModels;

    public const BATCH = 20;

    public int $tries = 3;

    public int $timeout = 80;

    public function __construct(public int $broadcastId)
    {
    }

    public function handle(EvolutionApiService $evolution): void
    {
        $broadcast = WhatsAppBroadcast::query()->find($this->broadcastId);

        if (! $broadcast || $broadcast->status === 'done') {
            return;
        }

        if ($broadcast->status === 'queued') {
            $this->buildRecipients($broadcast);
            $broadcast->update(['status' => 'sending']);
        }

        $batch = WhatsAppBroadcastRecipient::query()
            ->where('broadcast_id', $broadcast->id)
            ->where('status', 'pending')
            ->orderBy('id')
            ->limit(self::BATCH)
            ->get();

        foreach ($batch as $recipient) {
            // Claim the row first; if the worker dies mid-send it stays "sending" and is not retried.
            $claimed = WhatsAppBroadcastRecipient::query()
                ->whereKey($recipient->id)->where('status', 'pending')
                ->update(['status' => 'sending', 'updated_at' => now()]);

            if (! $claimed) {
                continue;
            }

            $ok = (bool) $evolution->sendMessage($recipient->phone, $broadcast->message);

            $recipient->forceFill(['status' => $ok ? 'sent' : 'failed'])->save();
            $broadcast->increment($ok ? 'sent' : 'failed');
        }

        $remaining = WhatsAppBroadcastRecipient::query()
            ->where('broadcast_id', $broadcast->id)->where('status', 'pending')->exists();

        if ($remaining) {
            static::dispatch($broadcast->id);

            return;
        }

        // Rows left in "sending" were interrupted mid-request: outcome unknown, count them failed.
        $unknown = WhatsAppBroadcastRecipient::query()
            ->where('broadcast_id', $broadcast->id)->where('status', 'sending')
            ->update(['status' => 'failed', 'updated_at' => now()]);

        if ($unknown) {
            $broadcast->increment('failed', $unknown);
        }

        $broadcast->update(['status' => 'done', 'finished_at' => now()]);
    }

    protected function buildRecipients(WhatsAppBroadcast $broadcast): void
    {
        Customer::query()
            ->select(['id', 'phone'])
            ->whereNotNull('phone')->where('phone', '!=', '')
            ->where(fn ($q) => $q->whereNull('status')->orWhere('status', '!=', 'locked'))
            ->chunkById(500, function ($customers) use ($broadcast): void {
                $rows = [];

                foreach ($customers as $customer) {
                    $phone = KuwaitPhone::normalize($customer->phone);

                    if ($phone) {
                        $rows[] = [
                            'broadcast_id' => $broadcast->id,
                            'customer_id' => $customer->id,
                            'phone' => $phone,
                            'status' => 'pending',
                            'created_at' => now(),
                            'updated_at' => now(),
                        ];
                    }
                }

                // Duplicate numbers hit the (broadcast_id, phone) unique key and are skipped.
                WhatsAppBroadcastRecipient::query()->insertOrIgnore($rows);
            });

        $broadcast->update(['total' => $broadcast->recipients()->count()]);
    }
}

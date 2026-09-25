<?php

namespace App\Console\Commands;

use App\Support\KuwaitPhone;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

/**
 * Rewrites stored phone numbers into the 965XXXXXXXX format and reports customers that share a
 * number. It never deletes or merges accounts: duplicates are for a person to review.
 */
class NormalizeCustomerPhones extends Command
{
    protected $signature = 'customers:normalize-phones {--dry-run : Report only, change nothing}';

    protected $description = 'Normalize customer/address phone numbers and report duplicate customer phones';

    public function handle(): int
    {
        $dryRun = (bool) $this->option('dry-run');

        foreach (['ec_customers', 'ec_customer_addresses', 'ec_order_addresses'] as $table) {
            if (! Schema::hasTable($table)) {
                continue;
            }

            [$changed, $invalid] = $this->normalizeTable($table, $dryRun);
            $this->line(sprintf('%s: %d %s, %d not recognised (left as is)', $table, $changed, $dryRun ? 'would change' : 'changed', $invalid));
        }

        return $this->reportDuplicates();
    }

    /**
     * @return array{0: int, 1: int}
     */
    protected function normalizeTable(string $table, bool $dryRun): array
    {
        $changed = 0;
        $invalid = 0;

        DB::table($table)->select(['id', 'phone'])->whereNotNull('phone')->where('phone', '!=', '')
            ->chunkById(500, function ($rows) use ($table, $dryRun, &$changed, &$invalid): void {
                foreach ($rows as $row) {
                    $normalized = KuwaitPhone::normalize($row->phone);

                    if (! $normalized) {
                        $invalid++;

                        continue;
                    }

                    if ($normalized !== $row->phone) {
                        $changed++;

                        if (! $dryRun) {
                            // Query builder on purpose: same number in a new format, so model
                            // events (which clear phone_verified_at on a number change) stay out.
                            DB::table($table)->where('id', $row->id)->update(['phone' => $normalized]);
                        }
                    }
                }
            });

        return [$changed, $invalid];
    }

    protected function reportDuplicates(): int
    {
        $groups = [];

        DB::table('ec_customers')->select(['id', 'name', 'email', 'phone', 'phone_verified_at', 'created_at'])
            ->whereNotNull('phone')->where('phone', '!=', '')
            ->orderBy('id')
            ->each(function ($row) use (&$groups): void {
                $key = KuwaitPhone::normalize($row->phone) ?? $row->phone;
                $groups[$key][] = $row;
            });

        $duplicates = array_filter($groups, fn (array $rows) => count($rows) > 1);

        if (! $duplicates) {
            $this->info('No two customers share a phone number. A unique index on ec_customers.phone is safe to add.');

            return self::SUCCESS;
        }

        $orders = DB::table('ec_orders')->select('user_id', DB::raw('COUNT(*) as total'))
            ->whereIn('user_id', collect($duplicates)->flatten(1)->pluck('id'))
            ->groupBy('user_id')->pluck('total', 'user_id');

        $dir = storage_path('app/reports');
        if (! is_dir($dir)) {
            mkdir($dir, 0750, true);
        }

        $path = $dir . '/duplicate-phones-' . now()->format('Ymd-His') . '.csv';
        $file = fopen($path, 'w');
        fputcsv($file, ['phone', 'customer_id', 'name', 'email', 'orders', 'phone_verified_at', 'created_at']);

        foreach ($duplicates as $phone => $rows) {
            foreach ($rows as $row) {
                fputcsv($file, [$phone, $row->id, $row->name, $row->email, $orders[$row->id] ?? 0, $row->phone_verified_at, $row->created_at]);
            }
        }

        fclose($file);

        $this->warn(sprintf('%d phone numbers are shared by more than one customer. Review %s before adding a unique index.', count($duplicates), $path));

        return self::SUCCESS;
    }
}

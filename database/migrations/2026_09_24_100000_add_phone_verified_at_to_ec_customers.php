<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class () extends Migration {
    public function up(): void
    {
        if (! Schema::hasTable('ec_customers') || Schema::hasColumn('ec_customers', 'phone_verified_at')) {
            return;
        }

        Schema::table('ec_customers', function (Blueprint $table): void {
            $table->timestamp('phone_verified_at')->nullable()->after('phone');
            $table->index(['phone', 'phone_verified_at']);
        });

        // Accounts created by the WhatsApp OTP flow could only be reached by proving the number.
        // Only the exact shape that flow produces (email = "<phone>@whatsapp.local"), so an account
        // registered with an arbitrary @whatsapp.local email is not promoted. Accounts that already
        // replaced the placeholder email during onboarding cannot be told apart from an account
        // where someone typed another person's number, so they are left unverified on purpose.
        DB::table('ec_customers')
            ->select(['id', 'phone', 'email', 'created_at'])
            ->where('email', 'like', '%@whatsapp.local')
            ->whereNotNull('phone')
            ->orderBy('id')
            ->each(function ($row): void {
                if (strtolower($row->email) === $row->phone . '@whatsapp.local') {
                    DB::table('ec_customers')->where('id', $row->id)
                        ->update(['phone_verified_at' => $row->created_at ?? now()]);
                }
            });
    }

    public function down(): void
    {
        Schema::table('ec_customers', function (Blueprint $table): void {
            $table->dropIndex(['phone', 'phone_verified_at']);
            $table->dropColumn('phone_verified_at');
        });
    }
};

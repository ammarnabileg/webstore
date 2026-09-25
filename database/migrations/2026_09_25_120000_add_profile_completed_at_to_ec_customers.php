<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class () extends Migration {
    public function up(): void
    {
        if (! Schema::hasTable('ec_customers') || Schema::hasColumn('ec_customers', 'profile_completed_at')) {
            return;
        }

        Schema::table('ec_customers', function (Blueprint $table): void {
            $table->timestamp('profile_completed_at')->nullable()->after('phone_verified_at');
        });

        // The WhatsApp "complete profile" endpoint may set email/password without the current
        // password only ONCE, while the account is still finishing sign-up. Detecting that by the
        // "<phone>@whatsapp.local" placeholder email was permanent: an account that never replaced
        // the placeholder kept the waiver forever. This flag makes onboarding a one-time state.
        //
        // Backfill: any account that did NOT come from the WhatsApp placeholder flow has already
        // chosen its own credentials, so it must always require the current password -> mark it
        // completed. Placeholder-email accounts are left null so they can still finish onboarding
        // once; the first completeProfile/registerWithOtp call then stamps them.
        DB::table('ec_customers')
            ->whereNull('profile_completed_at')
            ->where(function ($q): void {
                $q->whereNull('email')->orWhere('email', 'not like', '%@whatsapp.local');
            })
            ->update(['profile_completed_at' => DB::raw('COALESCE(updated_at, created_at, NOW())')]);
    }

    public function down(): void
    {
        Schema::table('ec_customers', function (Blueprint $table): void {
            $table->dropColumn('profile_completed_at');
        });
    }
};

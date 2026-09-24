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
        DB::table('ec_customers')
            ->where('email', 'like', '%@whatsapp.local')
            ->whereNotNull('phone')
            ->update(['phone_verified_at' => DB::raw('created_at')]);
    }

    public function down(): void
    {
        Schema::table('ec_customers', function (Blueprint $table): void {
            $table->dropIndex(['phone', 'phone_verified_at']);
            $table->dropColumn('phone_verified_at');
        });
    }
};

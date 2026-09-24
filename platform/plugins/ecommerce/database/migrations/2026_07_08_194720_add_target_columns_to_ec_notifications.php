<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class () extends Migration {
    public function up(): void
    {
        Schema::table('ec_notifications', function (Blueprint $table) {
            if (!Schema::hasColumn('ec_notifications', 'target_type')) {
                $table->string('target_type', 60)->default('none')->after('type');
            }
            if (!Schema::hasColumn('ec_notifications', 'target_id')) {
                $table->unsignedBigInteger('target_id')->nullable()->after('target_type');
            }
        });
    }

    public function down(): void
    {
        Schema::table('ec_notifications', function (Blueprint $table) {
            if (Schema::hasColumn('ec_notifications', 'target_type')) {
                $table->dropColumn('target_type');
            }
            if (Schema::hasColumn('ec_notifications', 'target_id')) {
                $table->dropColumn('target_id');
            }
        });
    }
};

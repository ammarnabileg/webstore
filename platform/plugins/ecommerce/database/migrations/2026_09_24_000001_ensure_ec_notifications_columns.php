<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

// Replaces the public GET /fix-db-notifications route that used to patch this table over HTTP.
return new class () extends Migration {
    public function up(): void
    {
        if (! Schema::hasTable('ec_notifications')) {
            return;
        }

        $columns = [
            'target_type' => fn (Blueprint $table) => $table->string('target_type', 60)->default('none')->after('type'),
            'target_id' => fn (Blueprint $table) => $table->unsignedBigInteger('target_id')->nullable()->after('target_type'),
            'custom_url' => fn (Blueprint $table) => $table->string('custom_url', 255)->nullable()->after('target_id'),
            'status' => fn (Blueprint $table) => $table->string('status', 60)->default('draft')->after('custom_url'),
            'scheduled_at' => fn (Blueprint $table) => $table->timestamp('scheduled_at')->nullable()->after('status'),
        ];

        foreach ($columns as $column => $definition) {
            if (! Schema::hasColumn('ec_notifications', $column)) {
                Schema::table('ec_notifications', $definition);
            }
        }
    }

    public function down(): void
    {
        // Columns are owned by the create/add migrations; nothing to undo here.
    }
};

<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class () extends Migration {
    public function up(): void
    {
        if (! Schema::hasTable('ec_notifications')) {
            Schema::create('ec_notifications', function (Blueprint $table): void {
                $table->id();
                $table->string('title', 255);
                $table->text('description')->nullable();
                $table->string('type', 60)->default('all'); // guest, logged_in, all
                $table->string('target_type', 60)->default('none'); // category, collection, custom_url, none
                $table->unsignedBigInteger('target_id')->nullable();
                $table->string('custom_url', 255)->nullable();
                $table->string('status', 60)->default('draft'); // draft, scheduled, published, sending, failed
                $table->timestamp('scheduled_at')->nullable();
                $table->timestamps();
            });
        }
    }

    public function down(): void
    {
        Schema::dropIfExists('ec_notifications');
    }
};

<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class () extends Migration {
    public function up(): void
    {
        if (! Schema::hasTable('ec_customer_fcm_tokens')) {
            Schema::create('ec_customer_fcm_tokens', function (Blueprint $table): void {
                $table->id();
                $table->unsignedBigInteger('customer_id')->nullable()->index();
                $table->string('token', 255)->unique();
                $table->string('device_type', 50)->default('web');
                $table->timestamps();
            });
        }
    }

    public function down(): void
    {
        Schema::dropIfExists('ec_customer_fcm_tokens');
    }
};

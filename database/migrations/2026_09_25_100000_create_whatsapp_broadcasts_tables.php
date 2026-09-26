<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class () extends Migration {
    public function up(): void
    {
        Schema::create('whatsapp_broadcasts', function (Blueprint $table): void {
            $table->id();
            $table->text('message');
            $table->string('status', 20)->default('queued'); // queued, sending, done
            $table->unsignedInteger('total')->default(0);
            $table->unsignedInteger('sent')->default(0);
            $table->unsignedInteger('failed')->default(0);
            $table->unsignedBigInteger('created_by')->nullable();
            $table->timestamp('finished_at')->nullable();
            $table->timestamps();
        });

        Schema::create('whatsapp_broadcast_recipients', function (Blueprint $table): void {
            $table->id();
            $table->foreignId('broadcast_id')->constrained('whatsapp_broadcasts')->cascadeOnDelete();
            $table->unsignedBigInteger('customer_id')->nullable();
            $table->string('phone', 20);
            $table->string('status', 20)->default('pending'); // pending, sending, sent, failed
            $table->timestamps();

            // One message per number per broadcast, even when two accounts share a number.
            $table->unique(['broadcast_id', 'phone']);
            $table->index(['broadcast_id', 'status']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('whatsapp_broadcast_recipients');
        Schema::dropIfExists('whatsapp_broadcasts');
    }
};

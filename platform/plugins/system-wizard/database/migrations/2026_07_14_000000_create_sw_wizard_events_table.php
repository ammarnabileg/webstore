<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('sw_wizard_events', function (Blueprint $table) {
            $table->id();
            $table->string('session_id')->index();
            $table->string('step');
            $table->string('action');
            $table->json('payload')->nullable();
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('sw_wizard_events');
    }
};

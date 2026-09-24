<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('ai_seo_logs', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('product_id');
            $table->string('model')->nullable();
            $table->string('prompt_hash')->nullable();
            $table->integer('prompt_version')->default(1);
            $table->json('prompt_variables')->nullable();
            $table->longText('raw_output')->nullable();
            $table->json('tokens')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('ai_seo_logs');
    }
};

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
        Schema::create('sw_project_leads', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('phone');
            $table->json('answers')->nullable();
            $table->string('package_tier')->nullable();
            $table->integer('estimate')->nullable();
            $table->json('bom')->nullable();
            $table->enum('status', ['new', 'contacted', 'surveyed', 'quoted', 'won', 'lost'])->default('new');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('sw_project_leads');
    }
};

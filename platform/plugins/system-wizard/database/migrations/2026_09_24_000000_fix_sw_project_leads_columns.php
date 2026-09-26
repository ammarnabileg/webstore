<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class () extends Migration {
    public function up(): void
    {
        if (! Schema::hasTable('sw_project_leads')) {
            return;
        }

        // KWD has 3 decimals (fils); an integer column dropped them.
        Schema::table('sw_project_leads', function (Blueprint $table): void {
            $table->decimal('estimate', 12, 3)->nullable()->change();
            $table->index(['status', 'created_at']);
        });

        // answers/bom used to be json_encode()d AND cast to JSON, i.e. stored as a JSON string.
        DB::table('sw_project_leads')->orderBy('id')->each(function ($row): void {
            $updates = [];

            foreach (['answers', 'bom'] as $column) {
                $decoded = json_decode((string) $row->{$column}, true);

                if (is_string($decoded)) {
                    $updates[$column] = $decoded;
                }
            }

            if ($updates) {
                DB::table('sw_project_leads')->where('id', $row->id)->update($updates);
            }
        });
    }

    public function down(): void
    {
        Schema::table('sw_project_leads', function (Blueprint $table): void {
            $table->dropIndex(['status', 'created_at']);
            $table->integer('estimate')->nullable()->change();
        });
    }
};

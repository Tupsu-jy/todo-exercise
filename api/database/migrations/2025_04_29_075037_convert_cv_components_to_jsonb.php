<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // First add temporary columns
        Schema::table('cv_components', function (Blueprint $table) {
            $table->jsonb('text_en_jsonb')->nullable();
            $table->jsonb('text_fi_jsonb')->nullable();
        });

        // Convert data
        DB::table('cv_components')->get()->each(function ($component) {
            $textEn = $component->category === 'entry' 
                ? json_decode($component->text_en, true) 
                : $component->text_en;
                
            $textFi = $component->category === 'entry' 
                ? json_decode($component->text_fi, true) 
                : $component->text_fi;
                
            DB::table('cv_components')
                ->where('id', $component->id)
                ->update([
                    'text_en_jsonb' => json_encode($textEn),
                    'text_fi_jsonb' => json_encode($textFi)
                ]);
        });

        // Drop old columns and rename new ones
        Schema::table('cv_components', function (Blueprint $table) {
            $table->dropColumn(['text_en', 'text_fi']);
        });
        
        Schema::table('cv_components', function (Blueprint $table) {
            $table->renameColumn('text_en_jsonb', 'text_en');
            $table->renameColumn('text_fi_jsonb', 'text_fi');
        });
        
        // Add indexes
        Schema::table('cv_components', function (Blueprint $table) {
            $table->index('text_en', 'idx_cv_components_text_en', 'gin');
            $table->index('text_fi', 'idx_cv_components_text_fi', 'gin');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        // Add temporary text columns
        Schema::table('cv_components', function (Blueprint $table) {
            $table->text('text_en_text')->nullable();
            $table->text('text_fi_text')->nullable();
        });

        // Convert data back to text
        DB::table('cv_components')->get()->each(function ($component) {
            DB::table('cv_components')
                ->where('id', $component->id)
                ->update([
                    'text_en_text' => json_encode($component->text_en),
                    'text_fi_text' => json_encode($component->text_fi)
                ]);
        });

        // Drop indexes
        Schema::table('cv_components', function (Blueprint $table) {
            $table->dropIndex('idx_cv_components_text_en');
            $table->dropIndex('idx_cv_components_text_fi');
        });

        // Drop JSONB columns and rename text columns
        Schema::table('cv_components', function (Blueprint $table) {
            $table->dropColumn(['text_en', 'text_fi']);
        });
        
        Schema::table('cv_components', function (Blueprint $table) {
            $table->renameColumn('text_en_text', 'text_en');
            $table->renameColumn('text_fi_text', 'text_fi');
        });
    }
};

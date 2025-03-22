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
        Schema::table('cv_component_mappings', function (Blueprint $table) {
            $table->foreign(['component_id'], 'cv_component_mappings_component_id_fkey')->references(['id'])->on('cv_components')->onUpdate('no action')->onDelete('cascade');
            $table->foreign(['cv_id'], 'cv_component_mappings_cv_id_fkey')->references(['id'])->on('cvs')->onUpdate('no action')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('cv_component_mappings', function (Blueprint $table) {
            $table->dropForeign('cv_component_mappings_component_id_fkey');
            $table->dropForeign('cv_component_mappings_cv_id_fkey');
        });
    }
};

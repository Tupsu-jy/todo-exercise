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
        Schema::create('cv_component_mappings', function (Blueprint $table) {
            $table->id();
            $table->uuid('cv_id');
            $table->uuid('component_id');
            $table->integer('display_order')->nullable();

            $table->unique(['cv_id', 'component_id']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('cv_component_mappings');
    }
};

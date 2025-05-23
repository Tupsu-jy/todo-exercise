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
        Schema::create('cv_components', function (Blueprint $table) {
            $table->uuid('id')->default(DB::raw('uuid_generate_v4()'))->primary();
            $table->text('category')->nullable();
            $table->text('text_en')->nullable();
            $table->text('text_fi')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('cv_components');
    }
};

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
        Schema::create('project_infos', function (Blueprint $table) {
            $table->id();
            $table->text('text_en');
            $table->text('text_fi');
        });

        // Lisätään yksi oletusrivi
        DB::table('project_infos')->insert([
            'text_en' => 'lisää infoteksti kantaan',
            'text_fi' => 'lisää infoteksti kantaan',
        ]);
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('project_infos');
    }
};
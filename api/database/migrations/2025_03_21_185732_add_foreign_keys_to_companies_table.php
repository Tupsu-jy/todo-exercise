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
        Schema::table('companies', function (Blueprint $table) {
            $table->foreign(['cover_letter_id'], 'companies_cover_letter_id_fkey')->references(['id'])->on('cover_letters')->onUpdate('no action')->onDelete('set null');
            $table->foreign(['cv_id'], 'companies_cv_id_fkey')->references(['id'])->on('cvs')->onUpdate('no action')->onDelete('set null');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('companies', function (Blueprint $table) {
            $table->dropForeign('companies_cover_letter_id_fkey');
            $table->dropForeign('companies_cv_id_fkey');
        });
    }
};

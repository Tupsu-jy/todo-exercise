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
        Schema::table('notepads', function (Blueprint $table) {
            $table->foreign(['company_id'], 'notepads_company_id_fkey')->references(['id'])->on('companies')->onUpdate('no action')->onDelete('set null');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('notepads', function (Blueprint $table) {
            $table->dropForeign('notepads_company_id_fkey');
        });
    }
};

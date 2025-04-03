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
        Schema::create('notepad_orders', function (Blueprint $table) {
            $table->uuid('id')->default(DB::raw('uuid_generate_v4()'))->primary();
            $table->uuid('company_id')->nullable()->index('idx_notepad_orders_company_id');
            $table->uuid('notepad_id')->nullable()->index('idx_notepad_orders_notepad_id');
            $table->integer('order_index');

            $table->foreign(['company_id'], 'notepad_orders_company_id_fkey')->references(['id'])->on('companies')->onUpdate('no action')->onDelete('cascade');
            $table->foreign(['notepad_id'], 'notepad_orders_notepad_id_fkey')->references(['id'])->on('notepads')->onUpdate('no action')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('notepad_orders');
    }
};

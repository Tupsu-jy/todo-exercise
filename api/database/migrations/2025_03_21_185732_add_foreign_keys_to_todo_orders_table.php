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
        Schema::table('todo_orders', function (Blueprint $table) {
            $table->foreign(['notepad_id'], 'todo_orders_notepad_id_fkey')->references(['id'])->on('notepads')->onUpdate('no action')->onDelete('cascade');
            $table->foreign(['todo_id'], 'todo_orders_todo_id_fkey')->references(['id'])->on('todos')->onUpdate('no action')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('todo_orders', function (Blueprint $table) {
            $table->dropForeign('todo_orders_notepad_id_fkey');
            $table->dropForeign('todo_orders_todo_id_fkey');
        });
    }
};

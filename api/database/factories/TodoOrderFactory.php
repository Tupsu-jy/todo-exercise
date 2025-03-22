<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use App\Models\Notepad;
use App\Models\Todo;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\TodoOrder>
 */
class TodoOrderFactory extends Factory
{
    public function definition()
    {
        return [
            'notepad_id' => Notepad::factory(),
            'todo_id' => Todo::factory(),
            'order_index' => fake()->numberBetween(1, 100)
        ];
    }
}
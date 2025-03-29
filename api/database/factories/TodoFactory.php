<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use App\Models\Notepad;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Todo>
 */
class TodoFactory extends Factory
{
    public function definition()
    {
        return [
            'notepad_id' => Notepad::factory(),
            'description' => fake()->sentence(),
            'is_completed' => fake()->boolean()
        ];
    }
}
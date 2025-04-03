<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use App\Models\Notepad;
use App\Models\Company;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\NotepadOrder>
 */
class NotepadOrderFactory extends Factory
{
    public function definition()
    {
        return [
            'company_id' => Company::factory(),
            'notepad_id' => Notepad::factory(),
            'order_index' => fake()->numberBetween(1, 100)
        ];
    }
}
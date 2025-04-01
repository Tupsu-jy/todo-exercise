<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use App\Models\Company;
/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Notepad>
 */
class NotepadFactory extends Factory
{
    public function definition()
    {
        return [
            'name' => fake()->words(3, true), // e.g., "Project Planning Notes"
            'company_id' => Company::factory(),
            'order_version' => 0
        ];
    }
}
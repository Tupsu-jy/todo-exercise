<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\CoverLetter>
 */
class CoverLetterFactory extends Factory
{
    public function definition()
    {
        return [
            'name' => fake()->unique()->words(2, true), // e.g., "Software Engineer"
            'letter_en' => fake()->paragraphs(3, true),
            'letter_fi' => fake()->paragraphs(3, true)
        ];
    }
}
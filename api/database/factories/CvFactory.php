<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use App\Models\Cv;
/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Cv>
 */
class CvFactory extends Factory
{
    public function definition()
    {
        return [
            'version_name' => fake()->unique()->words(2, true) // e.g., "Technical Version"
        ];
    }
}

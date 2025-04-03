<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use App\Models\Cv;
use App\Models\CoverLetter;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Company>
 */
class CompanyFactory extends Factory
{
    public function definition()
    {
        return [
            'company_slug' => fake()->unique()->slug(), // e.g., "google-inc"
            'cv_id' => Cv::factory(),          // Creates and links a CV
            'cover_letter_id' => CoverLetter::factory(), // Creates and links a Cover Letter
            'order_version' => 0
        ];
    }
}
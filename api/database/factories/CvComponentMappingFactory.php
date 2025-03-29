<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use App\Models\Cv;
use App\Models\CvComponent;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\CvComponentMapping>
 */
class CvComponentMappingFactory extends Factory
{
    public function definition()
    {
        return [
            'cv_id' => Cv::factory(),
            'component_id' => CvComponent::factory(),
            'display_order' => fake()->numberBetween(1, 2500)
        ];
    }
}

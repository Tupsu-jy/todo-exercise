<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\CvComponent>
 */
class CvComponentFactory extends Factory
{
    public function definition()
    {
        return [
            'category' => fake()->randomElement([
                'contact-info', 'name', 'degree', 
                'title', 'entry_name', 'entry_text'
            ]),
            'text_en' => fake()->paragraph(),
            'text_fi' => fake()->paragraph()
        ];
    }
}

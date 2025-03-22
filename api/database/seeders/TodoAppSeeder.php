<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Cv;
use App\Models\CvComponent;
use App\Models\CvComponentMapping;
use App\Models\Company;
use App\Models\Notepad;
use App\Models\Todo;
use App\Models\TodoOrder;

class TodoAppSeeder extends Seeder
{
    public function run()
    {
        // Create CVs and components through mappings
        Cv::factory()
            ->count(2)
            ->create()
            ->each(function ($cv) {
                // Create components for each CV
                $components = CvComponent::factory()
                    ->count(5)
                    ->create();

                // Create mappings for each component
                foreach ($components as $component) {
                    CvComponentMapping::factory()
                        ->create([
                            'cv_id' => $cv->id,
                            'component_id' => $component->id
                        ]);
                }
            });

        // Create companies with notepads and todos
        Company::factory()
            ->count(3)
            ->has(
                Notepad::factory()
                    ->count(2)
                    ->has(
                        Todo::factory()
                            ->count(5)
                            ->afterCreating(function ($todo, $notepad) {
                                // Create order for each todo
                                TodoOrder::create([
                                    'notepad_id' => $todo->notepad_id,
                                    'todo_id' => $todo->id,
                                    'order_index' => fake()->unique()->numberBetween(1, 25000)
                                ]);
                            })
                    )
            )
            ->create();
    }
}
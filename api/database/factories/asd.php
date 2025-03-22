// database/factories/CvFactory.php
class CvFactory extends Factory
{
    public function definition()
    {
        return [
            'id' => fake()->uuid(),
            'version_name' => fake()->unique()->words(2, true) // e.g., "Technical Version"
        ];
    }
}

// database/factories/CoverLetterFactory.php
class CoverLetterFactory extends Factory
{
    public function definition()
    {
        return [
            'id' => fake()->uuid(),
            'name' => fake()->unique()->words(2, true), // e.g., "Software Engineer"
            'letter_en' => fake()->paragraphs(3, true),
            'letter_fi' => fake()->paragraphs(3, true)
        ];
    }
}

// database/factories/CompanyFactory.php
class CompanyFactory extends Factory
{
    public function definition()
    {
        return [
            'id' => fake()->uuid(),
            'company_slug' => fake()->unique()->slug(), // e.g., "google-inc"
            'cv_id' => Cv::factory(),          // Creates and links a CV
            'cover_letter_id' => CoverLetter::factory() // Creates and links a Cover Letter
        ];
    }
}

// database/factories/NotepadFactory.php
class NotepadFactory extends Factory
{
    public function definition()
    {
        return [
            'id' => fake()->uuid(),
            'name' => fake()->words(3, true), // e.g., "Project Planning Notes"
            'company_id' => Company::factory(),
            'order_version' => 0
        ];
    }
}

// database/factories/TodoFactory.php
class TodoFactory extends Factory
{
    public function definition()
    {
        return [
            'id' => fake()->uuid(),
            'notepad_id' => Notepad::factory(),
            'description' => fake()->sentence(),
            'is_completed' => fake()->boolean()
        ];
    }
}

// database/factories/TodoOrderFactory.php
class TodoOrderFactory extends Factory
{
    public function definition()
    {
        return [
            'id' => fake()->uuid(),
            'notepad_id' => Notepad::factory(),
            'todo_id' => Todo::factory(),
            'order_index' => fake()->numberBetween(1, 100)
        ];
    }
}

// database/factories/CvComponentFactory.php
class CvComponentFactory extends Factory
{
    public function definition()
    {
        return [
            'id' => fake()->uuid(),
            'cv_id' => Cv::factory(),
            'category' => fake()->randomElement([
                'contact-info', 'name', 'degree', 
                'title', 'entry_name', 'entry_text'
            ]),
            'text_en' => fake()->paragraph(),
            'text_fi' => fake()->paragraph()
        ];
    }
}

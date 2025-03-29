<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Cv;
use App\Models\CvComponent;
use App\Models\CvComponentMapping;
use App\Models\Company;
use App\Models\Notepad;
use App\Models\Todo;
use App\Models\TodoOrder;
use App\Models\CoverLetter;

class InitSeeder extends Seeder
{
    public function run()
    {
        // 1. Create your CV versions
        $generalCv = Cv::create([
            'version_name' => 'General CV'
        ]);

        // 2. Create cover letter
        $coverLetter = CoverLetter::create([
            'name' => 'First Cover Letter',
            'letter_en' => 'hire me!!!!',
            'letter_fi' => 'oispa töitä!!!!',
        ]);

        // 2. Create CV components
        $components = [
            // Example structure:
            CvComponent::create([
                'category' => 'job_title',
                'text_en' => 'Information and Communication Technology Engineer',
                'text_fi' => 'Tieto- ja viestintätekniikan insinööri'
            ]),
            CvComponent::create([
                'category' => 'contact_info',
                'text_en' => "Phone: +358 40 7389684
Email: ylinenjaakko@gmail.com
Address: 00410 Helsinki
GitHub: Tupsu-jy",
                'text_fi' => "Puhelin: +358 40 7389684
Sähköposti: ylinenjaakko@gmail.com
Asuinpaikka: 00410 Helsinki
GitHub: Tupsu-jy"
            ]),
            CvComponent::create([
                'category' => 'section_header',
                'text_en' => 'Skills',
                'text_fi' => 'Osaaminen'
            ]),
            CvComponent::create([
                'category' => 'entry',
                'text_en' => '{"title": "Programming", "content": "Java, Python, JavaScript, TypeScript, PHP"}',
                'text_fi' => '{"title": "Ohjelmointi", "content": "Java, Python, JavaScript, TypeScript, PHP"}'
            ]),
            CvComponent::create([
                'category' => 'entry',
                'text_en' => '{"title": "Frameworks", "content": "React, Spring Boot, Django, Express, Next.js"}',
                'text_fi' => '{"title": "Ohjelmistokehykset", "content": "React, Spring Boot, Django, Express, Next.js"}'
            ]),
            CvComponent::create([
                'category' => 'entry',
                'text_en' => '{"title": "Databases", "content": "PostgreSQL, MongoDB"}',
                'text_fi' => '{"title": "Tietokannat", "content": "PostgreSQL, MongoDB"}'
            ]),
            CvComponent::create([
                'category' => 'entry',
                'text_en' => '{"title": "Tools", "content": "Git, Docker, Linux, Jira, Confluence, Selenium"}',
                'text_fi' => '{"title": "Työkalut", "content": "Git, Docker, Linux, Jira, Confluence, Selenium"}'
            ]),
            CvComponent::create([
                'category' => 'entry',
                'text_en' => '{"title": "Methods", "content": "CI/CD, Agile, Scrum, TDD"}',
                'text_fi' => '{"title": "Menetelmät", "content": "CI/CD, Agile, Scrum, TDD"}'
            ]),
            CvComponent::create([
                'category' => 'entry',
                'text_en' => '{"title": "Languages", "content": "Finnish(native), English(fluent)"}',
                'text_fi' => '{"title": "Kielet", "content": "Suomi(äidinkieli), englanti(erinomainen)"}'
            ]),
            CvComponent::create([
                'category' => 'section_header',
                'text_en' => 'Education',
                'text_fi' => 'Koulutus'
            ]),
            CvComponent::create([
                'category' => 'entry',
                'text_en' => '{"title": "Metropolia University of Applied Sciences", "content": "Tieto- ja viestintätekniikka (08.2019 - 01.2025). 240 op pituinen koulutusohjelma (265/240 op suoritettu). Ohjelmistotuotanto pääaineena."}',
                'text_fi' => '{"title": "Metropolian ammattikorkeakoulu", "content": "ICT (08.2019 - 01.2025). 240 credit (265/240 credit completed). Software production as major."}'
            ]),
            CvComponent::create([
                'category' => 'entry',
                'text_en' => '{"title": "Helsinki University", "content": "Computer Science (08.2013 - 10.2017) (94 credits completed)"}',
                'text_fi' => '{"title": "Helsingin yliopisto", "content": "Tietojenkäsittelytiede (08.2013 - 10.2017) (94 op suoritettu)"}'
            ]),
            CvComponent::create([
                'category' => 'section_header',
                'text_en' => 'Work Experience',
                'text_fi' => 'Työkokemus'
            ]),
            CvComponent::create([
                'category' => 'entry',
                'text_en' => '{"title": "Documill", "content": "Software Designer from 10.5.2021 to 20.8.2021 and from 17.3.2020 to 31.12.2020. The work was related to a development project for an online document editing service for Java-based software. Technologies and tools used in the development work: Java, JavaScript, CSS, HTML, GIT, JUnit, and Selenium. I worked as part of a team, using English as the working language."}',
                'text_fi' => '{"title": "Documill", "content": "Ohjelmistosuunnittelija 10.5.2021-20.8.2021 ja 17.3.2020-31.12.2020 välisinä aikoina. Työtehtävät liittyivät Java-pohjaisen ohjelmistojen dokumenttien online-editoinnin mahdollistavan verkkopalvelun kehityshankkeeseen. Kehitystyössä käytetyt tekniikat ja välineet: Java, JavaScript, CSS, HTML, GIT, JUnit ja Selenium. Työskentelin osana tiimiä, käyttäen englantia työkielenä."}'
            ]),
            CvComponent::create([
                'category' => 'entry',
                'text_en' => '{"title": "Iconicchain", "content": "Thesis work during 4.2024-10.2024. I implemented a data migration for the databases of a production product. I modified the software to be compatible with the new data format, both in the React frontend and the Python backend."}',
                'text_fi' => '{"title": "Iconicchain", "content": "Opinnäytetyö 4.2024-10.2024 välisenä aikana. Toteutin datamigraation tuotannossa olevan tuotteen tietokantoihin. Muokkasin ohjelmiston yhteensopivaksi uuden tietoformaatin kanssa, sekä React-frontendissä että Python-backendissä."}'
            ]),
            CvComponent::create([
                'category' => 'entry',
                'text_en' => '{"title": "Outlier", "content": "Software Developer since 20.1.2025. The work tasks are related to producing high-quality training data for LLMs. I write high quality complete code that can be used to train models. I use multiple programming languages ​​in diverse situations."}',
                'text_fi' => '{"title": "Outlier", "content": "Ohjelmistokehittäjä 20.1.2025 alkaen. Työtehtävät liittyvät korkealaatuisen koulutusdatan tuottamiseen tekoälymalleille. Kirjoitan täydellistä koodia, joka voidaan käyttää mallien koulutukseen. Käytän useita ohjelmointikieliä monipuolisissa tilanteissa."}'
            ]),
            CvComponent::create([
                'category' => 'section_header',
                'text_en' => 'Cover Letter',
                'text_fi' => 'Hakukirje'
            ]),
        ];

        // 3. Map components to CVs
        foreach ($components as $index => $component) {
            CvComponentMapping::create([
                'cv_id' => $generalCv->id,
                'component_id' => $component->id,
                'display_order' => ($index + 1) * 10
            ]);
        }

        // 4. Create companies
        $company1 = Company::create([
            'company_slug' => 'one4all',
            'cv_id' => $generalCv->id,
            'cover_letter_id' => $coverLetter->id
        ]);

        // 5. Create notepads for company
        $notepad1 = Notepad::create([
            'name' => 'Mikäs tää nyt on?',
            'company_id' => $company1->id
        ]);

        $notepad2 = Notepad::create([
            'name' => 'Whats this now?',
            'company_id' => $company1->id
        ]);

        // 6. Create todos with specific order
        $todos1 = [
            $todo1 = Todo::create([
                'notepad_id' => $notepad1->id,
                'description' => 'Tutki vähän miten tää toimii',
                'is_completed' => false
            ]),
            $todo2 = Todo::create([
                'notepad_id' => $notepad1->id,
                'description' => 'Lue CV',
                'is_completed' => false
            ]),
            $todo3 = Todo::create([
                'notepad_id' => $notepad1->id,
                'description' => 'Lue hakukirje',
                'is_completed' => false
            ]),
            $todo4 = Todo::create([
                'notepad_id' => $notepad1->id,
                'description' => 'Katsele koodia vähän GitHubissa',
                'is_completed' => false
            ]),
            $todo5 = Todo::create([
                'notepad_id' => $notepad1->id,
                'description' => 'Ole vaikuttunut',
                'is_completed' => false
            ]),
            $todo6 = Todo::create([
                'notepad_id' => $notepad1->id,
                'description' => 'Kutsu haastatteluun',
                'is_completed' => false
            ]),
            $todo7 = Todo::create([
                'notepad_id' => $notepad1->id,
                'description' => 'Palkkaa :D',
                'is_completed' => false
            ])
        ];

        $todos2 = [
            $todo1 = Todo::create([
                'notepad_id' => $notepad2->id,
                'description' => 'Figure out how this works',
                'is_completed' => false
            ]),
            $todo2 = Todo::create([
                'notepad_id' => $notepad2->id,
                'description' => 'Read CV',
                'is_completed' => false
            ]),
            $todo3 = Todo::create([
                'notepad_id' => $notepad2->id,
                'description' => 'Read cover letter',
                'is_completed' => false
            ]),
            $todo4 = Todo::create([
                'notepad_id' => $notepad2->id,
                'description' => 'Look at the code on GitHub',
                'is_completed' => false
            ]),
            $todo5 = Todo::create([
                'notepad_id' => $notepad2->id,
                'description' => 'Be impressed',
                'is_completed' => false
            ]),
            $todo6 = Todo::create([
                'notepad_id' => $notepad2->id,
                'description' => 'Invite for an interview',
                'is_completed' => false
            ]),
            $todo7 = Todo::create([
                'notepad_id' => $notepad2->id,
                'description' => 'Hire this guy :D',
                'is_completed' => false
            ])
        ];

        // 7. Create todo orders
        foreach ($todos1 as $index => $todo) {
            TodoOrder::create([
                'notepad_id' => $notepad1->id,
                'todo_id' => $todo->id,
                'order_index' => ($index + 1) * 1000 // Gives space between items for reordering
            ]);
        }

        foreach ($todos2 as $index => $todo) {
            TodoOrder::create([
                'notepad_id' => $notepad2->id,
                'todo_id' => $todo->id,
                'order_index' => ($index + 1) * 1000 // Gives space between items for reordering
            ]);
        }
    }
}
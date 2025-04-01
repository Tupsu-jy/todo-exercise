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
            CvComponent::create([
                'category' => 'job_title',
                'text_en' => 'Software Development Engineer',
                'text_fi' => 'Ohjelmistokehittäjä'
            ]),
            CvComponent::create([
                'category' => 'contact_info',
                'text_en' => "Phone: +358 40 1234567
Email: john.doe@example.com
Address: 00100 Helsinki
GitHub: johndoe-dev",
                'text_fi' => "Puhelin: +358 40 1234567
Sähköposti: john.doe@example.com
Asuinpaikka: 00100 Helsinki
GitHub: johndoe-dev"
            ]),
            CvComponent::create([
                'category' => 'section_header',
                'text_en' => 'Skills',
                'text_fi' => 'Osaaminen'
            ]),
            CvComponent::create([
                'category' => 'entry',
                'text_en' => '{"title": "Programming", "content": "C++, Ruby, Go, Rust, Swift"}',
                'text_fi' => '{"title": "Ohjelmointi", "content": "C++, Ruby, Go, Rust, Swift"}'
            ]),
            CvComponent::create([
                'category' => 'entry',
                'text_en' => '{"title": "Frameworks", "content": "Vue.js, Laravel, Ruby on Rails, Flutter, Angular"}',
                'text_fi' => '{"title": "Ohjelmistokehykset", "content": "Vue.js, Laravel, Ruby on Rails, Flutter, Angular"}'
            ]),
            CvComponent::create([
                'category' => 'entry',
                'text_en' => '{"title": "Databases", "content": "MySQL, Redis, Cassandra"}',
                'text_fi' => '{"title": "Tietokannat", "content": "MySQL, Redis, Cassandra"}'
            ]),
            CvComponent::create([
                'category' => 'entry',
                'text_en' => '{"title": "Tools", "content": "AWS, Azure, Kubernetes, Jenkins, Terraform"}',
                'text_fi' => '{"title": "Työkalut", "content": "AWS, Azure, Kubernetes, Jenkins, Terraform"}'
            ]),
            CvComponent::create([
                'category' => 'entry',
                'text_en' => '{"title": "Methods", "content": "Kanban, DevOps, Microservices, DDD"}',
                'text_fi' => '{"title": "Menetelmät", "content": "Kanban, DevOps, Microservices, DDD"}'
            ]),
            CvComponent::create([
                'category' => 'entry',
                'text_en' => '{"title": "Languages", "content": "Finnish(native), English(fluent), Swedish(basic)"}',
                'text_fi' => '{"title": "Kielet", "content": "Suomi(äidinkieli), englanti(erinomainen), ruotsi(perusteet)"}'
            ]),
            CvComponent::create([
                'category' => 'section_header',
                'text_en' => 'Education',
                'text_fi' => 'Koulutus'
            ]),
            CvComponent::create([
                'category' => 'entry',
                'text_en' => '{"title": "Technical University of Innovation", "content": "Computer Science (09.2018 - 06.2023). 300 ECTS program (290/300 completed). Specialization in Cloud Computing."}',
                'text_fi' => '{"title": "Teknillinen innovaatioyliopisto", "content": "Tietotekniikka (09.2018 - 06.2023). 300 op ohjelma (290/300 suoritettu). Erikoistuminen pilvilaskentaan."}'
            ]),
            CvComponent::create([
                'category' => 'entry',
                'text_en' => '{"title": "City College of Technology", "content": "Information Systems (08.2015 - 05.2018) (120 credits completed)"}',
                'text_fi' => '{"title": "Kaupungin teknologiakorkeakoulu", "content": "Tietojärjestelmät (08.2015 - 05.2018) (120 op suoritettu)"}'
            ]),
            CvComponent::create([
                'category' => 'section_header',
                'text_en' => 'Work Experience',
                'text_fi' => 'Työkokemus'
            ]),
            CvComponent::create([
                'category' => 'entry',
                'text_en' => '{"title": "TechCorp Solutions", "content": "Senior Developer from 03.2021 to 12.2023. Developed cloud-native applications using microservices architecture. Led a team of 5 developers in implementing new features and maintaining existing systems. Technologies: Kubernetes, Go, MongoDB, Redis."}',
                'text_fi' => '{"title": "TechCorp Solutions", "content": "Senior kehittäjä 03.2021-12.2023. Kehitin pilvinatiiveja sovelluksia mikropalveluarkkitehtuurilla. Johdin 5 hengen kehitystiimiä uusien ominaisuuksien toteutuksessa ja ylläpidossa. Teknologiat: Kubernetes, Go, MongoDB, Redis."}'
            ]),
            CvComponent::create([
                'category' => 'entry',
                'text_en' => '{"title": "DataFlow Systems", "content": "Full Stack Developer during 06.2020-02.2021. Implemented real-time data processing pipelines and visualization dashboards. Worked with React, Node.js, and PostgreSQL in an agile team environment."}',
                'text_fi' => '{"title": "DataFlow Systems", "content": "Full Stack kehittäjä 06.2020-02.2021. Toteutin reaaliaikaisia datankäsittelyputkia ja visualisointinäkymiä. Työskentelin React, Node.js ja PostgreSQL teknologioilla ketterässä tiimissä."}'
            ]),
            CvComponent::create([
                'category' => 'entry',
                'text_en' => '{"title": "CloudScale Inc", "content": "Cloud Engineer since 01.2024. Designing and implementing scalable cloud infrastructure solutions. Working with AWS, Terraform, and containerization technologies. Focus on automation and infrastructure as code."}',
                'text_fi' => '{"title": "CloudScale Inc", "content": "Pilvi-insinööri 01.2024 alkaen. Suunnittelen ja toteutan skaalautuvia pilvi-infrastruktuuriratkaisuja. Työskentelen AWS:n, Terraformin ja kontitusteknologioiden parissa. Painopiste automaatiossa ja infrastruktuurissa koodina."}'
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
            'name' => 'Project Alpha Tasks',
            'company_id' => $company1->id
        ]);

        $notepad2 = Notepad::create([
            'name' => 'Project Beta Tasks',
            'company_id' => $company1->id
        ]);

        // 6. Create todos with specific order
        $todos1 = [
            $todo1 = Todo::create([
                'notepad_id' => $notepad1->id,
                'description' => 'Review project requirements',
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
                'description' => 'Analyze system architecture',
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
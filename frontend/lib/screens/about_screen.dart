import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with photo and basic info
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/profile.png'),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'JAAKKO YLINEN',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        'INFORMATION AND COMMUNICATION\nTECHNOLOGY (ICT) ENGINEER',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      _ContactInfo(
                        phone: '+358407389684',
                        email: 'ylinenjaakko@gmail.com',
                        address: '00410 Helsinki',
                        github: 'Tupsu-jy',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Skills section
            _SectionTitle('SKILLS'),
            _SkillCategory(
              title: 'PROGRAMMING LANGUAGES',
              strongest: 'Java, JavaScript, TypeScript, Python',
              others: 'Kotlin, C',
            ),
            _SkillCategory(
              title: 'FRAMEWORKS',
              strongest: 'React, Spring Boot, Django',
              others: 'Express, NextJs',
            ),
            _SkillCategory(
              title: 'DATABASES',
              strongest: 'PostgreSQL',
              lessExperience: 'MongoDB',
            ),
            _SkillCategory(
              title: 'TOOLS',
              strongest: 'Docker, Git, Linux',
              others: 'Jira, Confluence, AWS, Selenium',
            ),
            _SkillCategory(
              title: 'METHODS',
              content: 'CI/CD, Agile, Scrum, TDD',
            ),
            _SkillCategory(
              title: 'LANGUAGES',
              content: 'Finnish (Native), English (Excellent)',
            ),

            const SizedBox(height: 24),

            // Education section
            _SectionTitle('EDUCATION'),
            _Education(
              school: 'METROPOLIA AMK',
              degree: 'ICT (08.2019 - 01.2025)',
              details: [
                '240 credit degree program (245/240 credits completed)',
                'Software production as the major',
              ],
            ),
            _Education(
              school: 'HELSINKI UNIVERSITY',
              degree: 'Computer Science (08.2013 - 10.2017)',
              details: ['94 credits completed'],
            ),

            const SizedBox(height: 24),

            // Work Experience section
            _SectionTitle('WORK EXPERIENCE'),
            _WorkExperience(
              company: 'DOCUMILL',
              position: 'Software Designer',
              period:
                  '10.5.2021 to 20.8.2021 and between 17.3.2020 to 31.12.2020',
              details: [
                'The work was related to a development project for an online document editing service for Java-based software',
                'Technologies and tools used in the development work: Java, JavaScript, CSS, HTML, GIT, JUnit and Selenium',
                'I worked as part of a team, using English as the working language',
              ],
            ),
            _WorkExperience(
              company: 'ICONICCHAIN',
              position: 'Thesis work',
              period: '4.2024-10.2024',
              details: [
                'Implemented a data migration for the databases of a production product',
                'Modified the software to be compatible with the new data format, both in the React frontend and the Python backend',
              ],
            ),
            _WorkExperience(
              company: 'OUTLIER',
              position: 'Software Developer',
              period: 'since 20.12.2025',
              details: [
                'The work tasks are related to producing high-quality training data for LLMs',
                'I write high quality complete code that can be used to train models',
                'I use multiple programming languages in diverse situations',
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _SkillCategory extends StatelessWidget {
  final String title;
  final String? strongest;
  final String? others;
  final String? lessExperience;
  final String? content;

  const _SkillCategory({
    required this.title,
    this.strongest,
    this.others,
    this.lessExperience,
    this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 200,
            child: Text(title, style: const TextStyle(color: Colors.red)),
          ),
          Expanded(
            child:
                content != null
                    ? Text(content!)
                    : RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: [
                          if (strongest != null)
                            TextSpan(
                              text: 'Strongest: ',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          if (strongest != null)
                            TextSpan(text: strongest! + ' '),
                          if (others != null)
                            TextSpan(
                              text: 'Others: ',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          if (others != null) TextSpan(text: others! + ' '),
                          if (lessExperience != null)
                            TextSpan(
                              text: 'Less experience: ',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          if (lessExperience != null)
                            TextSpan(text: lessExperience!),
                        ],
                      ),
                    ),
          ),
        ],
      ),
    );
  }
}

class _ContactInfo extends StatelessWidget {
  final String phone;
  final String email;
  final String address;
  final String github;

  const _ContactInfo({
    required this.phone,
    required this.email,
    required this.address,
    required this.github,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Phone number: $phone'),
        Text('Email: $email'),
        Text('Address: $address'),
        InkWell(
          onTap: () => launchUrl(Uri.parse('https://github.com/$github')),
          child: Text(
            'Github: $github',
            style: const TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}

class _Education extends StatelessWidget {
  final String school;
  final String degree;
  final List<String> details;

  const _Education({
    required this.school,
    required this.degree,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 200,
            child: Text(school, style: const TextStyle(color: Colors.red)),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(degree),
                ...details.map((detail) => Text('• $detail')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WorkExperience extends StatelessWidget {
  final String company;
  final String position;
  final String period;
  final List<String> details;

  const _WorkExperience({
    required this.company,
    required this.position,
    required this.period,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 200,
            child: Text(company, style: const TextStyle(color: Colors.red)),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$position from $period',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                ...details.map((detail) => Text('• $detail')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

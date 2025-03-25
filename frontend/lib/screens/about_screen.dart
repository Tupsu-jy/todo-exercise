import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/company_provider.dart';
import '../widgets/cv/cv_header.dart';
import '../widgets/cv/cv_section_header.dart';
import '../widgets/cv/cv_entry.dart';
import '../widgets/cv/cover_letter.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cvData = Provider.of<CompanyProvider>(context).cv;
    final coverLetterData = Provider.of<CompanyProvider>(context).coverLetter;

    // Find the job title and contact info components
    String jobTitle;
    String contactInfo;

    try {
      jobTitle =
          cvData.entries
              .firstWhere(
                (entry) => entry.value['category'] == 'job_title',
                orElse: () => throw Exception('Job title not found in CV data'),
              )
              .value['text_en'];
    } catch (e) {
      print('Error getting job title: $e'); // For development
      jobTitle = 'Position not specified'; // Fallback value
    }

    try {
      contactInfo =
          cvData.entries
              .firstWhere(
                (entry) => entry.value['category'] == 'contact_info',
                orElse:
                    () => throw Exception('Contact info not found in CV data'),
              )
              .value['text_en'];
    } catch (e) {
      print('Error getting contact info: $e'); // For development
      contactInfo = 'Contact information not available'; // Fallback value
    }

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CvHeader(jobTitle: jobTitle, contactInfo: contactInfo),
            ...cvData.entries.map((entry) {
              final Map<String, dynamic> component = entry.value;
              final String category = component['category'];
              final dynamic textEn = component['text_en'];

              switch (category) {
                case 'section_header':
                  return CvSectionHeader(text: textEn);
                case 'entry':
                  return CvEntry(
                    title: textEn['title'],
                    content: textEn['content'],
                  );
                case 'job_title':
                case 'contact_info':
                  return const SizedBox.shrink(); // Skip these as they're in header
                default:
                  return const SizedBox.shrink();
              }
            }),
            CoverLetter(coverLetter: coverLetterData['text_en']),
          ],
        ),
      ),
    );
  }
}

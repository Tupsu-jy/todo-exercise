import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/company_provider.dart';
import '../widgets/cv/cv_header.dart';
import '../widgets/cv/cv_section_header.dart';
import '../widgets/cv/cv_entry.dart';
import '../widgets/cv/cover_letter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cvData = Provider.of<CompanyProvider>(context).cv;
    final coverLetterData = Provider.of<CompanyProvider>(context).coverLetter;
    final l10n = AppLocalizations.of(context)!;

    // Find the job title and contact info components
    String jobTitle;
    String contactInfo;

    // TODO: this is stupid. Replace with proper loading thingy if not yet loaded
    try {
      jobTitle =
          cvData.entries
              .firstWhere(
                (entry) => entry.value['category'] == 'job_title',
                orElse: () => throw Exception('Job title not found in CV data'),
              )
              .value['text_${l10n.localeName}'];
    } catch (e) {
      print('Error getting job title: $e'); // For development
      jobTitle = l10n.positionNotSpecified; // Fallback value
    }

    try {
      contactInfo =
          cvData.entries
              .firstWhere(
                (entry) => entry.value['category'] == 'contact_info',
                orElse:
                    () => throw Exception('Contact info not found in CV data'),
              )
              .value['text_${l10n.localeName}'];
    } catch (e) {
      print('Error getting contact info: $e'); // For development
      contactInfo = l10n.contactInfoNotAvailable; // Fallback value
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
              final dynamic text = component['text_${l10n.localeName}'];

              switch (category) {
                case 'section_header':
                  return CvSectionHeader(text: text);
                case 'entry':
                  return CvEntry(
                    title: text['title'],
                    content: text['content'],
                  );
                case 'job_title':
                case 'contact_info':
                  return const SizedBox.shrink(); // Skip these as they're in header
                default:
                  return const SizedBox.shrink();
              }
            }),
            CoverLetter(
              coverLetter: coverLetterData['text_${l10n.localeName}'],
            ),
          ],
        ),
      ),
    );
  }
}

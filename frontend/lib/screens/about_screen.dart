import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/company_provider.dart';
import '../widgets/cv/cv_header.dart';
import '../widgets/cv/cv_section_header.dart';
import '../widgets/cv/cv_entry.dart';
import '../widgets/cv/cover_letter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widgets/cv/expandable_cv_section.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cvData = Provider.of<CompanyProvider>(context).cv;
    final coverLetterData = Provider.of<CompanyProvider>(context).coverLetter;
    final l10n = AppLocalizations.of(context)!;

    // Find the job title and contact info components
    String jobTitle = '';
    String contactInfo = '';

    for (final entry in cvData.entries) {
      final component = entry.value;
      if (component['category'] == 'job_title') {
        jobTitle = component['text_${l10n.localeName}'];
      } else if (component['category'] == 'contact_info') {
        contactInfo = component['text_${l10n.localeName}'];
      }
    }

    // Group entries by section
    final List<Map<String, dynamic>> sections = [];
    Map<String, dynamic>? currentSection;

    for (final entry in cvData.entries) {
      final Map<String, dynamic> component = entry.value;
      final String category = component['category'];

      if (category == 'section_header') {
        // Start a new section
        if (currentSection != null) {
          sections.add(currentSection);
        }

        currentSection = {
          'header': component['text_${l10n.localeName}'],
          'entries': <Map<String, dynamic>>[],
        };
      } else if (category == 'entry' && currentSection != null) {
        // Add entry to current section
        currentSection['entries'].add(component);
      }
      // Skip job_title and contact_info as they're in the header
    }

    // Add the last section if it exists
    if (currentSection != null) {
      sections.add(currentSection);
    }

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CvHeader(jobTitle: jobTitle, contactInfo: contactInfo),

            // Render expandable sections
            ...sections.map(
              (section) => ExpandableCvSection(
                sectionTitle: section['header'],
                entries: section['entries'],
                locale: l10n.localeName,
              ),
            ),

            // Cover letter at the end
            // if (coverLetterData != null)
            //   ExpandableCvSection(
            //     sectionTitle: l10n.coverLetter,
            //     isCoverLetter: true,
            //     coverLetterText: coverLetterData['text_${l10n.localeName}'],
            //     locale: l10n.localeName,
            //   ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../widgets/cv/cv_section_header.dart';
import '../../widgets/cv/cv_entry.dart';
import '../../widgets/cv/cover_letter.dart';

class ExpandableCvSection extends StatefulWidget {
  final String sectionTitle;
  final List<Map<String, dynamic>>? entries;
  final bool isCoverLetter;
  final String? coverLetterText;
  final String locale;

  const ExpandableCvSection({
    required this.sectionTitle,
    this.entries,
    this.isCoverLetter = false,
    this.coverLetterText,
    required this.locale,
    super.key,
  }) : assert(
         (isCoverLetter && coverLetterText != null) ||
             (!isCoverLetter && entries != null),
         'Either provide entries or coverLetterText',
       );

  @override
  State<ExpandableCvSection> createState() => _ExpandableCvSectionState();
}

class _ExpandableCvSectionState extends State<ExpandableCvSection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with tap functionality
        InkWell(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Row(
            children: [
              Expanded(child: CvSectionHeader(text: widget.sectionTitle)),
              Icon(
                _isExpanded ? Icons.expand_less : Icons.expand_more,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ),

        // Animated content
        AnimatedCrossFade(
          firstChild: const SizedBox(height: 0),
          secondChild:
              widget.isCoverLetter
                  ? CoverLetter(coverLetter: widget.coverLetterText!)
                  : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                        widget.entries!.map((entry) {
                          final dynamic text = entry['text_${widget.locale}'];
                          return CvEntry(
                            title: text['title'],
                            content: text['content'],
                          );
                        }).toList(),
                  ),
          crossFadeState:
              _isExpanded
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 300),
        ),
      ],
    );
  }
}

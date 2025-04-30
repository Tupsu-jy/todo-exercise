import 'package:flutter/material.dart';
import '../../widgets/cv/cv_section_header.dart';
import '../../widgets/cv/cv_entry.dart';
import '../../widgets/cv/cover_letter.dart';
import '../../theme/color_schemes.dart';

class ExpandableCvSection extends StatefulWidget {
  final String sectionTitle;
  final List<Map<String, dynamic>>? entries;
  final String locale;

  const ExpandableCvSection({
    required this.sectionTitle,
    required this.entries,
    required this.locale,
    super.key,
  });

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
              Icon(
                _isExpanded ? Icons.expand_less : Icons.expand_more,
                color: Theme.of(context).colorScheme.cvAccent,
              ),
              Expanded(child: CvSectionHeader(text: widget.sectionTitle)),
            ],
          ),
        ),

        // Animated content
        AnimatedCrossFade(
          firstChild: const SizedBox(height: 0),
          secondChild: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                widget.entries!.map((entry) {
                  final dynamic text = entry['text_${widget.locale}'];

                  if (text is Map) {
                    return CvEntry(
                      title: text['title'],
                      content: text['content'] ?? '',
                    );
                  } else {
                    return CoverLetter(coverLetter: text ?? '');
                  }
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

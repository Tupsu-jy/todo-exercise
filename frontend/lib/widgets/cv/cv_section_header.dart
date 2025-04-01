import 'package:flutter/material.dart';
import '../../theme/text_styles.dart';
import '../../theme/color_schemes.dart';

class CvSectionHeader extends StatelessWidget {
  final String text;

  const CvSectionHeader({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        children: [
          Text(text.toUpperCase(), style: Theme.of(context).cvSectionHeader),
          const SizedBox(width: 8), // Space between text and line
          Expanded(
            child: Container(
              height: 4, // Line thickness
              color: Theme.of(context).colorScheme.cvAccent,
            ),
          ),
          const SizedBox(width: 16), // Space at the end
        ],
      ),
    );
  }
}

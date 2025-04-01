import 'package:flutter/material.dart';
import '../../theme/text_styles.dart';

class CvHeader extends StatelessWidget {
  final String jobTitle;
  final String contactInfo;

  const CvHeader({
    super.key,
    required this.jobTitle,
    required this.contactInfo,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          // Mobile layout
          return Column(
            children: [
              CircleAvatar(
                radius: 70, // Smaller for mobile
                backgroundImage: const AssetImage('assets/profile.png'),
              ),
              const SizedBox(height: 16),
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      'JAAKKO YLINEN',
                      style: Theme.of(context).cvName,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    jobTitle.toUpperCase(),
                    style: Theme.of(context).cvJobTitle,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Contact info
              ...contactInfo
                  .replaceAll('\\n', '\n')
                  .split('\n')
                  .map((line) => Text(line.trim())),
            ],
          );
        } else {
          // Desktop layout
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 70,
                backgroundImage: const AssetImage('assets/profile.png'),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        'JAAKKO YLINEN',
                        style: Theme.of(context).cvName,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        jobTitle.toUpperCase(),
                        style: Theme.of(context).cvJobTitle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children:
                      contactInfo
                          .replaceAll('\\n', '\n')
                          .split('\n')
                          .map(
                            (line) => Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 2.0,
                              ),
                              child: Text(line.trim()),
                            ),
                          )
                          .toList(),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import '../../theme/text_styles.dart';

class CvEntry extends StatelessWidget {
  final String title;
  final String content;

  const CvEntry({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          // Mobile layout (Column)
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, bottom: 8.0),
                child: Text(
                  title.toUpperCase(),
                  style: Theme.of(context).cvEntryTitle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 32.0, bottom: 16.0),
                child: Text(content),
              ),
            ],
          );
        } else {
          // Desktop layout (Row)
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 200,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Text(
                      title.toUpperCase(),
                      style: Theme.of(context).cvEntryTitle,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ),
                Expanded(child: Text(content)),
              ],
            ),
          );
        }
      },
    );
  }
}

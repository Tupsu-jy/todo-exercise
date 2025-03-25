import 'package:flutter/material.dart';

class CoverLetter extends StatelessWidget {
  final String coverLetter;

  const CoverLetter({super.key, required this.coverLetter});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(coverLetter),
    );
  }
}

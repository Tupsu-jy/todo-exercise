import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:html' as html;
import '../providers/language_provider.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return DropdownButton<String>(
          value: languageProvider.locale.languageCode,
          items: const [
            DropdownMenuItem(value: 'en', child: Text('English')),
            DropdownMenuItem(value: 'fi', child: Text('Suomi')),
          ],
          onChanged: (String? languageCode) {
            if (languageCode != null) {
              languageProvider.setLocale(Locale(languageCode));

              // Update URL
              final currentUri = Uri.base;
              final segments = List<String>.from(currentUri.pathSegments);
              if (segments.isNotEmpty) {
                segments[0] = languageCode;
              }
              final newUri = currentUri.replace(pathSegments: segments);
              html.window.history.pushState({}, '', newUri.toString());
            }
          },
        );
      },
    );
  }
}

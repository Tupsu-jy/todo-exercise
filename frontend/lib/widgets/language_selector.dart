import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web/web.dart' as web;
import '../providers/language_provider.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              key: Key('english_language_selector'),
              onTap: () => languageProvider.setLocale(Locale('en')),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('🇬🇧', style: TextStyle(fontSize: 20)),
              ),
            ),
            InkWell(
              key: Key('finnish_language_selector'),
              onTap: () => languageProvider.setLocale(Locale('fi')),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('🇫🇮', style: TextStyle(fontSize: 20)),
              ),
            ),
          ],
        );
      },
    );
  }
}

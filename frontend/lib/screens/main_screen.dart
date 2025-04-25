import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../providers/language_provider.dart';
import '../widgets/language_selector.dart';
import 'about_screen.dart';
import 'notepads_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.folder), text: l10n.notepads),
              Tab(icon: Icon(Icons.info), text: l10n.about),
            ],
          ),
          title: Text(l10n.appName),
          actions: const [LanguageSelector()],
        ),
        body: const TabBarView(children: [NotepadsScreen(), AboutScreen()]),
      ),
    );
  }
}

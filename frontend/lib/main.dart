import 'package:flutter/material.dart';
import 'screens/main_screen.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:provider/provider.dart';
import 'providers/company_provider.dart';
import 'config/env_config.dart';
import 'dart:convert';
import 'services/websocket_handler.dart';
import 'providers/language_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main({String? initialRoute}) {
  String companySlug;
  String languageCode;

  // Parse initialRoute if provided (for testing)
  if (initialRoute != null && initialRoute.isNotEmpty) {
    // Remove leading slash if present
    final route =
        initialRoute.startsWith('/') ? initialRoute.substring(1) : initialRoute;
    final segments = route.split('/');

    // Extract language and company from route
    languageCode = segments.isNotEmpty ? segments[0] : 'en';
    companySlug = segments.length > 1 ? segments[1] : 'default';
  } else {
    // Normal browser URL parsing
    try {
      final Uri uri = Uri.base;
      final segments = uri.pathSegments;
      languageCode = segments.isNotEmpty ? segments[0] : 'en';
      companySlug = segments.length > 1 ? segments[1] : 'default';
    } catch (e) {
      languageCode = 'en';
      companySlug = 'default';
    }
  }

  // Validate language code
  if (!['en', 'fi'].contains(languageCode)) {
    languageCode = 'en';
  }

  final provider = CompanyProvider();
  final wsHandler = WebSocketHandler(provider);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => provider..initializeWithSlug(companySlug),
        ),
        ChangeNotifierProvider(
          create:
              (context) => LanguageProvider()..setLocale(Locale(languageCode)),
        ),
      ],
      child: MyApp(wsHandler: wsHandler),
    ),
  );
}

class MyApp extends StatefulWidget {
  final WebSocketHandler wsHandler;

  const MyApp({super.key, required this.wsHandler});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    widget.wsHandler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return MaterialApp(
          locale: languageProvider.locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: ThemeData(
            textTheme: const TextTheme(titleLarge: TextStyle(fontSize: 28.0)),
          ),
          debugShowCheckedModeBanner: false,
          home: MainScreen(),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:frontend/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Notepads loaded', (WidgetTester tester) async {
    // Start the app with the initialRoute parameter
    app.main(initialRoute: '/en/one4all');

    // Wait for the app to load and API calls to complete
    await tester.pumpAndSettle(Duration(seconds: 3));

    final projectAlphaTasks = find.text('Project Alpha Tasks');
    expect(
      projectAlphaTasks,
      findsOneWidget,
      reason: 'Project Alpha Tasks not found',
    );

    final projectBetaTasks = find.text('Project Beta Tasks');
    expect(
      projectBetaTasks,
      findsOneWidget,
      reason: 'Project Beta Tasks not found',
    );
  });
  testWidgets('About page loaded', (WidgetTester tester) async {
    // Start the app with the initialRoute parameter
    app.main(initialRoute: '/en/one4all');

    // Wait for the app to load and API calls to complete
    await tester.pumpAndSettle(Duration(seconds: 3));

    final aboutTab = find.byKey(const Key('about_tab'));
    await tester.tap(aboutTab);
    await tester.pumpAndSettle();

    final name = find.text('JAAKKO YLINEN');
    expect(name, findsOneWidget, reason: 'Name not found');

    // Switch to Finnish
    final finnishLanguageSelector = find.byKey(
      const Key('finnish_language_selector'),
    );
    await tester.tap(finnishLanguageSelector);
    await tester.pumpAndSettle();
    expect(
      finnishLanguageSelector,
      findsOneWidget,
      reason: 'Finnish language selector not found',
    );

    // Check Finnish
    final letterHeaderFinnish = find.text('HAKUKIRJE');
    expect(letterHeaderFinnish, findsOneWidget, reason: 'Letter not found');
    final letterFinnish = find.text('testihakukirje');
    expect(letterFinnish, findsOneWidget, reason: 'Letter not found');

    final infoHeaderFinnish = find.text('TIETOA PROJEKTISTA');
    expect(infoHeaderFinnish, findsOneWidget, reason: 'Info not found');
    final infoFinnish = find.text('testi projektin info');
    expect(infoFinnish, findsOneWidget, reason: 'Info not found');

    // Switch to English
    final englishLanguageSelector = find.byKey(
      const Key('english_language_selector'),
    );
    await tester.tap(englishLanguageSelector);
    await tester.pumpAndSettle();
    expect(
      englishLanguageSelector,
      findsOneWidget,
      reason: 'English language selector not found',
    );

    // Check English
    final letterHeader = find.text('COVER LETTER');
    await tester.tap(letterHeader);
    await tester.pumpAndSettle();
    expect(letterHeader, findsOneWidget, reason: 'Letter not found');
    final letter = find.text('test cover letter');
    expect(letter, findsOneWidget, reason: 'Letter not found');

    final infoHeader = find.text('PROJECT INFO');
    await tester.tap(infoHeader);
    await tester.pumpAndSettle();
    expect(infoHeader, findsOneWidget, reason: 'Info not found');
    final info = find.text('test project info');
    expect(info, findsOneWidget, reason: 'Info not found');
  });
}

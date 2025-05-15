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
  });
}

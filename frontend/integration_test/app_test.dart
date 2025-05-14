import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:frontend/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Navigointi sovelluksessa', (WidgetTester tester) async {
    print('🚀 TEST STARTING');

    // Käynnistä sovellus initialRoute-parametrilla
    app.main(initialRoute: '/en/one4all');
    print('📱 App käynnistetty reitillä /en/one4all');

    // Anna aikaa sovelluksen latautumiselle ja API-kutsuille
    await tester.pumpAndSettle(Duration(seconds: 3));

    // Nyt testaa TabBar-navigointia
    print('🔍 Etsitään About-välilehteä');
    final aboutTab = find.text('About');
    expect(aboutTab, findsOneWidget, reason: 'About-välilehteä ei löytynyt');

    print('👆 Navigoidaan About-välilehdelle');
    await tester.tap(aboutTab);
    await tester.pumpAndSettle();
  });
}

import 'package:webdriver/async_io.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:webdriver/io.dart';
import 'package:webdriver/async_io.dart';

void main() async {
  late WebDriver driver;

  setUpAll(() async {
    // Connect to ChromeDriver
    driver = await createDriver(
      spec: WebDriverSpec.W3c,
      uri: Uri.parse('http://localhost:4444'),
    );
  });

  tearDownAll(() async {
    await driver.quit();
  });

  test('Notepads loaded', () async {
    // Navigate to your Flutter app
    await driver.get('http://localhost:8080/en/one4all');

    // Wait for page to load
    await Future.delayed(Duration(seconds: 2));

    // Wait for Flutter to initialize
    await Future.delayed(Duration(seconds: 3));

    // Find elements using WebDriver
    final projectAlphaTasks = await driver.findElement(
      By.xpath("//*[contains(text(), 'Project Alpha Tasks')]"),
    );
    expect(projectAlphaTasks, isNotNull);

    final projectBetaTasks = await driver.findElement(
      By.xpath("//*[contains(text(), 'Project Beta Tasks')]"),
    );
    expect(projectBetaTasks, isNotNull);
  });
}

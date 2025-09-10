import 'dart:io';
import 'package:test/test.dart';
import 'package:webdriver/io.dart';

void main() {
  Process _chromedriver;
  WebDriver driverA;
  WebDriver driverB;

  setUpAll(() async {
    // 1) Käynnistä chromedriver-prosessi portissa 4444
    _chromedriver = await Process.start('chromedriver', [
      '--port=4444',
    ], mode: ProcessStartMode.detachedWithStdio);

    // (Valinnainen) odota hetki, että driver on valmis vastaanottamaan yhteyksiä
    await Future.delayed(const Duration(seconds: 1));

    // 2) Luo kaksi erillistä WebDriver-sessionia
    driverA = await createDriver(
      uri: Uri.parse('http://localhost:4444/wd/hub/'),
      desired: {'browserName': 'chrome'},
    );
    driverB = await createDriver(
      uri: Uri.parse('http://localhost:4444/wd/hub/'),
      desired: {'browserName': 'chrome'},
    );
  });

  tearDownAll(() async {
    // Sulje driverit
    await driverA.quit();
    await driverB.quit();
    // Lopeta chromedriver-prosessi
    _chromedriver.kill();
  });

  test('Realtime-synkronointi kahden selaimen välillä', () async {
    const appUrl = 'http://localhost:8080';

    // Avaa sovellus molemmissa instansseissa
    await Future.wait([driverA.get(appUrl), driverB.get(appUrl)]);

    // Käyttäjä A lisää kohteen
    await driverA.findElement(const By.id('add-item')).click();
    await driverA.findElement(const By.id('item-name')).sendKeys('Testi-tuote');
    await driverA.findElement(const By.id('save')).click();

    // Käyttäjä B odottaa, että muutos näkyy
    bool found = false;
    for (var i = 0; i < 10; i++) {
      final elems = await driverB.findElements(
        const By.xpath("//*[text()='Testi-tuote']"),
      );
      if (elems.isNotEmpty) {
        found = true;
        break;
      }
      await Future.delayed(const Duration(milliseconds: 500));
    }

    expect(
      found,
      isTrue,
      reason: 'Käyttäjä B ei nähnyt "Testi-tuote"-elementtiä.',
    );
  });
}

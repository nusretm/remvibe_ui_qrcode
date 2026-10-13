# RemVibe UI QR

**Durum: Aşama 1 Flutter iskeleti eklendi; QR widget'lar henüz uygulanmadı.**
Bu branch proje kurallarını, pubspec bağımlılıklarını, mimariyi ve bir Example
uygulaması Dart iskeletini ve Android/iOS/Windows/Linux/macOS native
Example runner klasörlerini içerir. Aşağıdaki QR widget kodları **hedef API
örnekleridir**; Aşama 2–3 tamamlanmadan çalışacakları iddia edilmez.

İki bağımsız Flutter widget'ı:

- `RemVibeUIQRCode`: `String` içerik için QR görseli
  (`pretty_qr_code`).
- `RemVibeUIQRScanner`: Android/iOS kamerasından QR okuyup
  `FutureOr<void> Function(String)` callback
  (`mobile_scanner`).

Account/authentication, QR protocol, navigation, server API ve başka
RemVibe package bağımlılığı içermez. QR içeriği otomatik olarak
yorumlanmaz, kaydedilmez veya loglanmaz.

## Platform desteği — hedef kapsam

| Platform | QR gösterme | QR tarama |
| --- | --- | --- |
| Windows | Evet | Hayır (kontrollü unsupported UI) |
| Linux | Evet | Hayır (kontrollü unsupported UI) |
| macOS | Evet | Hayır (kontrollü unsupported UI) |
| Android | Evet | Evet |
| iOS | Evet | Evet |
| Web | Destek hedefi değil | Destek hedefi değil |

Bunlar **tasarlanan** hedeflerdir, henüz live validation yapılmadı.

## Flutter SDK ve kurulum

Planlanan minimum: **Flutter 3.29.0 / Dart 3.7.0**. Bu gereksinim
`mobile_scanner 7.4.2` paketinin kendi manifestinden alınmıştır.
Flutter/Dart ve native build uyumluluğu Example geliştirilirken
gerçek ortamda doğrulanacaktır.

Uygulamanın `pubspec.yaml` dosyasına (paket yayımlanana kadar örnek
`path` bağımlılığı; yerel klasörü kendinize uyarlayın):

```yaml
environment:
  sdk: ^3.7.0
  flutter: ">=3.29.0"

dependencies:
  flutter:
    sdk: flutter
  remvibe_ui_qrcode:
    path: ../remvibe_ui_qrcode
```

Sonra:
```sh
flutter pub get
```

Paketin `pubspec.yaml` bağımlılıkları Aşama 1'de oluşturuldu:
`pretty_qr_code: 3.6.0` ve `mobile_scanner: 7.4.2` (ilk sürüm için sabit).
Paket henüz `publish_to: none` olarak işaretli, yayımlanmıyor.
Yayımlama tamamlanmadan `pub.dev` üzerinden
`remvibe_ui_qrcode: ^...` kullanımı vaat edilmez.

## QR gösterme — planlanan API

```dart
import 'package:flutter/material.dart';
import 'package:remvibe_ui_qrcode/remvibe_ui_qrcode.dart';

class QRPreview extends StatelessWidget {
  const QRPreview({super.key, required this.data});

  final String data;

  @override
  Widget build(BuildContext context) {
    return RemVibeUIQRCode(
      data: data,
      size: 250,
    );
  }
}
```

`data` değişince QR yenilenir. Boş/geçersiz veya kapasiteyi aşan
içerikler kontrollü hata görünümüne dönüşür. Quiet zone ve yüksek kontrast
varsayılan olarak korunur. QR gösterimi herhangi bir kamera izni veya
uzak sunucu gerektirmez.

## QR okuma — planlanan API (Android / iOS)

```dart
import 'package:flutter/material.dart';
import 'package:remvibe_ui_qrcode/remvibe_ui_qrcode.dart';

class QRReadPage extends StatefulWidget {
  const QRReadPage({super.key});

  @override
  State<QRReadPage> createState() => _QRReadPageState();
}

class _QRReadPageState extends State<QRReadPage> {
  String? data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 300,
          child: RemVibeUIQRScanner(
            onRead: (String value) async {
              if (!mounted) return;
              setState(() => data = value);
            },
          ),
        ),
        Text(data ?? 'QR okutulmadı'),
      ],
    );
  }
}
```

Callback senkron da olabilir. Widget **one-shot** çalışır: ilk QR
okununca callback yalnız bir kez çağrılır, callback devam ederken tekrar
iletilmez ve tamamlandıktan sonra otomatik devam etmez.
Yeni okuma için uygulama yeni bir scanner widget oturumu oluşturur.
Widget navigasyon veya login yönetmez.

## Host Flutter uygulamasında platform ayarları

Aşağıdaki native ayarlar **QR scanner kullanılacak Android/iOS uygulamaları**
içindir. Package widget'ının kendi içinde yönetemeyeceği izin açıklaması ve
native build gereksinimleri host uygulamanın sorumluluğundadır.
Bilgiler `mobile_scanner 7.4.2` kaynaklarından derlendi;
**Example gerçek build ile henüz doğrulanmadı**.

### Android

1. `android/app/build.gradle.kts` (veya Groovy `build.gradle`) içinde
   `minSdk` en az **23** olmalıdır. Plugin v7.4.2 Android kaynağı
   `compileSdk = 36` ve Java 17 kullanır; host proje SDK/toolchain
   uyumluluğunu da doğrulayın.
2. `mobile_scanner` kendi Android manifestinde
   `android.permission.CAMERA` bildirir ve
   `uses-feature camera required=false` kullanır.
   Nihai merged manifestte kamera izninin bulunduğunu doğrulayın.
   İzin manuel eklenmek zorunda değildir; gerekiyorsa host manifestine
   açıkça da eklenebilir.
3. Gerçek cihaz kamera iznini Android çalışma zamanında ister;
   kullanıcı reddederse scanner kontrollü durum gösterir.

Örnek `android/app/build.gradle.kts` parçası (var olan Android
yapılandırmanızı tümüyle değiştirmeyin):

```kotlin
android {
    defaultConfig {
        minSdk = 23
    }
}
```

Varsayılan ML Kit modeli bundled kullanılır ve ilk taramada indirme
gerektirmez. İsteğe bağlı unbundled mod için (ilk kullanımda Google Play
Services download gerektirir) host `android/gradle.properties`:

```properties
dev.steenbakker.mobile_scanner.useUnbundled=true
```

Bu proje ilk aşamada **varsayılan bundled** davranışı hedefler.

### iOS

Host uygulamanın `ios/Runner/Info.plist` dosyasına
kamera izni açıklaması ekleyin:

```xml
<key>NSCameraUsageDescription</key>
<string>QR kod okutmak için kamera erişimi gereklidir.</string>
```

`mobile_scanner 7.4.2` Darwin podspec dosyasında minimum iOS deployment
target **12.0** bildirir. Host Flutter/Xcode/CocoaPods ortamının
bundan yüksek bir minimum dayatıp dayatmadığı yerel build aşamasında
doğrulanmalıdır; uygulama deployment target'ı uyumlu seçin.
Yalnız kamera ile QR taranacağı için fotoğraf galerisi izni gerekmez.
Simülatörde kamera doğrulaması fiziksel iPhone testi yerine geçmez.

### Windows, Linux ve macOS

Bu üç platformda QR **gösterme** hedeflenir; normal Flutter desktop
kurulumu dışında kamera izni veya özel native QR plugin kurulumu
beklenmez. `RemVibeUIQRScanner` desteklenmeyen platform görünümü
gösterir; macOS için kamera entitlement istenmez çünkü bu package
macOS taraması hedeflemez.

- Windows: `flutter run -d windows`
- Linux: `flutter run -d linux`
- macOS: `flutter run -d macos`

Windows için Example shell build ve başlangıç çalıştırması denendi;
Linux/macOS henüz çalıştırılmadı.

### Web

Web ilk sürüm kapsamının dışındadır. Plugin bağımlılıklarının Web
desteği olması bu package için Web test/destek taahhüdü değildir.

## Example uygulaması ve doğrulama

Aşama 1'de `example/lib/main.dart` temel uygulama kabuğu oluşturuldu.
Şimdilik QR üretme/tarama değil, geliştirme durumunu gösterir.
Aşama 2–3'te metin alanından QR gösterme, scanner kamera alanı,
okunan metin, izin reddi ve unsupported UI eklenecek.

Native runner klasörleri feature branch'te mevcuttur; yeni clone için
`flutter create` çalıştırmaya gerek yoktur. Example'ı çalıştırmak için:

```powershell
flutter pub get
cd example
flutter pub get
flutter analyze
flutter test
flutter run -d windows
```

Aşama 1'in kullanıcı tarafından raporlanan doğrulamaları:
`flutter pub get` (root/Example), `flutter analyze` (root/Example),
`flutter test` (+1), Windows native build ve VM Service başlangıcı
başarılı. Windows debug oturumu daha sonra `Lost connection to device`
ile sonlandı; kesintisiz çalışma **henüz doğrulanmadı**.

QR üretme/tarama davranışı henüz kodlanmadığı için bunlar yalnız Example
shell ve package altyapısı sonuçlarıdır. Scanner için Android/iOS gerçek
cihaz doğrulaması Aşama 3'te yapılacaktır.

## Development ve belgeler

- [Repository kuralları](AGENTS.md)
- [Çalışma standardı](docs/WORKING_RULES.md)
- [Continuity index](docs/continuity/README.md)
- [Aktif hedef / doğrulama](docs/continuity/CURRENT_TARGET.md)
- [Mimari ve public API](docs/continuity/ARCHITECTURE.md)

## Kaynaklar

- https://pub.dev/packages/pretty_qr_code/versions/3.6.0
- https://pub.dev/packages/mobile_scanner/versions/7.4.2
- https://pub.dev/packages/mobile_scanner
- https://github.com/juliansteenbakker/mobile_scanner/tree/v7.4.2

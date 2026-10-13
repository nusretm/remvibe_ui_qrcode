# RemVibe UI QR

**Durum: QR gösterme widget'ı Windows'ta gerçek ekranda görüntülendi;**
kod, root/Example analyze ve odaklı testler başarılı. Android/iOS scanner
kodu eklendi ve Samsung SM A515F / Android 13 ile Windows QR kodu
başarıyla okunarak `RemVibe UI QR` metni elde edildi.
Example uygulaması metin girip canlı QR önizlemesi gösterir ve
Android/iOS/Windows/Linux/macOS native runner dosyalarını içerir.

İki bağımsız Flutter widget'ı:

- `RemVibeUIQRCode`: `String` içerik için QR görseli
  (`pretty_qr_code`).
- `RemVibeUIQRScanner`: Android/iOS kamerasından QR okuyup
  `FutureOr<void> Function(String)` callback
  (`mobile_scanner`; Android fiziksel cihaz QR taraması doğrulandı).

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

QR gösterimi Windows'ta doğrulandı; Android kamera scanner'ı Samsung
SM A515F / Android 13 üzerinde gerçek QR okuyarak doğrulandı.
iOS, Linux, macOS cihaz testleri henüz yapılmadı.

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

## QR gösterme — uygulanan API

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

`data` değişince QR yenilenir; içeriğin kendisi değiştirilmez, parse
edilmez veya loglanmaz. Varsayılan `size` 250 logical pixel'dir.
`size` pozitif ve sonlu bir sayı olmalıdır.

QR tam siyah modüller, beyaz arka plan ve standart **dört modüllük quiet
zone** ile çizilir. Boş metinde `QR content cannot be empty.`,
QR kapasitesini aşan veya kodlanamayan metinde
`QR content could not be encoded.` mesajı gösterilir.
Hata içeriği veya kullanıcı verisi otomatik olarak loglanmaz.
QR görüntüleme kamera izni veya uzak sunucu gerektirmez.

**Example:** `example/lib/main.dart` içinde bir metin alanı bulunur.
Alan değiştikçe `RemVibeUIQRCode` yeni içeriği gösterir. Scanner'a ait
Example bölümü Aşama 3'te eklenecek.

> Aşama 2 için root `flutter analyze` ve `flutter test` (+2), Example
> `flutter analyze` ve `flutter test` (+1) başarılı. Windows üzerinde QR
> gerçekten görüldü; `Lost connection to device` kullanıcının Windows
> uygulama penceresini kapatmasıyla oluşan **beklenen kapanış** mesajıdır.
> Manuel QR metin değişikliği ve başka bir cihazla optik okuma ayrıca doğrulanmadı.

## QR okuma — uygulanan API (Android / iOS)

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
Widget navigasyon veya login yönetmez. QR içeriği `rawValue` üzerinden
aynen iletilir; yorumlanmaz, filtrelenmez veya loglanmaz (yalnız QR
formatı ve boş olmayan değer kontrol edilir).

Kamera `mobile_scanner` widget'ı oluşturulunca hazırlanır. Kamera izni
ilk kullanımda OS tarafından istenir ve uygulama background/resume
yönetimi plugin'in kendi lifecycle'ına bırakılır. Bir QR kabul edilince
scanner kamera görünümü kaldırılır; kamera kaynaklarının asenkron
bırakılması başlar ve callback tek sefer çalıştırılır. Callback başarısız
olursa `QR processing failed.` görünür; aynı oturumda yeniden okuma yoktur.

İzin reddedilirse `Camera permission denied. Enable camera access in
device settings.` görünür. Kamera başlatma/detection hataları kullanıcıya
QR içeriğini sızdırmayan genel metinle bildirilir. İzin engeli kalktıktan
sonra ya da yeniden tarama için uygulama yeni scanner widget oluşturmalıdır.
Windows/Linux/macOS/Web üzerinde kamera hiç başlatılmaz, destek dışı
mesajı gösterilir.

## Host Flutter uygulamasında platform ayarları

Aşağıdaki native ayarlar **QR scanner kullanılacak Android/iOS uygulamaları**
içindir. Package widget'ının kendi içinde yönetemeyeceği izin açıklaması ve
native build gereksinimleri host uygulamanın sorumluluğundadır.
Bilgiler `mobile_scanner 7.4.2` kaynaklarından derlendi;
**Android/iOS Example native build ve kamera testi henüz doğrulanmadı**.

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
4. Repository'nin Example uygulamasında `example/android/app/build.gradle.kts`
   için `minSdk = 23` ayarlanmıştır. Host uygulamanız için aynı minimum
   sürüm kuralını uygulayın. Android cihazda gerçek build/run henüz yapılmadı.

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

Repository'nin Example uygulamasında
`example/ios/Runner/Info.plist` içine `NSCameraUsageDescription` eklendi.
Gerçek iOS derlemesi/macOS geliştirme ortamında henüz çalıştırılmadı.

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
Aşama 2'de metin alanı ve QR önizlemesi eklendi.
Aşama 3'te `Open scanner` / `Close scanner` kontrolleri, scanner kamera
alanı ve `Last scanned QR` sonucu eklendi. İzin reddi ve desktop
unsupported görünümü doğrudan scanner widget'ı tarafından yönetilir.

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
ile sonlandı. Kullanıcı uygulama penceresini kendisinin kapattığını
bildirdi; bu normal bir Windows debug oturumu bitişidir.

Aşama 2 değişiklikleri sonrasında root/Example analyzer ve testler yeniden
çalıştırıldı ve başarılı oldu (root +2, Example +1). Windows üzerinde
QR kod ekranda görüntülendi. Debug bağlantısı kullanıcı uygulamayı
kapattığından sona erdi (beklenen).

Aşama 3 scanner kodu ve native ayarlar sonrasında root `flutter test`
**+3 PASS**; Android Example debug APK Samsung SM A515F / Android 13
üzerinde kuruldu ve Windows'tan `RemVibe UI QR` metnini okudu.
Son QR painter düzeltmesinden sonra root `flutter analyze` PASS,
`flutter test` +4 PASS; Example analyze PASS ve test +1 PASS.
Android açılışı tekrar doğrulandı; QR paint assertion'ı tekrarlanmadı.

### İlk Android kamera doğrulaması

QR gösterimini Windows Example'da açın, Android cihazda scanner
sayfasını/alanını açarak Windows ekranındaki QR kodu okutun.
Bu yöntem aynı telefonda ekranda QR gösterme ve kamerayla okuma
sorununu önler.

```powershell
cd D:\development\cross-platform\remvibe_ui_qrcode
git pull --ff-only origin feature/initial-qr-widgets
flutter analyze
flutter test
cd example
flutter analyze
flutter test
flutter devices
flutter run -d <android-device-id>
```

Android izin isteğini kabul edin; QR okunduğunda `Last scanned QR`
alanında aynı içeriğin bir kere göründüğünü kontrol edin. Yeniden okumak
için `Open scanner` ile yeni oturum açın. İzin reddi, widget'ın
kapatılması ve tekrar açılması, uygulama background/resume senaryoları
ayrı ayrı kontrol edilsin. Çıktılar ve gözlemler
`docs/continuity/CURRENT_TARGET.md` dosyasına kaydedilecek.

### Windows'ta Android Kotlin cache hatası (C: / D:)

Android Example farklı bir sürücüdeki Pub Cache'den plugin kaynaklarını
derlerken şu mesajı verebilir:

```text
:mobile_scanner:compileDebugKotlin
this and base files have different roots
Could not close incremental caches
```

Bu, kamera callback hatası değil, Kotlin incremental compilation
yol/cache sorunudur. Bu repository'nin
`example/android/gradle.properties` dosyasında yalnız Example build için
`kotlin.incremental=false` workaround'ı bulunur. Flutter başka
bir host uygulamaya entegre edilecekse o uygulamanın Android Gradle
yapılandırması ve Pub Cache konumu ayrıca değerlendirilmelidir.

Example'ı yenilemek için:

```powershell
cd example
flutter clean
flutter pub get
flutter run -d R58R50BT2BB
```

`flutter clean` yalnız oluşturulmuş build çıktıları/Flutter geçici
dosyalarını temizler; source dosyalarını veya Pub Cache'i silmez.
Önceki `flutter run` yerel Gradle dosyasını yükselttiyse yeni pull
öncesinde mutlaka `git status` ve `git diff` kontrol edilmelidir.

### Android başlangıcında QR boyutu sıfır olabilir

İlk gerçek Android çalıştırmasında, Example'ın QR önizlemesi başlangıç
yerleşiminde geçici olarak `BoxConstraints(w=0.0, h=250.0)` aldı.
`pretty_qr_code 3.6.0` sıfır genişlikte boyama assertion'ı üretti.
Scanner buna rağmen Windows QR kodunu başarıyla okudu.

Paket `RemVibeUIQRCode` içine `LayoutBuilder` koruması eklendi:
QR ancak pozitif genişlik/yükseklikle çiziliyor. Geçerli layout
geldiğinde QR normal biçimde görüntüleniyor.

Bu fix güncel branch'te root `flutter analyze` PASS, `flutter test` +4 PASS,
Example analyzer PASS ve Example test +1 PASS sonuçlarıyla doğrulandı.
Samsung SM A515F üzerinde APK tekrar çalıştırıldı; kamera açıldı ve önceki
QR paint assertion'ı tekrar görülmedi. Bu son oturumda ayrıca QR okuma
sonucu bildirilmedi; daha önce `RemVibe UI QR` başarıyla okutuldu.

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

# Architecture — RemVibe UI QR

Durum: QR display **IMPLEMENTED + TESTED + WINDOWS_QR_LIVE_VERIFIED** (Aşama 2); scanner **DESIGNED / NOT_STARTED** (2026-10-14).

## Sorumluluklar

```text
remvibe_ui_qrcode/
  lib/remvibe_ui_qrcode.dart          # tek public export entrypoint
  lib/src/qr_code/                    # RemVibeUIQRCode
  lib/src/qr_scanner/                 # RemVibeUIQRScanner
  example/                            # metin alanlı QR display Example; scanner daha sonra
  test/                               # az sayıda odaklı widget testi
  docs/                               # proje kuralları ve continuity
```

Yalnız iki public widget vardır. Teknik `State` sınıfları Flutter'ın
doğal yapısıdır; bağımsız servis, singleton, provider, interface, registry
veya controller public API'si yoktur.

## Platform matrisi

| Platform | RemVibeUIQRCode | RemVibeUIQRScanner |
| --- | --- | --- |
| Windows | Hedef | Unsupported durum |
| Linux | Hedef | Unsupported durum |
| macOS | Hedef | Unsupported durum |
| Android | Kullanılabilir | Hedef, öncelik 1 |
| iOS | Kullanılabilir | Hedef |
| Web | Kapsam dışı | Kapsam dışı |

Scanner bağımlılığı macOS/Web'i desteklese bile paketimiz ilk sürümde
tarama başlatmaz. Desktop'ta plugin çağrısı yapılmadan unsupported UI çizilir.

## Public API

```dart
RemVibeUIQRCode(
  data: 'Herhangi bir metin',
  size: 250,
)

RemVibeUIQRScanner(
  onRead: (String data) async {
    await doSomethingWithData(data);
  },
)
```

- QR display: `data` required `String`, `size` opsiyonel `double`
  (varsayılan 250). Stateless wrapper; `PrettyQrView.data` kendi
  state'i üzerinden `data` değişikliklerinde matrisi günceller.
- Görsel: siyah kare modüller, beyaz arka plan, standart **4-modül quiet zone**.
  Boş metinde ayrı fallback; kodlama veya kapasite hatasında
  `PrettyQrView.data(errorBuilder: ...)` ile güvenli fallback.
  Hata mesajında QR payload'u yok; exception loglanmaz.
- Sıfır, negatif veya sonlu olmayan boyutta kontrollü hata metni gösterilir.
- QR scanner: `onRead` required `FutureOr<void> Function(String data)`.
  String hiçbir şekilde parse/yorumlanmaz, loglanmaz veya sunucuya gönderilmez.
- İlk API'de zorunlu olmayan controller/configuration/error callback bulunmaz.
  Hata durumları widget alanında gösterilir; dış uygulama navigasyonu kendisi yapar.

## Scanner state machine / ownership

```text
unsupported -> unsupported UI (kamera açılmaz)
initial -> starting -> scanning -> reading -> finished
                 |         |          |
                 +--> permission/camera error
                                      +--> callback error UI
dispose veya app inactive -> kamera durdur / kaynakları temizle
app resumed ve hâlâ bekleniyorsa -> güvenli şekilde devam et
```

**One-shot değişmezleri:**

1. Yalnız Android/iOS'ta kamera controller oluşturulup başlatılır.
2. İzin ve kamera başlangıcı asenkron olabilir; app lifecycle, mounted/state
   ve yarış koşullarında tekrar `start`/`stop`/dispose güvenli olmalıdır.
3. İlk geçerli dolu QR metni geldiğinde callback çağrılmadan **önce**
   senkron okuma kilidi alınır.
4. Kamera durdurulur ve `onRead(data)` çağrılıp future sonucu beklenir.
5. Success veya callback error sonrasında aynı widget ikinci veri bildirmez.
6. Callback hatası kullanıcıya hassas veri içermeyen genel bir hata görünümü
   verir. Otomatik retry veya içeriği loglama yoktur.
7. Widget dispose edildiğinde kamera ve subscription serbest bırakılır;
   pending callback sonucu artık dispose edilmiş widget'ın state'ini değiştirmez.
8. İzin reddinde kontrollü görünüm; os izin ekranını aşmaya çalışma yok.
9. Yeni tarama için uygulama yeni widget oturumu açar (örn. yeni route/key).
10. Scanner hiçbir zaman `Navigator` çağırmaz.

## Dependency sınırı

- `pretty_qr_code: 3.6.0` — görüntüleme.
- `mobile_scanner: 7.4.2` — Android/iOS kamera tarama.
- Minimum planlanan Dart: `^3.7.0`; Flutter: `>=3.29.0`.
- Web için özel kod veya test eklenmez. Package HTTP client, account
  service veya herhangi bir başka RemVibe paketini kullanmaz.

## Platform setup ownership

- Native permission, deployment target ve `pubspec.yaml` gibi
  host uygulama işlemleri README'de belgelenir.
- Widget kamera lifecycle, display/error/unsupported UI'yi kendi yönetir.
- Android plugin manifest kamera iznini sağlar; host uygulama merge edilen
  manifesti ve minSdk/compileSdk gereksinimini doğrular.
- iOS host `NSCameraUsageDescription` ekler.
- macOS Windows Linux için QR display kamera izni gerektirmez.

## Example kabul senaryoları

- Metin girilir, QR üretilir, değiştirilince güncellenir.
- Windows üzerinde QR gerçekten çizilir.
- Android üzerinde fiziksel kamera ile QR okutulur, callback bir kez çalışır,
  okunan metin widget dışındaki uygulama alanında gösterilir.
- İzin reddi ve desteklenmeyen platform durumları görünürdür.
- Test/analyze sonuçları ile live evidence ayrı kaydedilir.

## Aşama 1 fiziksel durum

- Root `pubspec.yaml`, `analysis_options.yaml`, `.gitignore` ve public library dosyası mevcut.
- `example/pubspec.yaml`, `example/lib/main.dart`, küçük Example smoke testi mevcut.
- Android/iOS/Windows/Linux/macOS Example runner'ları Flutter CLI ile oluşturuldu ve `7882a42` commit'inde GitHub'a aktarıldı.
- Example `flutter analyze`, `flutter test` (+1), root `flutter analyze` ve Windows Example native build kullanıcı tarafından başarılı çalıştırıldı. Windows run bağlantısının kesilme nedeni çözümlenmedi.
- Public widget implementasyonu, kamera controller ve platform native izin değişiklikleri henüz yok; iOS `NSCameraUsageDescription` Aşama 3 için bekliyor.

## Aşama 2 uygulama kaydı — 2026-10-14

- Public `lib/remvibe_ui_qrcode.dart` yalnız `RemVibeUIQRCode` export eder.
- Kaynak: `lib/src/qr_code/remvibe_ui_qr_code.dart`; servis/controller yok.
- Example metin denetleyicisinin sahibi `_QRCodeDemoPageState`; controller
  `dispose` edilir. Metin değişince widget yeni `data` ile yeniden çizilir.
- Focused root widget testi ve Example metin düzenleme testi eklendi.
- `flutter test` ve `flutter analyze` bu değişiklikler sonrası NOT_RUN.
- Windows'ta gerçek QR görüntüleme **NOT_RUN**; eski Example shell
  disconnect kaydı çözülmedi.
- Scanner, kamera izinleri veya native platform dosyaları bu checkpoint'te
  değiştirilmedi.

## Aşama 2 doğrulama sonuçları (2026-10-14)

Kullanıcı root analyzer PASS, root tests (+2) PASS, Example analyzer PASS
ve Example tests (+1) PASS bildirdi. Windows Example native build çalıştı,
QR kod gerçek ekranda görüldü: **WINDOWS_QR_LIVE_VERIFIED**.
Daha sonra debug bağlantısı `Lost connection to device` ile kesildi;
sebebi **UNRESOLVED**. Manuel metin güncellemesi ve optik QR okutma
ayrıca doğrulanmadı. Scanner halen uygulanmadı.

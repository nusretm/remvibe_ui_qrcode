# Current target — RemVibe UI QR

Tarih: 2026-10-14
Repository: https://github.com/nusretm/remvibe_ui_qrcode
Package adı: `remvibe_ui_qrcode`
Onaylanan kapsam: **Aşama 3 tamamlayıcı Android minSdk uyumu ve son repository incelemesi**. PR/merge için ayrı onay bekleniyor.
Aktif branch: `feature/initial-qr-widgets`.
Merge: kullanıcı onayı bekleniyor.

## Repository başlangıcı

- GitHub repository yeni ve boştu; branch ve commit yoktu.
- GitHub API üzerinde feature branch açılabilmesi için ilk bootstrap
  `README.md` commit'i teknik olarak `main` üzerinde oluşturuldu.
- Bootstrap commit: `56b2e5351d615d9f6fb04d6dc0dd3878c9111d1d`.
- Daha sonraki Aşama 0 belgeleri feature branch'te tutulur.
- Kullanıcı 2026-10-13 tarihinde yerel repository'nin feature branch ile senkronize ve temiz olduğunu `git status` ile doğruladı; dosya listesinde `AGENTS.md`, `CHANGELOG.md`, `README.md`, `docs/` bulundu.
- Kullanıcının yerel Flutter SDK ve toolchain kontrolünün ayrıntıları aşağıdaki "Ortam doğrulaması" bölümünde kayıtlıdır.

## Checkpoint tablosu

| Adım | Durum | Kabul kanıtı |
| --- | --- | --- |
| 0: AGENTS, çalışma kuralları, continuity, README başlangıcı | IMPLEMENTED (doc only; GitHub diff ve yerel temiz working tree kontrol edildi) | Commit `0e6aa97`; kullanıcı `git status` temiz olduğunu bildirdi |
| 1: Flutter package temel dosyaları, pubspec ve bağımlılıklar | IMPLEMENTED + TESTED (Example shell), NATIVE_RUNNERS_COMMITTED; USER_CLOSED_WINDOW | `flutter pub get`, Example analyze/test, root analyze PASS; Windows build/VM Service başlangıcı PASS, sonra bağlantı kesildi |
| 2: QR görüntüleme ve Example alanı | IMPLEMENTED + TESTED + WINDOWS_QR_LIVE_VERIFIED | root analyze PASS; root tests +2; Example analyze PASS; Example tests +1; Windows QR kullanıcı tarafından ekranda görüldü; Windows uygulaması kullanıcı tarafından kapatıldı (EXPECTED_EXIT) |
| 3: QR scanner ve Example alanı | IMPLEMENTED + TESTED + ANDROID_QR_LIVE_VERIFIED; QR_PAINT_GUARD_RETEST_PASS | root analyze PASS / tests +4; Example analyze PASS / tests +1; Android APK build/install/camera PASS; önceki canlı okuma kanıtı geçerli; yeni Android logunda PrettyQr paint assertion tekrarlanmadı |
| 4: diğer hedef platformlar ve odaklı testler | NOT_STARTED | platforma göre ayrı kayıt |
| 5: README final, diff review, PR ve kullanıcı onayı | DOCS_UPDATED / DIFF_REVIEWED; PR_NOT_OPEN / MERGE_NOT_APPROVED | SDK kararı `4811641`, son doc commit; kalan opsiyonel cihaz/lifecycle kontrolleri kayıtlı |

## Sınırlar ve kararlar

- Public sınıflar: `RemVibeUIQRCode`, `RemVibeUIQRScanner`.
- Display: Windows/Linux/macOS hedefi; Android/iOS üzerinde de kullanılabilir.
- Scanner: **yalnız Android/iOS**; desktop unsupported görünüm.
- Web: kapsam dışında.
- No QRService/AccountService/singleton/provider/registry/auth/network/navigation.
- `pubspec.yaml` içinde `pretty_qr_code: 3.6.0` ve `mobile_scanner: 7.4.2` sabitlendi; `flutter_lints: ^5.0.0` yalnız dev dependency (Dart 3.7 minimumunu korumak için).
- Scanner one-shot ve `FutureOr<void> Function(String)` callback; payload
  parse/log/serialize edilmez.
- Minimum Flutter 3.29.0, Dart 3.7.0 (mobile_scanner pubspec gereksinimi);
  kullanıcının yerel SDK sürümleri minimumları karşılıyor; `flutter pub get` ve Windows Example shell native build başarılı.

## Gerçek doğrulama

- Kaynak belgeler: `mtn_launcher/main/AGENTS.md`,
  `mtn_launcher/main/docs/WORKING_RULES.md` okundu ve sadeleştirilerek uyarlandı.
- `mobile_scanner` v7.4.2 pubspec: Dart ^3.7.0, Flutter >=3.29.0;
  Android Gradle kaynağında minSdk 23, compileSdk 36, Java 17 görüldü.
- `pretty_qr_code` 3.6.0 platform/kapsam pub.dev üzerinden gözden geçirildi.
- Kullanıcı `flutter --version` ve `flutter doctor -v` komutlarını yerel Windows makinesinde çalıştırdı; ayrıntılar aşağıdadır.
- Güncel `flutter doctor -v` (kullanıcı raporu): **No issues found!**; tüm kategoriler [✓], Android lisansları tamam.
- `flutter pub get` (root + Example): **PASS**; `pretty_qr_code 3.6.0` ve `mobile_scanner 7.4.2` kuruldu.
- Example `flutter analyze`: **PASS**; Example `flutter test`: **PASS** (+1).
- Root `flutter analyze`: **PASS**.
- Windows Example native build: **PASS**; Dart VM Service başladı. Kullanıcı pencereyi kendisi kapattığını doğruladı, dolayısıyla sonraki `Lost connection to device` mesajı **EXPECTED_EXIT**.
- Flutter/Dart/YAML scaffold GitHub üzerinden oluşturuldu: `pubspec.yaml`, `analysis_options.yaml`, `.gitignore`, public library entrypoint, `example/pubspec.yaml`, `example/lib/main.dart`, minimal Example smoke testi.
- Example `android/`, `ios/`, `windows/`, `linux/`, `macos/` native runner klasörleri **kullanıcının yerel ortamında** `flutter create` ile oluşturuldu (120 dosya raporu); bunlardan commit kapsamına giren 119 yeni dosya GitHub `7882a42` commit'inde **COMMITTED**.
- Windows gerçek QR görünümü: **LIVE_VERIFIED** (kullanıcı QR kodun ekranda göründüğünü bildirdi; Aşama 2).
- Android fiziksel kamera taraması: **LIVE_VERIFIED** (Samsung SM A515F / Android 13, Windows ekranından `RemVibe UI QR` alındı).
- iOS/Linux/macOS: **NOT_RUN**.

## Ortam doğrulaması — kullanıcı raporu (2026-10-13)

Çalışılan dizin: `D:\\development\\cross-platform\\remvibe_ui_qrcode`.
Komutlar **kullanıcının kendi Windows makinesinde** çalıştırıldı;
ChatGPT ortamında yerel Flutter komutu çalıştırıldığı iddia edilmez.

- `flutter --version`: Flutter **3.44.9 stable**, Dart **3.12.2**.
- `flutter doctor -v`: Flutter, Windows, Visual Studio, Chrome,
  connected devices ve network kategorileri **[✓]**.
- Windows: Windows 11 (26H2), Visual Studio Community 2022 17.14.6,
  Windows SDK 10.0.26100.0. Windows desktop target bağlı/erişilebilir.
- Android SDK: 36.1.0, platform android-36 ve build-tools 36.1.0.
- İlk kontrolde Android toolchain **[!]**: bazı SDK lisansları kabul edilmemişti.
- **Yeni `flutter doctor -v` çıktısında Android toolchain [✓]**: tüm Android SDK lisansları kabul edilmiş. Çıktı sonunda **`No issues found!`** gösteriliyor. Android SDK 36.1.0 ve Java 21.0.8 bilgileri değişmedi.
- Android Studio JBR OpenJDK **21.0.8**.
- Connected devices: Windows desktop, Chrome ve Edge. **Fiziksel Android
  cihazı henüz listelenmemiş**; Android kamera live validation yapılmadı.
- Flutter 3.44.9/Dart 3.12.2, planlanan minimum Flutter >=3.29.0 /
  Dart ^3.7.0 koşullarını sürüm bakımından karşılıyor.
- Çıktıda Web cihazları görünmesi Web'i kapsama eklemez.

İlk ortam kaydından sonra Flutter package dependency resolution, Example Windows shell build ve başlangıç çalıştırması doğrulandı. Sonraki Aşama 2'de QR gösterme Windows'ta LIVE_VERIFIED; Aşama 3'te Android/iOS scanner IMPLEMENTED ancak henüz TESTED/LIVE_VERIFIED değildir.

## Aşama 1 uygulama kanıtı ve açık işler (2026-10-14)

- Scaffold commit: `c3085bb5f27e1d2287674a2ceadf134349115d3e`
  (`feature/initial-qr-widgets`). Public widget kodu **yok**.
- Paket manuel olarak Flutter'ın temel `pubspec.yaml`/Dart biçiminde
  oluşturuldu; yerel Flutter executable burada erişilebilir olmadığından
  CLI üzerinden native runner üretimi yapılmadı.
- `example/lib/main.dart` derlenebilir olması hedeflenen, henüz yalnız
  yer tutucu açıklama gösteren basit MaterialApp içerir.
- `example/test/widget_test.dart` smoke testi kullanıcı tarafından `flutter test` ile **PASS** (+1) sonucu verdi.
- Dev lints için `flutter_lints: ^5.0.0` seçildi. v6.0.0, Dart 3.8+
  gerektirdiğinden minimum SDK 3.7 kontratıyla uyumsuzdu.

### Kullanıcı PowerShell kanıtı — Aşama 1 (2026-10-14)

- `git pull --ff-only origin feature/initial-qr-widgets`: PASS, `55b9db9` yerel HEAD.
- Root `flutter pub get`: PASS, `pretty_qr_code 3.6.0` ve `mobile_scanner 7.4.2` çözümlendi.
- `flutter create --platforms=android,ios,windows,linux,macos --project-name=remvibe_ui_qrcode_example example`: PASS; 120 dosya üretildi.
- Example `flutter pub get`: PASS.
- Example `flutter analyze`: PASS (No issues found).
- Example `flutter test`: PASS (+1 All tests passed).
- Example `flutter run -d windows`: BUILD_VERIFIED; exe oluşturuldu, Dart VM Service açıldı ve dosyalar cihaza eşitlendi; ardından `Lost connection to device` mesajı geldi. Kullanıcı daha sonra pencereyi kendisi kapattığını doğruladı: **EXPECTED_EXIT**. Önceki oturumda yalnız Example shell doğrulanmıştı.
- Root `flutter analyze`: PASS (No issues found).
- İlk `git status`: native runner'lar ve Example metadata/lockfile untracked idi. Kullanıcı bunları sonradan `7882a42` ile remote'a push etti.
- Android cihaz, iOS/Linux/macOS native build, QR gösterme/tarama: NOT_RUN.
- 10 newer dependency uyarısı bağımlılık çözümleme başarısızlığı değildir.

### Native runner push ve GitHub incelemesi (2026-10-14)

- Kullanıcının `git push origin feature/initial-qr-widgets` çıktısı:
  `71d00c8..7882a42` — **PASS**.
- GitHub HEAD: `7882a42a0be8f58f4b6abf893a12ac22c379a975`;
  commit başlığı `chore: add Flutter example platform runners`.
- `71d00c8..7882a42` diff: **119 yeni dosya**, yalnız Example
  Android/iOS/Windows/Linux/macOS runner kaynakları, Flutter metadata,
  uygulama `pubspec.lock`, platform asset'leri ve template dosyaları.
- İncelemede `build/`, `.dart_tool/`, `.idea/` veya yerel Android
  SDK `local.properties` commit edilmiş olarak görülmedi.
- `example/ios/Runner/Info.plist` içinde `NSCameraUsageDescription`
  **henüz yok**; scanner'ın Aşama 3 implementasyonunda eklenecek.
- Android Example `minSdk = flutter.minSdkVersion` kullanıyor;
  scanner için Android 23+ koşulu Aşama 3 native build ile doğrulanacak.
- Windows Example oturumundaki `Lost connection to device` mesajı
  kullanıcının pencereyi kendisinin kapatmasından kaynaklandığı için
  **EXPECTED_EXIT** olarak netleştirildi.
- Aşama 1 sonucu: **IMPLEMENTED + TESTED (shell/Windows build)**.
  Android/iOS kamera veya QR davranışı **NOT_STARTED / NOT_RUN**.

## Aşama 2 uygulama kaydı (2026-10-14)

**Açık kullanıcı onayı:** Aşama 2 `RemVibeUIQRCode` implementasyonu.
**Branch:** `feature/initial-qr-widgets`.
**Kaynak commit:** `690e6ab07e91969ca1c6230ad77163c9730441e6`.

- Kaynak: `lib/src/qr_code/remvibe_ui_qr_code.dart`; public export
  `lib/remvibe_ui_qrcode.dart` içine eklendi.
- API: `RemVibeUIQRCode(data: String, size: double = 250)`.
- `PrettyQrView.data` kullanılır; upstream v3.6.0 kendi State'inde
  data değişimlerinde QR matrisini yeniler.
- `PrettyQrDecoration`: siyah kare modüller, beyaz arka plan, dört modüllük
  standart quiet zone. Network veya kamera erişimi yok.
- Boş veri, geçersiz boyut, QR encode/capacity hatası için ayrı,
  içerik sızdırmayan hata görünümleri. Payload loglanmaz.
- Example `example/lib/main.dart` içinde `TextField` ve anlık QR önizlemesi
  eklenmiştir; scanner bu checkpoint dışında tutulmuştur.
- Root `test/remvibe_ui_qr_code_test.dart`: QR/boş içerik geçişi ve
  kapasite taşması kontrolü; Example `example/test/widget_test.dart`:
  metin değişimlerini kapsar.
- Production dependency eklenmedi, `pubspec.yaml` değiştirilmedi.
- İlk implementasyon commit'i oluşturulduğunda yeni `flutter analyze`, `flutter test` ve Windows QR doğrulamaları NOT_RUN durumundaydı. Kullanıcı bunları daha sonra çalıştırdı; aşağıdaki Aşama 2 doğrulama kaydına bak.
- Önceki Aşama 1 Windows bağlantı kesilmesi daha sonra kullanıcı tarafından
  pencerenin kapatılması olarak açıklandı: **EXPECTED_EXIT**.

## Aşama 2 gerçek doğrulama — kullanıcı PowerShell kanıtı (2026-10-14)

Kaynak: Kullanıcının yerel Windows PowerShell komut çıktıları ve
"QRCode ekranda göründü" gözlemi. Sonuçlar fiziksel makinede kullanıcı
tarafından doğrulandı; GitHub üzerinde komut çalıştırıldığı iddia edilmez.

- `git pull --ff-only origin feature/initial-qr-widgets`: PASS;
  `2b4ff5c..fc794c1` fast-forward. Aşama 2 kaynakları yerelde alındı.
- Root `flutter analyze`: **PASS**, No issues found (3.3s).
- Root `flutter test`: **PASS**, +2 All tests passed.
- `example/flutter analyze`: **PASS**, No issues found (1.5s).
- `example/flutter test`: **PASS**, +1 All tests passed.
- `example/flutter run -d windows`: **BUILD_VERIFIED**, Windows
  `remvibe_ui_qrcode_example.exe` üretildi, VM Service başlangıcı görüldü.
- Kullanıcı gerçek Windows ekranında QR kodun göründüğünü bildirdi:
  **WINDOWS_QR_LIVE_VERIFIED** (yalnız QR görünümünün çizilmesi).
- Terminalde tekrar `Lost connection to device` görüldü. Kullanıcı
  uygulamayı kendisinin kapattığını doğruladı: **EXPECTED_EXIT**.
- Manuel olarak QR `data` güncellemesi, boş içerik, kapasite taşması
  veya başka cihazla optik okuma sonucu ayrıca bildirilmedi;
  yalnız bunlara ilişkin odaklı widget testlerinin başarılı olduğu biliniyor.
- Android/iOS scanner: **NOT_IMPLEMENTED / NOT_RUN**.
- Linux/macOS QR görüntüleme: **NOT_RUN**.
- Bu kanıtlarla Aşama 2 QR gösterme checkpoint'i `IMPLEMENTED +
  TESTED + WINDOWS_QR_LIVE_VERIFIED` olarak kapandı.
- Aşama 3 scanner için ayrıca açık kullanıcı onayı gerekir.

## Aşama 3 — QR Scanner implementation (2026-10-14)

Kullanıcı onayı: "Devam edebiliriz." Bu onay yalnız Aşama 3'ü açar;
merge veya farklı checkpoint onayı sayılmaz.

- Commit: `35fe41dbdf7ee8b9e625df08b00bc6b40044713f` on
  `feature/initial-qr-widgets`.
- `lib/src/qr_scanner/remvibe_ui_qr_scanner.dart` eklendi;
  public `RemVibeUIQRScanner(onRead: FutureOr<void> Function(String))`.
- Yalnız Android/iOS kamera açılır. Windows/Linux/macOS/Web scanner
  kontrollü **unsupported** görünüm gösterir.
- Kamera controller'ı, OS kamera izni, uygulama background/resume
  lifecycle ve native camera resource cleanup `mobile_scanner 7.4.2`
  widget'ının dahili lifecycle mekanizmasına bırakıldı.
- `MobileScanner.onDetect` sonuçlarında yalnız `BarcodeFormat.qrCode`
  kabul edilir ve yalnız `rawValue` boş olmayan string olarak iletilir.
  Verinin içeriği parse edilmez, değiştirilmez veya loglanmaz.
- İlk QR algılandığında `_completed` kilidi senkron kurulur;
  scanner sonraki frame'de widget ağacından çıkarılıp plugin cleanup
  başlatılır, ardından callback en fazla **bir kez** çağrılır.
  Callback async olabilir; future hata verirse yalnız genel
  `QR processing failed.` metni gösterilir; otomatik retry yoktur.
- Plugin kamera permission/start hataları widget içinde
  `Camera permission denied...` veya `Camera could not be started.`
  mesajıyla, detection stream hataları `QR scanning failed.`
  mesajıyla karşılanır.
- Example `Open scanner` / `Close scanner` butonuyla kamera alanını
  açıp kapatır ve callback sonucu `Last scanned QR` alanında gösterir.
  Yeni tarama için scanner yeniden açılır.
- Example Android `minSdk = 23` olarak ayarlandı.
- Example iOS `Runner/Info.plist` içine `NSCameraUsageDescription`
  eklendi; Android plugin kendi CAMERA manifest iznini taşır.
- Root: yalnız desktop unsupported durumunu kontrol eden **bir**
  odaklı widget testi eklendi; mevcut Example QR input testi korundu.
- **YENİ Aşama 3 kodu sonrası** `flutter analyze`, `flutter test`,
  Android/iOS native build ve gerçek kamera taraması: **NOT_RUN**.
- Windows QR display Aşama 2 `LIVE_VERIFIED` kanıtı korunur;
  Windows debug kapanış mesajı kullanıcı tarafından **EXPECTED_EXIT**
  olarak açıklanmıştır.
- API ve native source review: `mobile_scanner` `v7.4.2` GitHub
  kaynakları incelendi: `MobileScanner` widget kendi controller'ını
  oluşturduğunda lifecycle'ı gözlemler; `onDetect`, `onDetectError`,
  `errorBuilder` ve hata kodları doğrulandı.
- Minimum Dart/Flutter constraint değiştirilmedi, yeni
  production dependency eklenmedi.

## Aşama 3 — İlk çalıştırma bulguları ve düzeltme (2026-10-14)

Kullanıcının Windows/Android PowerShell çıktıları:

- `git pull --ff-only origin feature/initial-qr-widgets`: **PASS**;
  `fc794c1..76ec0d6` fast-forward.
- Root `flutter analyze`: **PASS**, No issues found.
- Root `flutter test`: **FAIL**, +2 -1; `remvibe_ui_qr_scanner_test.dart`
  içinde `debugDefaultTargetPlatformOverride` yalnız
  `addTearDown` ile reset edildiği için Flutter invariant testi
  "The value of a foundation debug variable was changed by the test."
  hatası üretti. Bu test yalnız test altyapısı hatasıdır;
  Windows scanner unsupported davranışı ayrıca başarısız bulunmadı.
- Example `flutter analyze`: **PASS**, No issues found.
- Example `flutter test`: **PASS**, +1 All tests passed.
- `flutter run -d windows`: **BUILD_VERIFIED**; VM Service açıldı.
  `Lost connection to device` önceki kullanıcı açıklamasına göre
  uygulamanın elle kapatılmasının beklenen sonucudur.
- `flutter devices`: fiziksel Samsung **SM A515F**,
  Android **13 / API 33** (ID `R58R50BT2BB`) bulundu.
- `flutter run -d R58R50BT2BB`: **BUILD_FAILED**,
  `:mobile_scanner:compileDebugKotlin`, Kotlin incremental cache.
  Nested asıl hata: `this and base files have different roots`,
  `C:\Users\nusre\AppData\Local\Pub\Cache\...` ile
  `D:\development\cross-platform\remvibe_ui_qrcode\example\android`
  sürücü farkı. Henüz kamera açılmadı; QR scan live validation yok.

Bu hatalar için `ec02d504ca01bd182e89277b7ff887c98e02bbb1` commit'i:

1. Scanner testinde `debugDefaultTargetPlatformOverride` artık
   `try/finally` ile **test tamamlanmadan** temizleniyor.
2. Yalnız `example/android/gradle.properties` içine
   `kotlin.incremental=false` eklendi. Windows'ta C: pub cache /
   D: Example yolları için Kotlin incremental cache workaround'ı.
   Example Android Kotlin derlemeleri kısmen daha yavaş olabilir.
3. Public widget API, scanner işleyişi, dependency ve diğer platform
   kodları değiştirilmedi.

Bu paragraftaki blokaj durumu ilk `ec02d50` commit'inden hemen sonraki
**tarihsel durumdur**. Kullanıcı daha sonra retest'i tamamladı; aşağıdaki
Android canlı doğrulama kaydı güncel sonucu içerir.

Flutter Android komutu yerel olarak otomatik `Upgrading build.gradle.kts`
mesajı gösterdi; pull öncesinde `git status` ve varsa
`git diff -- example/android/app/build.gradle.kts` kontrol edilmelidir.
Kullanıcı değişiklikleri incelemeden silinmeyecektir.

## Aşama 3 — Fiziksel Android LIVE_VERIFIED (2026-10-14)

**Kullanıcı kanıtı:** Samsung **SM A515F**, Android **13 (API 33)**,
`flutter run -d R58R50BT2BB`; Windows Example'da oluşturulan QR
kamera ile okutuldu ve **`RemVibe UI QR`** metni alındı.

- `git pull --ff-only origin feature/initial-qr-widgets`: **PASS**
  (`76ec0d6..ee7e3ed` fast-forward).
- `flutter test` (root): **PASS**, `+3 All tests passed!`.
  Önceki debug platform override test hatası giderildi.
- `example/flutter clean`: **PASS**.
- `example/flutter pub get`: **PASS**, Got dependencies.
- `example/flutter run -d R58R50BT2BB`: Android Gradle
  `assembleDebug` **PASS**, APK oluşturuldu ve cihaza kuruldu.
  Kotlin C:/D: incremental cache derleme hatası tekrarlanmadı.
- Android Dart VM Service başladı, CameraX/ML Kit kamera açılışı
  logları mevcut. Kullanıcı **gerçek QR tarama sonucunu** doğruladı.
- **ANDROID_QR_LIVE_VERIFIED**: Windows ekranından Android scanner'a
  tam metin okuma başarılı. Tek okutma için kanıt mevcut; birden çok
  tekrarlı algılamada callback sayısı, izin reddi, yeniden scanner
  açma, background/resume, iOS gerçek cihaz testi **henüz ayrıca
  doğrulanmadı**.

### Açılışta QR painter hatası (Android)

Android ilk frame'inde `pretty_qr_code 3.6.0` için:
`PrettyQrSquaresSymbol.paint` -> `clampDouble` assertion,
`PrettyQrRenderView` constraints `BoxConstraints(w=0.0, h=250.0)`.
Bu hata **gerçek logda var**, başarılı Android QR scan ile karıştırılmadı.

- Düzeltme commit'i `ede14115110e7f9de50eb7abb87caf728945f4f5`.
- `RemVibeUIQRCode` iç `LayoutBuilder` ile genişlik veya yükseklik
  sıfırken `PrettyQrView` üretmiyor; geçerli ölçüler gelince çiziyor.
- Root QR widget testine sıfır genişlikten geçerli ölçülere geçiş
  senaryosu eklendi. Kütüphane bağımlılığı veya scanner callback'i
  değişmedi.
- **Tarihsel kayıt:** düzeltme commit'i hemen sonrasında retest PENDING idi.
  Kullanıcı sonraki çalıştırmada root/Example analiz ve testlerle Android
  açılışını doğruladı. Sonuçlar aşağıdaki yeni doğrulama bölümünde.

### Yerel Gradle dosyası

Kullanıcının `git status --short` çıktısında
`example/android/app/build.gradle.kts` yerel **modified**:
`minSdk = 23` yerine `minSdk = flutter.minSdkVersion`.
Değişiklik Flutter'ın önceki `Upgrading build.gradle.kts`
davranışına bağlı görünüyor. Kullanıcının Android build'i
**bu yerel değişiklikle** başarılı oldu.
Bu yerel modifikasyon GitHub'a commit edilmiş varsayılmaz; otomatik
`git restore` / override yapılmamalı. Pull öncesi mevcut diff gözden
geçirilmeli. Native minSdk tutarlılığı sonraki incelemede çözülmeli.

## Aşama 3 — QR paint guard retest PASS (2026-10-14)

**Kullanıcının yerel PowerShell çıktısı**, güncel commit
`cb9f12f8a619769f05a1bc01edf0fe098379ec18` pull edildikten sonra:

- `git pull --ff-only origin feature/initial-qr-widgets`: **PASS**,
  `ee7e3ed..cb9f12f` fast-forward.
- Root `flutter analyze`: **PASS**, No issues found (2.6s).
- Root `flutter test`: **PASS**, `+4 All tests passed!`.
  Sıfır genişlik QR görünümünü kapsayan regresyon testi eklendiği
  haliyle başarılı.
- Example `flutter analyze`: **PASS**, No issues found (1.7s).
- Example `flutter test`: **PASS**, `+1 All tests passed!`.
- `example/flutter run -d R58R50BT2BB`: Android Gradle
  `assembleDebug` **PASS** (12.1s), APK **BUILT + INSTALLED**,
  Android Dart VM Service başlatıldı.
- Başlangıç Flutter engine logunda `Width is zero. 0,0`
  görülmesi normal ilk boyutlandırma ile uyumlu. Önceki
  `PrettyQrSquaresSymbol.paint` / `clampDouble` assertion'ı
  **bu çalıştırmada tekrarlanmadı**.
- Kamera CameraX grafiği açıldı, `CameraGraph-1` active oldu;
  uygulama sonunda kapanış logları geldi (`Application finished.`).
- Çok sayıda `mali_winsys: Unrecognised Android chroma siting range`
  ve kamera kapanırken `BufferQueue has been abandoned` mesajı
  kaydedildi; bu logda uygulamayı durdurmuş değiller. Ayrı
  donanım/performans takibi gerektirirse yeni kanıt istenir.
- **Yeni çalıştırmada ikinci QR okuma gözlemi bildirilmedi.**
  Önceki başarılı Windows QR → Android `RemVibe UI QR` canlı
  taraması `ANDROID_QR_LIVE_VERIFIED` olarak korunuyor.
- One-shot tekrar algılama sayısı, scanner yeniden açma,
  izin reddi, app background/resume ve iOS cihaz testi **NOT_VERIFIED**.
- `example/android/app/build.gradle.kts` içindeki yerel
  `minSdk = flutter.minSdkVersion` farkı önceki logdan biliniyor;
  güncel `git status` çıktısı olmadığı için çözülmüş sayılmıyor.
  Kullanıcı incelemesi olmadan yerel dosya restore edilmeyecek.

**Aşama 3 temel kabulü:** QR scanner gerçek Android 13 cihazda
çalıştı ve ham metni doğru iletti; kaynak analizi/testler ve son
QR paint guard retest başarılı. Ek lifecycle senaryoları,
iOS ve yerel Gradle diff'i release review için açık.

## Aşama 3 — Android minSdk kararı ve son diff review (2026-10-14)

Kullanıcı `git status --short` ile yalnız
`example/android/app/build.gradle.kts` değişikliğini doğruladı.
`git diff` yalnız şu satırı gösterdi:

```diff
- minSdk = 23
+ minSdk = flutter.minSdkVersion
```

Kullanıcı "yapalım" diyerek bu uyum değişikliğini ve documentation
incelemesini onayladı. GitHub'a bakıldığında **değişiklik zaten
commit edilmiş** bulundu:

- `4811641ab36b4aae7a11e36d543b787466104b81`
- Mesaj: `build: use Flutter default Android minSdk`
- Parent: `30860042e642784fc01f783707b5349b06e6159c`
- `3086004..4811641` diff: **yalnız**
  `example/android/app/build.gradle.kts`; bir satır değiştirildi.
- Flutter **3.44.9** `FlutterExtension.kt`: varsayılan
  `minSdkVersion = 24`; `mobile_scanner 7.4.2`
  için minimum API **23** gereksinimi karşılanır.
- Önceki fiziksel Samsung SM A515F / Android 13 build ve QR scan
  **LIVE_VERIFIED** durumu korunur. `4811641` commit'inden
  sonra ayrıca bir `flutter run` kanıtı gelmedi; otomatik
  `PASS` yazılmaz.
- Bu commit GitHub branch'inde bulunduğundan aynı satır için
  ikinci kaynak değişikliği yapılmadı; local working tree'nin
  temiz olduğu yeni `git status` ile ayrıca doğrulanmalı.

### Son repository incelemesi

`main..feature/initial-qr-widgets` GitHub diff'i incelendi.
Kaynakta iki public widget ve Example platform runner'ları mevcut;
bağımlılıklar yalnız `pretty_qr_code 3.6.0` ve
`mobile_scanner 7.4.2`. QR payload parsing/auth/service eklenmedi.
Daha önceki kullanıcı kanıtları root analyze +4 tests, Example
analyze +1 test, Windows QR display ve Samsung Android QR optik
okuması için PASS/LIVE_VERIFIED.

Açık doğrulama/işletim riskleri: scanner'ın tekrar eden eventlerde
one-shot callback sayısı gerçek cihazda ölçülmedi; permission denied,
background/resume, yeniden kamera açma ve iOS gerçek cihaz testi
ayrıca yapılmadı. Linux/macOS ekran gösterimi test edilmedi.
Bu konular **UNVERIFIED**, başarısız olarak raporlanmış değiller.
`pubspec.yaml` hâlâ `publish_to: none` ve
`0.1.0-dev.1`; yayınlama bu checkpoint kapsamında değildir.

Bu inceleme **PR açma veya merge yetkisi değildir**.

## Sonraki hedef

1. Yerelde `git pull --ff-only origin feature/initial-qr-widgets`
   ve `git status` ile `4811641` ve yeni continuity commit'i
   senkronize/temiz olduğunu doğrula.
2. İstenirse Android'de bir kez daha `flutter run` ile
   varsayılan minSdk yapılandırmasının bu commit'te de
   çalıştığını göster; önceki build/scan kanıtları aynen korunur.
3. Scanner lifecycle/permission ve iOS/Linux/macOS platform
   kontrolleri ayrı opsiyonel doğrulamalardır; yapılmadan PASS
   sayılmayacak.
4. PR/merge için **kullanıcıdan ayrı açık onay** al.

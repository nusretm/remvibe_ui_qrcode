# Current target — RemVibe UI QR

Tarih: 2026-10-13
Repository: https://github.com/nusretm/remvibe_ui_qrcode
Package adı: `remvibe_ui_qrcode`
Onaylanan kapsam: yalnız **Aşama 0**, çalışma kuralları ve continuity/başlangıç README.
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
| 1: Flutter package temel dosyaları, pubspec ve bağımlılıklar | NOT_STARTED | flutter pub get + SDK bilgisi |
| 2: QR görüntüleme ve Example alanı | NOT_STARTED | Windows QR gösterimi |
| 3: QR scanner ve Example alanı | NOT_STARTED | Android gerçek kamera okumayı doğrulama |
| 4: diğer hedef platformlar ve odaklı testler | NOT_STARTED | platforma göre ayrı kayıt |
| 5: README final, diff review, PR ve kullanıcı onayı | NOT_STARTED | gözden geçirilmiş PR; merge ayrı onaylı |

## Sınırlar ve kararlar

- Public sınıflar: `RemVibeUIQRCode`, `RemVibeUIQRScanner`.
- Display: Windows/Linux/macOS hedefi; Android/iOS üzerinde de kullanılabilir.
- Scanner: **yalnız Android/iOS**; desktop unsupported görünüm.
- Web: kapsam dışında.
- No QRService/AccountService/singleton/provider/registry/auth/network/navigation.
- `pretty_qr_code 3.6.0`, `mobile_scanner 7.4.2` planlandı.
- Scanner one-shot ve `FutureOr<void> Function(String)` callback; payload
  parse/log/serialize edilmez.
- Minimum Flutter 3.29.0, Dart 3.7.0 (mobile_scanner pubspec gereksinimi);
  kullanıcının yerel SDK sürümleri minimumları karşılıyor; pub get/native derleme henüz çalıştırılmadı.

## Gerçek doğrulama

- Kaynak belgeler: `mtn_launcher/main/AGENTS.md`,
  `mtn_launcher/main/docs/WORKING_RULES.md` okundu ve sadeleştirilerek uyarlandı.
- `mobile_scanner` v7.4.2 pubspec: Dart ^3.7.0, Flutter >=3.29.0;
  Android Gradle kaynağında minSdk 23, compileSdk 36, Java 17 görüldü.
- `pretty_qr_code` 3.6.0 platform/kapsam pub.dev üzerinden gözden geçirildi.
- Kullanıcı `flutter --version` ve `flutter doctor -v` komutlarını yerel Windows makinesinde çalıştırdı; ayrıntılar aşağıdadır.
- `flutter pub get`, `flutter analyze`, `flutter test`, native build: **NOT_RUN**.
- Windows gerçek QR görünümü: **NOT_RUN**.
- Android fiziksel kamera taraması: **NOT_RUN**.
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
- Android toolchain **[!]**: Android SDK lisanslarının bazıları kabul edilmemiş.
  Önerilen çözüm: `flutter doctor --android-licenses` (kullanıcı yapacak).
- Android Studio JBR OpenJDK **21.0.8**.
- Connected devices: Windows desktop, Chrome ve Edge. **Fiziksel Android
  cihazı henüz listelenmemiş**; Android kamera live validation yapılmadı.
- Flutter 3.44.9/Dart 3.12.2, planlanan minimum Flutter >=3.29.0 /
  Dart ^3.7.0 koşullarını sürüm bakımından karşılıyor.
- Çıktıda Web cihazları görünmesi Web'i kapsama eklemez.

Bu kayıt sadece SDK/toolchain keşfini doğrular. Flutter package dependency
resolution, plugin native compilation, QR gösterme ve kamera tarama sonucu
**henüz doğrulanmadı**.

## Sonraki hedef

1. Aşama 0 GitHub diff ve kullanıcı yerel working tree sonucu kontrol edildi.
2. Kullanıcı **Aşama 1'e geçişi açıkça onaylarsa** `flutter create --template=package`
   temeli, `pubspec.yaml`, platforma uygun `.gitignore` ve Example
   hazırlığını uygula.
3. Android build öncesinde SDK lisanslarını kabul et ve `flutter doctor` ile
   uyarının giderildiğini doğrula; Android gerçek kamera testi için fiziksel cihaz bağla.
4. Her gerçek platform denemesini bu dosyaya açık sonuçla kaydet.

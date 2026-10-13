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
- Yerel Windows çalışma dizini ve Flutter SDK bu ortamdan **doğrulanamadı**.

## Checkpoint tablosu

| Adım | Durum | Kabul kanıtı |
| --- | --- | --- |
| 0: AGENTS, çalışma kuralları, continuity, README başlangıcı | IMPLEMENTED (doc only; commit review pending) | GitHub'da dosyaların varlığı/branch kontrolü |
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
  yerel SDK/pub get/native derleme henüz çalıştırılmadı.

## Gerçek doğrulama

- Kaynak belgeler: `mtn_launcher/main/AGENTS.md`,
  `mtn_launcher/main/docs/WORKING_RULES.md` okundu ve sadeleştirilerek uyarlandı.
- `mobile_scanner` v7.4.2 pubspec: Dart ^3.7.0, Flutter >=3.29.0;
  Android Gradle kaynağında minSdk 23, compileSdk 36, Java 17 görüldü.
- `pretty_qr_code` 3.6.0 platform/kapsam pub.dev üzerinden gözden geçirildi.
- Flutter/Dart komutları: **NOT_RUN**.
- Windows gerçek QR görünümü: **NOT_RUN**.
- Android fiziksel kamera taraması: **NOT_RUN**.
- iOS/Linux/macOS: **NOT_RUN**.

## Sonraki hedef

1. Aşama 0 diff/commit varlığını gözden geçir.
2. Kullanıcı Aşama 1'e geçişi onaylarsa `flutter create --template=package`
   temeli, `pubspec.yaml`, platforma uygun `.gitignore` ve Example
   hazırlığını uygula.
3. Yerel ortam için kullanıcının `flutter --version`, `flutter doctor -v`
   çıktısı veya GitHub/CI çalışma kanıtı gerektiğinde alınır.
4. Her gerçek platform denemesini bu dosyaya açık sonuçla kaydet.

# Changelog

## Unreleased

### Planned
- Android scanner lifecycle/one-shot edge-case checks and optional iOS device validation.

### Android live scanner + initial QR layout guard — 2026-10-14
- Root widget tests +3 PASS, Android Example debug APK build/install PASS.
- Physical Samsung SM A515F (Android 13) scanned the Windows Example QR:
  exact text `RemVibe UI QR` (ANDROID_QR_LIVE_VERIFIED).
- Kotlin cross-drive cache failure no longer blocks Android debug build.
- Android first-frame render assertion found at `PrettyQrView` width zero.
- Add LayoutBuilder guard preventing Pretty QR painting until both layout
  dimensions are positive, with a focused zero-width widget regression test.
- This latest QR paint fix has not yet been re-analyzed, re-tested or
  re-verified on Android; other scanner lifecycle/permission cases pending.

### Aşama 3 build/test düzeltmesi — 2026-10-14
- Reset the desktop scanner widget-test platform override inside `try/finally`,
  before Flutter test invariant checks.
- Work around cross-drive Kotlin incremental-cache failures in the Android
  Example using `kotlin.incremental=false` in `example/android/gradle.properties`.
- Root analyze and Example analyze/test passed; initial root test and Android
  build failed as recorded in continuity. Fixes are committed, rerun pending.

### QR scanner (Aşama 3) — 2026-10-14
- Add `RemVibeUIQRScanner` with one-shot `FutureOr<void>` QR callback.
- Limit scanning to Android/iOS, show controlled unsupported UI on desktop/Web.
- Delegate camera permission, lifecycle and disposal to `mobile_scanner`.
- Handle permission, start/detection and callback failures without leaking raw QR data.
- Add Example scanner open/close actions and last scanned string display.
- Configure Example Android minSdk 23 and iOS `NSCameraUsageDescription`.
- Add one focused desktop unsupported widget test.
- Stage 3 analyze, tests and Android/iOS camera run have not yet been executed.

### QR display (Aşama 2) — 2026-10-14
- Add `RemVibeUIQRCode(data: ..., size: 250)` using `pretty_qr_code 3.6.0`.
- Preserve a four-module quiet zone and black-on-white contrast.
- Show safe fallback for empty, unencodable, or over-capacity contents.
- Replace Example placeholder with editable text and QR preview.
- Add focused root QR and Example interaction tests (not yet executed).
- Validate QR display in a real Windows Example run (user confirmed QR visible).
- Root `flutter analyze` PASS, `flutter test` +2 PASS; Example `flutter analyze` PASS, `flutter test` +1 PASS.
- Windows `Lost connection to device` was expected: user closed the Example window.

### Package/Example scaffold — 2026-10-14
- Add Flutter package `pubspec.yaml`, public library entrypoint and lints.
- Pin `pretty_qr_code: 3.6.0` and `mobile_scanner: 7.4.2`.
- Add Example MaterialApp shell, example `pubspec.yaml`, and one smoke test.
- Add Flutter/Dart/IDE generated-artifact ignore rules.
- Add Android, iOS, Windows, Linux and macOS native Example runner templates (commit `7882a42`).
- Verify root/Example dependency resolution and analysis; Example smoke test passed (+1).
- Verify Windows Example shell native build and VM Service startup; termination followed the user's window close.

### Documentation baseline — 2026-10-13
- Adapt repository working rules from `mtn_launcher`.
- Record architecture, current target, platform contract, and verification status.
- Draft README integration and native platform setup guide.

> QR display has been visually verified on Windows; Android scanner read succeeded on a physical Samsung device. Initial Android QR-paint zero-width assertion guard is committed but awaits device retest. iOS, Linux/macOS and lifecycle edge cases remain unverified.

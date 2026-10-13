# Changelog

## Unreleased

### Initial QR widget foundation merge — 2026-10-14
- PR #1 (https://github.com/nusretm/remvibe_ui_qrcode/pull/1) merged into
  `main` by squash: `e694a187550209eff0b727012b0281f10237bd5f`.
- User verified `git pull --ff-only origin main` and clean working tree.
- Windows QR display, Android physical QR scan and latest widget tests remain
  the recorded acceptance evidence; no post-merge Flutter run claimed.
- Preserve iOS, Linux/macOS and scanner lifecycle/permission cases as
  unverified; publishing and branch cleanup are separate actions.

### Planned
- Android scanner lifecycle/one-shot edge-case checks and optional iOS device validation.

### Android Example minSdk alignment and repository review — 2026-10-14
- Accept Flutter-generated `minSdk = flutter.minSdkVersion` in Example Android
  host project (commit `4811641`); Flutter 3.44.9 defaults to API 24.
- Confirm Android scanner dependency requires at least API 23.
- Review feature branch diff and synchronize README/continuity with
  validated devices, outstanding lifecycle tests, and pre-merge status.
- PR/merge not performed; no separate post-minSdk native build reported.

### Android live scanner + initial QR layout guard — 2026-10-14
- Root widget tests +3 PASS, Android Example debug APK build/install PASS.
- Physical Samsung SM A515F (Android 13) scanned the Windows Example QR:
  exact text `RemVibe UI QR` (ANDROID_QR_LIVE_VERIFIED).
- Kotlin cross-drive cache failure no longer blocks Android debug build.
- Android first-frame render assertion found at `PrettyQrView` width zero.
- Add LayoutBuilder guard preventing Pretty QR painting until both layout
  dimensions are positive, with a focused zero-width widget regression test.
- QR paint guard retest: root analyze PASS / tests +4 PASS, Example
  analyze PASS / tests +1 PASS, Samsung Android debug APK build/install
  and camera startup PASS; the previous paint assertion did not recur.
- The final run did not report another scanned payload; prior successful
  optical QR read remains valid. Lifecycle/permission edge cases pending.

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

> QR display is verified on Windows; Android scanner successfully read a Windows QR on Samsung. Initial Android zero-width QR paint guard now passed tests and an Android device run without recurring paint assertion. iOS, Linux/macOS and lifecycle edge cases remain unverified.

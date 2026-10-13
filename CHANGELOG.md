# Changelog

## Unreleased

### Planned
- `RemVibeUIQRScanner` Android/iOS one-shot scanner backed by `mobile_scanner`.
- Android scanner Example and real Android camera validation.

### QR display (Aşama 2) — 2026-10-14
- Add `RemVibeUIQRCode(data: ..., size: 250)` using `pretty_qr_code 3.6.0`.
- Preserve a four-module quiet zone and black-on-white contrast.
- Show safe fallback for empty, unencodable, or over-capacity contents.
- Replace Example placeholder with editable text and QR preview.
- Add focused root QR and Example interaction tests (not yet executed).
- Validate QR display in a real Windows Example run (user confirmed QR visible).
- Root `flutter analyze` PASS, `flutter test` +2 PASS; Example `flutter analyze` PASS, `flutter test` +1 PASS.
- Windows debug session later reported `Lost connection to device`; cause still unresolved.

### Package/Example scaffold — 2026-10-14
- Add Flutter package `pubspec.yaml`, public library entrypoint and lints.
- Pin `pretty_qr_code: 3.6.0` and `mobile_scanner: 7.4.2`.
- Add Example MaterialApp shell, example `pubspec.yaml`, and one smoke test.
- Add Flutter/Dart/IDE generated-artifact ignore rules.
- Add Android, iOS, Windows, Linux and macOS native Example runner templates (commit `7882a42`).
- Verify root/Example dependency resolution and analysis; Example smoke test passed (+1).
- Verify Windows Example shell native build and VM Service startup; subsequent disconnection remains unresolved.

### Documentation baseline — 2026-10-13
- Adapt repository working rules from `mtn_launcher`.
- Record architecture, current target, platform contract, and verification status.
- Draft README integration and native platform setup guide.

> QR display is implemented, analyzed, tested, and visually verified on Windows. Scanner is not implemented. Debug connection loss remains unresolved; Android/iOS, Linux/macOS and QR optical-reading validation are pending.

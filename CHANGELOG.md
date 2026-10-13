# Changelog

## Unreleased

### Planned
- `RemVibeUIQRCode` display widget backed by `pretty_qr_code`.
- `RemVibeUIQRScanner` Android/iOS one-shot scanner backed by `mobile_scanner`.
- Runnable Example app and real Windows / Android validation.

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

> QR widgets and device scanner are not implemented or live-verified. Example runner templates and a Windows shell build are present; the Windows run disconnect remains unresolved.

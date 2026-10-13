import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remvibe_ui_qrcode/remvibe_ui_qrcode.dart';

void main() {
  testWidgets('Desktop scanner shows an unsupported message without a camera', (tester) async {
    debugDefaultTargetPlatformOverride = TargetPlatform.windows;
    try {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: RemVibeUIQRScanner(onRead: (data) {}),
        ),
      ));

      expect(find.text('QR scanning is not supported on this platform.'), findsOneWidget);
    } finally {
      // Flutter checks foundation overrides before tearDown callbacks run.
      debugDefaultTargetPlatformOverride = null;
    }
  });
}

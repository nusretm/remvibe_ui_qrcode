import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:remvibe_ui_qrcode/remvibe_ui_qrcode.dart';

void main() {
  testWidgets('renders a QR and handles updates to its data', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: RemVibeUIQRCode(data: 'first')),
    ));
    expect(find.byType(PrettyQrView), findsOneWidget);

    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: RemVibeUIQRCode(data: '')),
    ));
    expect(find.text('QR content cannot be empty.'), findsOneWidget);

    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(body: RemVibeUIQRCode(data: 'second')),
    ));
    expect(find.byType(PrettyQrView), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('defers QR painting while layout width is zero', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: SizedBox(
          width: 0,
          height: 250,
          child: RemVibeUIQRCode(data: 'RemVibe UI QR'),
        ),
      ),
    ));

    expect(find.byType(PrettyQrView), findsNothing);
    expect(tester.takeException(), isNull);

    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: SizedBox(
          width: 250,
          height: 250,
          child: RemVibeUIQRCode(data: 'RemVibe UI QR'),
        ),
      ),
    ));

    expect(find.byType(PrettyQrView), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('reports QR-capacity overflow without exposing data', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: RemVibeUIQRCode(data: List.filled(5000, 'x').join())),
    ));

    expect(find.text('QR content could not be encoded.'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remvibe_ui_qrcode/remvibe_ui_qrcode.dart';
import 'package:remvibe_ui_qrcode_example/main.dart';

void main() {
  testWidgets('Example edits the displayed QR content', (tester) async {
    await tester.pumpWidget(const RemVibeUIQRCodeExampleApp());

    expect(find.byType(RemVibeUIQRCode), findsOneWidget);
    expect(find.text('QR preview'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('qr_data_input')), '');
    await tester.pump();
    expect(find.text('QR content cannot be empty.'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('qr_data_input')), 'Another QR');
    await tester.pump();
    expect(tester.widget<RemVibeUIQRCode>(find.byType(RemVibeUIQRCode)).data, 'Another QR');
    expect(find.text('QR content cannot be empty.'), findsNothing);
  });
}

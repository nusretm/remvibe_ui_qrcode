import 'package:flutter_test/flutter_test.dart';
import 'package:remvibe_ui_qrcode_example/main.dart';

void main() {
  testWidgets('Example baseline renders', (tester) async {
    await tester.pumpWidget(const RemVibeUIQRCodeExampleApp());

    expect(find.text('QR widgets are being implemented.'), findsOneWidget);
  });
}

import 'package:flutter/material.dart';
import 'package:remvibe_ui_qrcode/remvibe_ui_qrcode.dart';

void main() {
  runApp(const RemVibeUIQRCodeExampleApp());
}

/// A small interactive example for the approved QR-display widget.
class RemVibeUIQRCodeExampleApp extends StatelessWidget {
  const RemVibeUIQRCodeExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'RemVibe UI QR Example',
      home: _QRCodeDemoPage(),
    );
  }
}

class _QRCodeDemoPage extends StatefulWidget {
  const _QRCodeDemoPage();

  @override
  State<_QRCodeDemoPage> createState() => _QRCodeDemoPageState();
}

class _QRCodeDemoPageState extends State<_QRCodeDemoPage> {
  final TextEditingController _textController = TextEditingController(text: 'RemVibe UI QR');

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('RemVibe UI QR')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      key: const Key('qr_data_input'),
                      controller: _textController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: 'QR content',
                        hintText: 'Enter text to encode',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                    const SizedBox(height: 24),
                    const Text('QR preview', textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                    Center(
                      child: RemVibeUIQRCode(
                        data: _textController.text,
                        size: 250,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

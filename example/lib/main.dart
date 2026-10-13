import 'package:flutter/material.dart';
import 'package:remvibe_ui_qrcode/remvibe_ui_qrcode.dart';

void main() {
  runApp(const RemVibeUIQRCodeExampleApp());
}

/// Editable QR preview and a separate on-demand camera scanner.
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
  bool _scannerVisible = false;
  String? _lastRead;

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
                    const SizedBox(height: 24),
                    if (!_scannerVisible)
                      FilledButton(
                        onPressed: () => setState(() => _scannerVisible = true),
                        child: const Text('Open scanner'),
                      )
                    else ...[
                      SizedBox(
                        height: 300,
                        child: RemVibeUIQRScanner(
                          onRead: (data) {
                            if (!mounted) return;
                            setState(() {
                              _lastRead = data;
                              _scannerVisible = false;
                            });
                          },
                        ),
                      ),
                      TextButton(
                        onPressed: () => setState(() => _scannerVisible = false),
                        child: const Text('Close scanner'),
                      ),
                    ],
                    const SizedBox(height: 16),
                    const Text('Last scanned QR'),
                    SelectableText(_lastRead ?? 'No QR read yet.'),
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

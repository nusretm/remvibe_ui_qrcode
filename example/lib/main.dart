import 'package:flutter/material.dart';

void main() {
  runApp(const RemVibeUIQRCodeExampleApp());
}

/// Small application shell used to exercise the package on target platforms.
///
/// QR display and camera widgets are added in their approved checkpoints.
class RemVibeUIQRCodeExampleApp extends StatelessWidget {
  const RemVibeUIQRCodeExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RemVibe UI QR Example',
      home: Scaffold(
        appBar: AppBar(title: const Text('RemVibe UI QR')),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Text(
              'QR widgets are being implemented.',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

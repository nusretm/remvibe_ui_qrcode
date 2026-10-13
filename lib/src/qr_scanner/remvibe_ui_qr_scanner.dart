import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

/// Reads one QR code through the device camera on Android or iOS.
///
/// Camera permissions and app lifecycle are managed by [MobileScanner].
/// Other platforms never initialize the camera and show an unsupported view.
///
/// The exact raw QR string is delivered only once per widget lifetime.
/// Navigation, interpretation, and logging of that data belong to the caller.
class RemVibeUIQRScanner extends StatefulWidget {
  const RemVibeUIQRScanner({
    super.key,
    required this.onRead,
  });

  final FutureOr<void> Function(String data) onRead;

  @override
  State<RemVibeUIQRScanner> createState() => _RemVibeUIQRScannerState();
}

class _RemVibeUIQRScannerState extends State<RemVibeUIQRScanner> {
  bool _completed = false;
  String? _errorMessage;

  void _onDetect(BarcodeCapture capture) {
    if (!mounted || _completed || _errorMessage != null) return;

    for (final barcode in capture.barcodes) {
      if (barcode.format != BarcodeFormat.qrCode) continue;

      final data = barcode.rawValue;
      if (data == null || data.isEmpty) continue;

      // Lock synchronously. Replacing MobileScanner begins camera disposal
      // on the next frame and guarantees no more onRead calls.
      setState(() => _completed = true);

      // Let the camera preview leave the tree before delivering the data.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) unawaited(_deliver(data));
      });
      return;
    }
  }

  Future<void> _deliver(String data) async {
    try {
      await widget.onRead(data);
    } catch (_) {
      if (!mounted) return;
      setState(() => _errorMessage = 'QR processing failed.');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb || (defaultTargetPlatform != TargetPlatform.android && defaultTargetPlatform != TargetPlatform.iOS)) {
      return const Center(
        child: Text(
          'QR scanning is not supported on this platform.',
          textAlign: TextAlign.center,
        ),
      );
    }

    if (_completed || _errorMessage != null) {
      return Center(
        child: Text(
          _errorMessage ?? 'QR code read.',
          textAlign: TextAlign.center,
        ),
      );
    }

    return MobileScanner(
      useAppLifecycleState: true,
      onDetect: _onDetect,
      onDetectError: (error, stackTrace) {
        if (!mounted || _completed || _errorMessage != null) return;
        setState(() => _errorMessage = 'QR scanning failed.');
      },
      placeholderBuilder: (context) => const Center(child: CircularProgressIndicator()),
      errorBuilder: (context, error) => Center(
        child: Text(
          error.errorCode == MobileScannerErrorCode.permissionDenied
              ? 'Camera permission denied. Enable camera access in device settings.'
              : 'Camera could not be started.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

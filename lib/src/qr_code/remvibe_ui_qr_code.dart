import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

/// Displays [data] as a QR code without any network or camera access.
///
/// The QR is black on white with a standard four-module quiet zone. If [data]
/// is empty or cannot be encoded, a safe error message is shown instead.
class RemVibeUIQRCode extends StatelessWidget {
  const RemVibeUIQRCode({
    super.key,
    required this.data,
    this.size = 250,
  });

  /// Exact text encoded in the QR symbol; it is never parsed or logged.
  final String data;

  /// Width and height of the square QR widget, in logical pixels.
  final double size;

  @override
  Widget build(BuildContext context) {
    if (!size.isFinite || size <= 0) {
      return const Text('QR size must be positive.');
    }

    return SizedBox.square(
      dimension: size,
      child: ColoredBox(
        color: Colors.white,
        child: data.isEmpty
            ? const Center(
                child: Text(
                  'QR content cannot be empty.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black87),
                ),
              )
            : PrettyQrView.data(
                data: data,
                decoration: const PrettyQrDecoration(
                  background: Colors.white,
                  shape: PrettyQrSquaresSymbol(color: Colors.black),
                  quietZone: PrettyQrQuietZone.standard,
                ),
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Text(
                    'QR content could not be encoded.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black87),
                  ),
                ),
              ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScanScreen extends StatefulWidget {
  const QrScanScreen({super.key});

  @override
  State<QrScanScreen> createState() => _QrScanScreenState();
}

class _QrScanScreenState extends State<QrScanScreen> {
  static const channel = MethodChannel('alarm_channel');
  bool _handled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan QR')),
      body: MobileScanner(
        onDetect: (BarcodeCapture capture) async {
          if (_handled) return;

          final List<Barcode> barcodes = capture.barcodes;

          if (barcodes.isNotEmpty) {
            final String? qrValue = barcodes.first.rawValue;

            if (qrValue != null) {
              _handled = true;

              // ✅ QR scanned successfully → STOP alarm
              await channel.invokeMethod('stopAlarm');

              if (mounted) {
                Navigator.pop(context);
              }
            }
          }
        },
      ),
    );
  }
}

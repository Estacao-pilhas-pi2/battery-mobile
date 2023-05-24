import 'dart:convert';

import 'package:estacao_pilhas/pages/qr_code_reader/components/qr_code_overlay.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrCodeReader extends StatefulWidget {
  const QrCodeReader(
      {Key? key, required this.displayText, required this.onRead})
      : super(key: key);

  final String displayText;
  final bool Function(dynamic barcodes, BuildContext context) onRead;
  @override
  State<QrCodeReader> createState() => _QrCodeReaderState();
}

class _QrCodeReaderState extends State<QrCodeReader> {
  final MobileScannerController _mobileScannerController =
      MobileScannerController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      MobileScanner(
        controller: _mobileScannerController,
        onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          for (final barcode in barcodes) {
            final barcodeRaw = barcode.rawValue;
            if (barcodeRaw != null) {
              final qrCodeObject = json.decode(barcodeRaw);
              if (widget.onRead(qrCodeObject, context)) {
                _mobileScannerController.events?.cancel();
              }
            }
          }
        },
      ),
      QRScannerOverlay(
        overlayColour: Colors.black.withOpacity(0.5),
        displayText: widget.displayText,
      ),
    ]));
  }
}

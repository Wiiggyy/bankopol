import 'dart:io';

import 'package:bankopol/widgets/action_button.dart';
import 'package:camera/camera.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';

class QrScanner extends StatefulWidget {
  final Function(String code) onCode;
  const QrScanner({super.key, required this.onCode});

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  final _qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();
  String? code;

  @override
  Widget build(BuildContext context) {
    return ActionButton(
      onPressed: () {
        _qrBarCodeScannerDialogPlugin.getScannedQrBarCode(
            context: context,
            onCode: (code) {
              if (code case final code?) {
                widget.onCode(code);
              }
              setState(() {
                this.code = code;
              });
            });
      },
      title: code ?? "Scanna",
    );
  }
}

class QrScannerToggle extends StatefulWidget {
  final Function(String code) onCode;
  const QrScannerToggle({super.key, required this.onCode});

  @override
  State<QrScannerToggle> createState() => _QrScannerToggleState();
}

class _QrScannerToggleState extends State<QrScannerToggle> {
  bool isOn = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        QrScanner(onCode: widget.onCode),
      ],
    );
  }
}

Uint8List convertYuv420(CameraImage image) {
  final int width = image.width;
  final int height = image.height;

  final int ySize = width * height;
  final int uvSize = ySize ~/ 2;

  final Uint8List nv21 = Uint8List(ySize + uvSize);

  // Y plane
  nv21.setRange(0, ySize, image.planes[0].bytes);

  final bytesPerPixel = image.planes[1].bytesPerPixel!;
  final bytesPerRow = image.planes[1].bytesPerRow;

  // U and V planes interleaved
  int index = ySize;
  for (int j = 0; j < height ~/ 2; j++) {
    for (int i = 0; i < width ~/ 2; i++) {
      final int uvIndex = j * bytesPerRow + i * bytesPerPixel;
      nv21[index++] = image.planes[2].bytes[uvIndex]; // V
      nv21[index++] = image.planes[1].bytes[uvIndex]; // U
    }
  }

  return nv21;
}

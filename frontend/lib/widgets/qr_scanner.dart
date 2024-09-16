import 'dart:io';

import 'package:bankopol/constants/colors.dart';
import 'package:bankopol/scanner/ocr_camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';

class QrScanner extends StatefulWidget {
  final Function(String code) onCode;

  const QrScanner({super.key, required this.onCode});

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  late final QrBarCodeScannerDialog _qrBarCodeScannerDialogPlugin;

  @override
  void initState() {
    if (kIsWeb) _qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: primaryColor,
      child: Icon(
        Icons.qr_code_scanner,
        color: Colors.white.withOpacity(0.9),
      ),
      onPressed: () async {
        if (kDebugMode && Platform.isMacOS) {
          final result = await showDialog<String>(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Material(
                  child: TextField(
                    onSubmitted: (value) {
                      Navigator.of(context).pop(value);
                    },
                  ),
                ),
              );
            },
          );
          if (result != null) {
            widget.onCode(result);
          }
          return;
        }

        if (kIsWeb) {
          _qrBarCodeScannerDialogPlugin.getScannedQrBarCode(
            context: context,
            onCode: (code) {
              if (code case final code?) {
                widget.onCode(code);
              }
            },
          );
        } else {
          final result = await showDialog<String>(
            context: context,
            builder: (context) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: UnconstrainedBox(
                        constrainedAxis: Axis.horizontal,
                        clipBehavior: Clip.antiAlias,
                        child: OcrCamera(
                          key: const ValueKey("ocr_camera"),
                          onSuccessScanned: (result) {
                            Navigator.of(context).pop(result);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
          if (result != null) {
            widget.onCode(result);
          }
        }
      },
    );
  }
}

import 'package:bankopol/scanner/ocr_camera.dart';
import 'package:bankopol/widgets/action_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';

class QrScannerWeb extends StatefulWidget {
  final Function(String code) onCode;

  const QrScannerWeb({super.key, required this.onCode});

  @override
  State<QrScannerWeb> createState() => _QrScannerWebState();
}

class _QrScannerWebState extends State<QrScannerWeb> {
  final _qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();
  String? code;

  @override
  Widget build(BuildContext context) {
    return ActionButton(
      onPressed: () {
        if (kIsWeb || true) {
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
        } else {
          showDialog(
              context: context,
              builder: (context) {
                return OcrCamera(
                  onSuccessScanned: (result) {
                    final code = result;
                    widget.onCode(code);
                    setState(() {
                      this.code = code;
                    });
                  },
                );
              });
        }
      },
      title: code ?? "Skanna",
    );
  }
}

class QrScannerMobile extends StatelessWidget {
  const QrScannerMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class QrScannerToggle extends StatelessWidget {
  final Function(String code) onCode;

  const QrScannerToggle({super.key, required this.onCode});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        QrScannerWeb(onCode: onCode),
      ],
    );
  }
}

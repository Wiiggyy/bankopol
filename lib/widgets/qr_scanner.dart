import 'package:bankopol/widgets/action_button.dart';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        QrScanner(onCode: widget.onCode),
      ],
    );
  }
}

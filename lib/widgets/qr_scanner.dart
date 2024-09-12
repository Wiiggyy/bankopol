import 'package:bankopol/constants/colors.dart';
import 'package:bankopol/scanner/ocr_camera.dart';
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
  late final QrBarCodeScannerDialog _qrBarCodeScannerDialogPlugin;

  @override
  void initState() {
    if (kIsWeb) _qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: primaryGreen,
      child: Icon(
        Icons.qr_code_scanner,
        color: Colors.white.withOpacity(0.9),
      ),
      onPressed: () {
        if (kIsWeb) {
          _qrBarCodeScannerDialogPlugin.getScannedQrBarCode(
              context: context,
              onCode: (code) {
                if (code case final code?) {
                  widget.onCode(code);
                }
              });
        } else {
          showDialog(
              context: context,
              builder: (context) {
                return Expanded(
                  child: Center(
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
                                Navigator.of(context).pop();
                                widget.onCode(result);
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              });
        }
      },
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

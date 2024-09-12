import 'dart:async';

import 'package:bankopol/scanner/data/scan_image_data.dart';
import 'package:bankopol/scanner/data/screen.dart';
import 'package:bankopol/scanner/platform/scanner.dart';
import 'package:camera/camera.dart';

class OcrScanner {
  final subject = StreamController<String>();
  final CameraController cameraController;
  Screen? lastScreenData;
  int? lastImageHeight;
  int? lastImageWidth;
  final int rotation;

  OcrScanner(
    this.cameraController, {
    required this.rotation,
  });

  Future<bool> init() {
    return Scanner.instance.init();
  }

  Stream<String> analyze() {
    var isProcessing = false;
    cameraController.startImageStream((image) async {
      if (isProcessing) return;
      isProcessing = true;

      var screenData = lastScreenData;
      if (screenData == null ||
          image.height != lastImageHeight ||
          image.width != lastImageWidth) {
        screenData = Screen(imageWidth: image.width, imageHeight: image.height);
      }

      try {
        final result = await Scanner.instance.scan(
          ScanImageData(
            image: image,
            rotation: rotation,
            cutouts: [screenData.qrCutout],
          ),
        );
        if (!subject.isClosed && result != null) subject.add(result);
      } catch (_) {
        rethrow;
      } finally {
        isProcessing = false;
      }
    });

    return subject.stream;
  }

  void dispose() {
    subject.close();
    Scanner.instance.dispose();
  }
}

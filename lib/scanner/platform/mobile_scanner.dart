import 'dart:typed_data';

import 'package:bankopol/scanner/data/safe_int_rect.dart';
import 'package:bankopol/scanner/data/scan_image_data.dart';
import 'package:bankopol/scanner/image_handler/image_handler.dart';
import 'package:bankopol/scanner/platform/scanner.dart';
import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

class MobileScanner extends Scanner {
  BarcodeScanner? barcodeScanner;

  @override
  Future<bool> init() async {
    try {
      barcodeScanner = BarcodeScanner(formats: [BarcodeFormat.qrCode]);
    } on Exception catch (e) {
      debugPrint(e.toString());
      dispose();
      return false;
    }

    return true;
  }

  @override
  void dispose() {
    barcodeScanner?.close();
    barcodeScanner = null;
  }

  @override
  Future<String?> scan(ScanImageData imageInfo) async {
    final Stream<(SafeIntRect, Uint8List)> cropStream;
    cropStream = ImageHandler.cropAll(
      imageInfo.image,
      imageInfo.rotation,
      imageInfo.cutouts,
    );

    final [qrImage, ocrImage, ...] = [
      await for (final (cutout, imageBytes) in cropStream)
        InputImage.fromBytes(
          bytes: imageBytes,
          metadata: InputImageMetadata(
            size: cutout.size,
            // Only on Android
            rotation: imageInfo.inputRotation,
            // Only on iOS
            format: InputImageFormat.bgra8888,
            // Only on iOS - *4 = BGRA
            bytesPerRow: cutout.width * 4,
          ),
        ),
    ];

    return await _scanQrCode(qrImage);
  }

  Future<String?> _scanQrCode(InputImage inputImage) {
    return barcodeScanner?.processImage(inputImage).then(
          (value) {
            return value.firstOrNull?.rawValue;
          },
        ) ??
        Future.value();
  }
}

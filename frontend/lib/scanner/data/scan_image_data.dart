import 'dart:ui';

import 'package:bankopol/scanner/data/safe_int_rect.dart';
import 'package:bankopol/scanner/extensions/rect_extensions.dart';
import 'package:camera/camera.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

class ScanImageData {
  factory ScanImageData({
    required CameraImage image,
    required int rotation,
    required List<Rect> cutouts,
  }) {
    return ScanImageData._(
      image: image,
      rotation: rotation,
      cutouts: [
        for (final cutout in cutouts)
          cutout.rotateCutout(image.width, image.height, rotation).safeIntRect,
      ],
    );
  }

  ScanImageData._({
    required this.image,
    required this.rotation,
    required this.cutouts,
  });

  final CameraImage image;
  final int rotation;
  final List<SafeIntRect> cutouts;

  // Rotation is a discrete value of either 0, 90, 180 or 270
  // So we don't have to take ranges into consideration.
  late final InputImageRotation inputRotation =
      InputImageRotation.values.firstWhere((e) => e.rawValue == rotation);
}

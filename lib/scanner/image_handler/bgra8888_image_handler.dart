import 'dart:typed_data';

import 'package:bankopol/scanner/data/safe_int_rect.dart';
import 'package:bankopol/scanner/image_handler/image_handler.dart';
import 'package:camera/camera.dart';

/// The iOS image format.
///
/// It is just a byte array with one byte per color per pixel in the order:
/// [BGRA][BGRA][BGRA][BGRA]
class Bgra8888ImageHandler extends ImageHandler {
  const Bgra8888ImageHandler();

  @override
  Uint8List crop(CameraImage image, SafeIntRect cutout) {
    final cropTop = cutout.top;
    final cropLeft = cutout.left;
    final cropBottom = cutout.bottom;
    final cropRight = cutout.right;
    final cropHeight = cutout.height;
    final cropWidth = cutout.width;

    final imageBytes = image.planes.first.bytes;
    final croppedBytes = Uint8List(cropHeight * cropWidth * 4);

    var currentIndex = 0;
    for (var row = cropTop; row < cropBottom; row++) {
      for (var column = cropLeft; column < cropRight; column++) {
        final rowStartPixel = (column + row * image.width) * 4;
        croppedBytes.setRange(
          currentIndex,
          currentIndex += 4,
          imageBytes.getRange(rowStartPixel, rowStartPixel + 4),
        );
      }
    }
    return croppedBytes;
  }
}

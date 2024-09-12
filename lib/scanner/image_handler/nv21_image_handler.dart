import 'dart:typed_data';

import 'package:bankopol/scanner/data/safe_int_rect.dart';
import 'package:bankopol/scanner/image_handler/image_handler.dart';
import 'package:camera/camera.dart';

/// The Android image format, another name for NV21 is YUV420SP.
///
/// Information about how the bytes is placed in this format:
/// https://gist.github.com/Jim-Bar/3cbba684a71d1a9d468a6711a6eddbeb
class Nv21ImageHandler extends ImageHandler {
  const Nv21ImageHandler();

  @override
  Uint8List crop(CameraImage image, SafeIntRect cutout) {
    //  & ~1 = Making sure we have even pixel values as
    //  Android only supports that
    final cropTop = cutout.top & ~1;
    final cropLeft = cutout.left & ~1;
    final cropHeight = cutout.height & ~1;
    final cropWidth = cutout.width & ~1;

    final plane = image.planes.first;
    final sourceBytes = plane.bytes;
    final bytesPerRow = plane.bytesPerRow;
    final bytesPerPixel = plane.bytesPerPixel!;

    final croppedBytes = Uint8List(plane.bytes.length);

    // Frame size = amount of bytes for the Y plane
    final imageFrameSize = image.width * image.height * bytesPerPixel;
    final cropFrameSize = cropWidth * cropHeight * bytesPerPixel;
    final cropBytesPerRow = cropWidth * bytesPerPixel;

    for (var row = 0; row < cropHeight; row++) {
      for (var column = 0; column < cropWidth; column++) {
        final originalImageRow = row + cropTop;
        final originalImageColumn = column + cropLeft;

        final extractedYPos =
            (originalImageRow * bytesPerRow + originalImageColumn) *
                bytesPerPixel;
        final cropYPos = (row * cropBytesPerRow + column) * bytesPerPixel;

        // Y - grayscale pixel value
        croppedBytes.setRange(
          cropYPos,
          cropYPos + bytesPerPixel,
          sourceBytes.getRange(extractedYPos, extractedYPos + bytesPerPixel),
        );

        // Bit-shift magic that is more performant way of doing `column % 2 == 0`
        if ((column & 1) == 0) {
          final uvIndex = (bytesPerPixel * originalImageColumn) +
              bytesPerRow * (originalImageRow ~/ 2);

          final cropUvIndex =
              (bytesPerPixel * column) + cropBytesPerRow * (row ~/ 2);

          // V & U pixel values - color data
          croppedBytes.setRange(
            cropFrameSize + cropUvIndex,
            cropFrameSize + cropUvIndex + (bytesPerPixel * 2),
            sourceBytes.getRange(
              imageFrameSize + uvIndex,
              imageFrameSize + uvIndex + (bytesPerPixel * 2),
            ),
          );
        }
      }
    }

    return croppedBytes;
  }
}

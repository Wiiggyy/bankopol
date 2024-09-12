import 'dart:typed_data';

import 'package:bankopol/scanner/data/safe_int_rect.dart';
import 'package:bankopol/scanner/image_handler/image_handler.dart';
import 'package:camera/camera.dart';

class Yuv420ImageHandler extends ImageHandler {
  const Yuv420ImageHandler();

  @override
  Uint8List crop(CameraImage image, SafeIntRect cutout) {
    //  & ~1 = Making sure we have even pixel values as
    //  Android only supports that
    final startY = cutout.top & ~1;
    final startX = cutout.left & ~1;
    final endY = startY + cutout.height & ~1;
    final endX = startX + cutout.width & ~1;

    // Ensure cutout is within image bounds
    assert(startY >= 0 && startX >= 0);
    assert(endY <= image.height && endX <= image.width);

    // Image format is assumed to be YUV420 for this example
    final uvRowStride = image.planes[1].bytesPerRow;
    final uvPixelStride = image.planes[1].bytesPerPixel!;

    // Cropped image buffers
    final croppedY = Uint8List(cutout.width * cutout.height);
    final croppedU = Uint8List(cutout.width * cutout.height ~/ 4);
    final croppedV = Uint8List(cutout.width * cutout.height ~/ 4);

    var yIndex = 0;
    var uvIndex = 0;

    // Iterate through each row within the cutout region
    for (var y = startY; y < endY; y++) {
      for (var x = startX; x < endX; x++) {
        // Copy Y plane
        croppedY[yIndex++] =
            image.planes[0].bytes[y * image.planes[0].bytesPerRow + x];

        // U and V planes are subsampled (assuming 4:2:0 format)
        if (y.isEven && x.isEven) {
          final uvX = (x ~/ 2) * uvPixelStride;
          final uvY = (y ~/ 2) * uvRowStride;
          croppedU[uvIndex] = image.planes[1].bytes[uvY + uvX];
          croppedV[uvIndex++] = image.planes[2].bytes[uvY + uvX];
        }
      }
    }

    // Combine the cropped planes back into a single Uint8List (YUV420 format)
    final croppedImage =
        Uint8List(croppedY.length + croppedU.length + croppedV.length);
    croppedImage.setRange(0, croppedY.length, croppedY);
    croppedImage.setRange(
      croppedY.length,
      croppedY.length + croppedU.length,
      croppedU,
    );
    croppedImage.setRange(
      croppedY.length + croppedU.length,
      croppedImage.length,
      croppedV,
    );

    return croppedImage;
  }
}

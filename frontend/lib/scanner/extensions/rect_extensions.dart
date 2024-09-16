import 'dart:ui';

import 'package:bankopol/scanner/data/safe_int_rect.dart';

extension RectExtension on Rect {
  /// Creates a [SafeIntRect] that rounds up to the nearest whole pixel.
  ///
  /// We round up since that will yield the most correct positions for the
  /// [SafeIntRect] when it makes the values even.
  SafeIntRect get safeIntRect => SafeIntRect.fromLTRB(
        left.ceil(),
        top.ceil(),
        right.ceil(),
        bottom.ceil(),
      );

  /// Rotates the cutout around the center of the image (which is where all
  /// cutouts are expected to be anchored).
  Rect rotateCutout(num imageWidth, num imageHeight, int rotation) {
    if (rotation % 180 == 0) return this;

    final isStatic = width == height;
    return Rect.fromCenter(
      center: Offset(
        imageWidth / 2,
        imageHeight / 2,
      ),
      width: height,
      height: isStatic ? width : imageHeight - (imageWidth - width),
    );
  }
}

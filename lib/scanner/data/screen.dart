import 'dart:math';
import 'dart:ui';

import 'package:flutter/services.dart';

class Screen {
  Screen({
    required this.imageWidth,
    required this.imageHeight,
    this.scale = 1,
  });

  final num imageWidth;
  final num imageHeight;

  /// Scale used for the visual cutout on the screen to display correctly.
  final double scale;

  // region Image size independent fields
  static const _targetImageWidth = 720;
  static const _targetImageHeight = 1280;

  num get _widthMultiplier => min(imageHeight, imageWidth) / _targetImageWidth;

  num get _heightMultiplier =>
      max(imageHeight, imageWidth) / _targetImageHeight;

  // endregion Image size independent fields

  // region Sizes to use for the crops
  late final _qrSquareSide = 400 * _widthMultiplier;

  // endregion Sizes to use for the crops

  // region The crops
  late final Rect qrCutout = Rect.fromCenter(
    center: Offset(
      imageWidth / 2 * scale,
      imageHeight / 2 * scale,
    ),
    width: _qrSquareSide * scale,
    height: _qrSquareSide * scale,
  );
// endregion The crops
}

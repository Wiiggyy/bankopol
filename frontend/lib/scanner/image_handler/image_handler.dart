import 'dart:typed_data';

import 'package:bankopol/scanner/data/safe_int_rect.dart';
import 'package:bankopol/scanner/image_handler/bgra8888_image_handler.dart';
import 'package:bankopol/scanner/image_handler/nv21_image_handler.dart';
import 'package:bankopol/scanner/image_handler/yuv420_image_handler.dart';
import 'package:camera/camera.dart';
import 'package:flutter/widgets.dart';

abstract class ImageHandler {
  const ImageHandler();

  static const _nv21 = Nv21ImageHandler();
  static const _bgra8888 = Bgra8888ImageHandler();
  static const _yuv420 = Yuv420ImageHandler();

  Uint8List crop(CameraImage image, SafeIntRect cutout);

  /// Creates a cropped [Image] from the data stored in the [cameraImage].
  ///
  /// Keep in mind that his might be heavy to run, and might need to be run
  /// inside a separate isolate to not hog the UI thread.
  static Stream<(SafeIntRect, Uint8List)> cropAll(
    CameraImage cameraImage,
    int rotation,
    List<SafeIntRect> cutouts,
  ) async* {
    // First we do the fast cropping and returning the values.
    for (final cutout in cutouts) {
      yield (cutout, internalCrop(cameraImage, cutout));
    }
  }

  /// The actual function that takes the images and crops them.
  @visibleForTesting
  static Uint8List internalCrop(
    CameraImage cameraImage,
    SafeIntRect cutout,
  ) {
    return switch (cameraImage.format.group) {
      ImageFormatGroup.bgra8888 => _bgra8888.crop(cameraImage, cutout),
      ImageFormatGroup.nv21 => _nv21.crop(cameraImage, cutout),
      ImageFormatGroup.yuv420 => _yuv420.crop(cameraImage, cutout),
      final format => throw UnimplementedError(
          'Format $format not implemented.',
        ),
    };
  }
}

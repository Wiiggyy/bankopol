import 'dart:ui';

/// A class that stores a rectangle  that is safe to use for cropping of images
/// even with picky image formats such as YUV420 and it's derivatives, such
/// as NV21 (YUV420SP).
///
/// Some image formats (such as YUV420) does not work with images with odd
/// sizes. This getter takes the positions of the [Rect], makes them integers
/// and makes sure they are even.
class SafeIntRect {
  /// The offset of the left edge of this rectangle from the x axis.
  final int left;

  /// The offset of the top edge of this rectangle from the y axis.
  final int top;

  /// The offset of the right edge of this rectangle from the x axis.
  final int right;

  /// The offset of the bottom edge of this rectangle from the y axis.
  final int bottom;

  /// The distance between the left and right edges of this rectangle.
  int get width => right - left;

  /// The distance between the top and bottom edges of this rectangle.
  int get height => bottom - top;

  const SafeIntRect.fromLTRB(int left, int top, int right, int bottom)
      : left = left & ~1,
        top = top & ~1,
        right = right & ~1,
        bottom = bottom & ~1;

  Size get size => Size(width.toDouble(), height.toDouble());

  @override
  String toString() {
    return 'IntRect{left: $left, top: $top, right: $right, bottom: $bottom}';
  }
}

import 'dart:ui';

/// describe image sizes using ints
class IntSize {
  final int width;
  final int height;

  IntSize(this.width, this.height);

  IntSize.fromArray(rect)
      : width = rect[0],
        height = rect[1];

  Size get asSize => Size(width.toDouble(), height.toDouble());
}

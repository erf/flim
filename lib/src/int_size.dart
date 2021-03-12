import 'dart:ui';

/// describe image sizes using ints
class IntSize {
  final int width;
  final int height;

  IntSize({
    required this.width,
    required this.height,
  });

  IntSize.fromList(List<int> size)
      : width = size[0],
        height = size[1];

  Size get asSize => Size(width.toDouble(), height.toDouble());
}

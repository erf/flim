import 'dart:ui';

/// describe pixel bounds using ints
class IntRect {
  final int left;
  final int top;
  final int width;
  final int height;

  IntRect({
    required this.left,
    required this.top,
    required this.width,
    required this.height,
  });

  IntRect.fromList(List<dynamic> rect)
      : left = rect[0],
        top = rect[1],
        width = rect[2],
        height = rect[3];

  Rect get asRect => Rect.fromLTWH(
        left.toDouble(),
        top.toDouble(),
        width.toDouble(),
        height.toDouble(),
      );
}

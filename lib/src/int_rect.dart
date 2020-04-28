import 'dart:ui';

/// we want to describe pixel bounds in ints
class IntRect {
  final int left;
  final int top;
  final int width;
  final int height;

  IntRect(this.left, this.top, this.width, this.height);

  IntRect.fromList(List<dynamic> rect)
      : left = rect[0],
        top = rect[1],
        width = rect[2],
        height = rect[3];

  Rect get asRect =>
      Rect.fromLTWH(left.toDouble(), top.toDouble(), width.toDouble(), height.toDouble());
}

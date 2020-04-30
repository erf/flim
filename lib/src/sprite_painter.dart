import 'package:flim/flim.dart';
import 'package:flutter/rendering.dart';

import 'sprite.dart';

/// custom painter for a single sprite, used by sprite widget
class SpritePainter extends CustomPainter {
  final Sprite sprite;
  final SpriteRenderer spriteRenderer;

  SpritePainter(this.sprite) : spriteRenderer = SpriteRenderer(sprite);

  @override
  void paint(Canvas canvas, Size size) {
    spriteRenderer.render(canvas);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

import 'package:flim/flim.dart';
import 'package:flutter/rendering.dart';

import 'sprite.dart';

/// custom painter for a single sprite, used by sprite widget
class SpritePainter extends CustomPainter {
  Sprite sprite;
  SpriteRenderer spriteRenderer;

  SpritePainter(this.sprite) {
    spriteRenderer = SpriteRenderer(this.sprite);
  }

  @override
  void paint(Canvas canvas, Size size) {
    spriteRenderer.render(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

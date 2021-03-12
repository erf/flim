import 'dart:ui';

import 'package:flutter/material.dart';

import 'sprite.dart';
import 'transform2.dart';

/// render a single sprite
class SpriteRenderer {
  final Sprite sprite;
  final Paint paint = Paint();

  SpriteRenderer(this.sprite);

  void render(Canvas canvas) {
    if (sprite.color != null) {
      paint.colorFilter = ColorFilter.mode(sprite.color!, BlendMode.dstOver);
    }
    final Rect src = sprite.rect!.asRect;
    final Rect dst = Rect.fromLTWH(0, 0, src.width, src.height);
    final Transform2D transform = sprite.transform;
    canvas.save();
    canvas.translate(transform.translate.dx, transform.translate.dy);
    canvas.rotate(transform.rotation);
    canvas.scale(transform.scale);
    canvas.translate(-transform.anchor.dx, -transform.anchor.dy);
    canvas.drawImageRect(sprite.image!, src, dst, paint);
    canvas.restore();
  }
}

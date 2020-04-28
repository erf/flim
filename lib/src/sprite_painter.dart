import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';

import 'assets.dart';
import 'sprite.dart';

/// custom painter for sprites, used by sprite widget
class SpritePainter extends CustomPainter {
  Sprite sprite;
  Paint spritePaint = Paint();

  SpritePainter(this.sprite);

  @override
  void paint(Canvas canvas, Size size) {
    if (Assets.instance.imageCache.containsKey(sprite.imageRect.image)) {
      ui.Image image = Assets.instance.imageCache[sprite.imageRect.image];
      Rect src = Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble());
      Rect dst = sprite.imageRect.rect?.asRect ?? src;
      canvas.save();
      canvas.translate(sprite.transform.translate.dx, sprite.transform.translate.dy);
      canvas.rotate(sprite.transform.rotation);
      canvas.scale(sprite.transform.scale);
      //canvas.translate(-sprite.transform.anchor.dx, -sprite.transform.anchor.dy);
      canvas.translate(-image.width / 2.0, -image.height / 2.0);
      canvas.drawImageRect(image, src, dst, spritePaint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

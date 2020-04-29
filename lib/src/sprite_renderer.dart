import 'dart:ui';

import 'sprite.dart';

/// render a single sprite
class SpriteRenderer {
  Sprite sprite;
  Paint paint = Paint();

  SpriteRenderer(this.sprite);

  void render(Canvas canvas, Size size) {
    if (sprite.imageRect.color != null)
      paint.colorFilter = ColorFilter.mode(sprite.imageRect.color, BlendMode.dstOver);
    Rect src = sprite.imageRect.rect.asRect;
    Rect dst = Rect.fromLTWH(0, 0, src.width, src.height);
    canvas.save();
    canvas.translate(sprite.transform.translate.dx, sprite.transform.translate.dy);
    canvas.rotate(sprite.transform.rotation);
    canvas.scale(sprite.transform.scale);
    canvas.translate(-sprite.transform.anchor.dx, -sprite.transform.anchor.dy);
    canvas.drawImageRect(sprite.image, src, dst, paint);
    canvas.restore();
  }
}

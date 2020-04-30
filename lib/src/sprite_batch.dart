import 'dart:ui';

import 'sprite.dart';

/// render a set of sprites inside a single image atlas using Canvas.drawAtlas
class SpriteBatch {
  Image atlas;
  List<Rect> rects = [];
  List<RSTransform> transforms = [];
  List<Color> colors = [];

  static const defaultBlendMode = BlendMode.srcOver;
  static const defaultCullRect = null;
  static final defaultPaint = Paint();
  static final defaultTransform = RSTransform(1, 0, 0, 0);
  static const defaultColor = const Color(0x00000000); // transparent

  SpriteBatch(this.atlas);

  void add(Sprite sprite) {
    final transform = RSTransform.fromComponents(
      scale: sprite.transform.scale,
      anchorX: sprite.transform.anchor.dx,
      anchorY: sprite.transform.anchor.dy,
      rotation: sprite.transform.rotation,
      translateX: sprite.transform.translate.dx,
      translateY: sprite.transform.translate.dy,
    );
    rects.add(sprite.imageRect.rect.asRect);
    transforms.add(transform ?? defaultTransform);
    colors.add(sprite.imageRect.color ?? defaultColor);
  }

  void clear() {
    rects.clear();
    transforms.clear();
    colors.clear();
  }

  void render(
    Canvas canvas,
    Size size, {
    BlendMode blendMode,
    Rect cullRect,
    Paint paint,
  }) {
    canvas.drawAtlas(
      atlas,
      transforms,
      rects,
      colors,
      blendMode ?? defaultBlendMode,
      cullRect ?? defaultCullRect,
      paint ?? defaultPaint,
    );
  }
}

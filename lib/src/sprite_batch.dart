import 'dart:ui';

import 'sprite.dart';

/// render a set of sprites inside a single image atlas using Canvas.drawAtlas
class SpriteBatch {
  final Image atlas;
  final List<Rect> rects = [];
  final List<RSTransform> transforms = [];
  final List<Color> colors = [];

  static const defaultBlendMode = BlendMode.srcOver;
  static const dynamic defaultCullRect = null;
  static final defaultPaint = Paint();
  static const defaultColor = const Color(0x00000000); // transparent

  SpriteBatch(this.atlas);

  void add(Sprite sprite) {
    rects.add(sprite.rect!.asRect);
    transforms.add(sprite.transform.asRsTransform);
    colors.add(sprite.color ?? defaultColor);
  }

  void clear() {
    rects.clear();
    transforms.clear();
    colors.clear();
  }

  void render(
    Canvas canvas, {
    BlendMode? blendMode,
    Rect? cullRect,
    Paint? paint,
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

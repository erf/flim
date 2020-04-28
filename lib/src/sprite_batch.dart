import 'dart:ui';

import 'package:flutter/foundation.dart';

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

  void addTransform({
    @required Rect rect,
    RSTransform transform,
    Color color,
  }) {
    rects.add(rect);
    transforms.add(transform ?? defaultTransform);
    colors.add(color ?? defaultColor);
  }

  void add({
    @required Rect rect,
    double scale = 1.0,
    Offset anchor = Offset.zero,
    double rotation = 0,
    Offset translate = Offset.zero,
    Color color,
  }) {
    final transform = RSTransform.fromComponents(
      scale: scale,
      anchorX: anchor.dx,
      anchorY: anchor.dy,
      rotation: rotation,
      translateX: translate.dx,
      translateY: translate.dy,
    );
    addTransform(rect: rect, transform: transform, color: color);
  }

  void addSprite(Sprite sprite) {
    final transform = RSTransform.fromComponents(
      scale: sprite.transform.scale,
      anchorX: sprite.transform.anchor.dx,
      anchorY: sprite.transform.anchor.dy,
      rotation: sprite.transform.rotation,
      translateX: sprite.transform.translate.dx,
      translateY: sprite.transform.translate.dy,
    );
    addTransform(
      rect: sprite.imageRect.rect.asRect,
      transform: transform,
      color: sprite.imageRect.color,
    );
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

import 'dart:ui';

import 'sprite.dart';
import 'sprite_batch_renderer.dart';
import 'image_rect.dart';

/// a sprite batch per image map
class SpriteBatchMapRenderer {
  Map<String, SpriteBatchRenderer> spriteBatchMap = {};

  /// remove all items from all sprite batch maps
  void clear() {
    spriteBatchMap.forEach((asset, spriteBatch) {
      spriteBatch.clear();
    });
  }

  /// add sprite to sprite batch map with asset name as key
  void add(Sprite sprite) {
    ImageRect imageRect = sprite.imageRect;
    if (!spriteBatchMap.containsKey(imageRect.image)) {
      spriteBatchMap[imageRect.image] = SpriteBatchRenderer(sprite.image);
    }
    spriteBatchMap[imageRect.image].add(sprite);
  }

  /// render sprites effectively
  void render(Canvas canvas, Size size) {
    spriteBatchMap.forEach((asset, spriteBatch) {
      spriteBatch.render(canvas, size);
    });
  }
}

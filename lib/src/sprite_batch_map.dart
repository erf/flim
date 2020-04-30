import 'dart:ui';

import 'sprite.dart';
import 'sprite_batch.dart';

/// a sprite batch per image map
class SpriteBatchMap {
  Map<String, SpriteBatch> spriteBatchMap = {};

  /// remove all items from all sprite batch maps
  void clear() {
    spriteBatchMap.forEach((asset, spriteBatch) {
      spriteBatch.clear();
    });
  }

  /// add sprite to sprite batch map with asset name as key
  void add(Sprite sprite) {
    final String image = sprite.imageRect.image;
    spriteBatchMap.putIfAbsent(image, () => SpriteBatch(sprite.image));
    spriteBatchMap[image].add(sprite);
  }

  /// render sprites effectively
  void render(Canvas canvas, Size size) {
    spriteBatchMap.forEach((asset, spriteBatch) {
      spriteBatch.render(canvas, size);
    });
  }
}

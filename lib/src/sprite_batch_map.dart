import 'dart:ui';

import 'assets.dart';
import 'sprite_base.dart';
import 'sprite_batch.dart';
import 'image_rect.dart';

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
  void addSprite(SpriteBase sprite) {
    ImageRect imageRect = sprite.imageRect;
    if (!spriteBatchMap.containsKey(imageRect.image)) {
      spriteBatchMap[imageRect.image] = SpriteBatch(Assets.instance.imageCache[imageRect.image]);
    }
    spriteBatchMap[imageRect.image].addSprite(sprite);
  }

  /// add a list of sprites
  void addSpriteList(List<SpriteBase> sprites) {
    sprites.forEach((sprite) {
      addSprite(sprite);
    });
  }

  /// render sprites effectively
  void render(Canvas canvas, Size size) {
    spriteBatchMap.forEach((asset, spriteBatch) {
      spriteBatch.render(canvas, size);
    });
  }
}

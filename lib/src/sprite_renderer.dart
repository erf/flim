import 'dart:ui';

import 'assets.dart';
import 'sprite_base.dart';
import 'sprite_batch.dart';
import 'image_rect.dart';

/// buffer and render a set of sprites per asset image
class SpriteRenderer {
  Map<String, SpriteBatch> spriteBatches = {};

  /// remove all items from all sprite batch maps
  void clear() {
    spriteBatches.forEach((asset, spriteBatch) {
      spriteBatch.clear();
    });
  }

  /// add sprite to sprite batch map with asset name as key
  void addSprite(SpriteBase sprite) {
    ImageRect imageRect = sprite.imageRect;
    if (!spriteBatches.containsKey(imageRect.image)) {
      spriteBatches[imageRect.image] = SpriteBatch(Assets.instance.imageCache[imageRect.image]);
    }
    spriteBatches[imageRect.image].addSprite(sprite);
  }

  /// add a list of sprites
  void addSpriteList(List<SpriteBase> sprites) {
    sprites.forEach((sprite) {
      addSprite(sprite);
    });
  }

  /// render sprites effectively
  void render(Canvas canvas, Size size) {
    spriteBatches.forEach((asset, spriteBatch) {
      spriteBatch.render(canvas, size);
    });
  }
}

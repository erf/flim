import 'dart:ui';

import 'sprite.dart';
import 'sprite_batch.dart';

/// a sprite batch per image map
class SpriteBatchMap {
  final Map<String?, SpriteBatch> spriteBatchMap = {};

  /// remove all items from all sprite batch maps
  void clear() {
    spriteBatchMap.forEach((asset, batch) => batch.clear());
  }

  /// add sprite to sprite batch map with asset name as key
  void add(Sprite sprite) {
    final String? key = sprite.imagePath;
    spriteBatchMap.putIfAbsent(key, () => SpriteBatch(sprite.image));
    spriteBatchMap[key]!.add(sprite);
  }

  /// add a list of sprites
  void addAll(List<Sprite> sprites) {
    sprites.forEach((sprite) => add(sprite));
  }

  /// render sprites effectively
  void render(Canvas canvas) {
    spriteBatchMap.forEach((asset, batch) => batch.render(canvas));
  }
}

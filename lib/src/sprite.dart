import 'package:flutter/services.dart';

import 'image_rect.dart';
import 'int_rect.dart';
import 'sprite_base.dart';
import 'transform2d.dart';
import 'assets.dart';

/// an image rect with transformations
class Sprite implements SpriteBase {
  ImageRect imageRect;
  Transform2D transform;

  Sprite({this.imageRect, this.transform});

  @override
  Future<Sprite> load() async {
    await Assets.instance.preLoadSprites([this]);
    if (imageRect.rect == null) {
      final image = Assets.instance.imageCache[imageRect.image];
      imageRect.rect = IntRect(0, 0, image.width, image.height);
    }
    return this;
  }

  static Future<Sprite> loadJson(String name) async {
    final jsonSprite = await Assets.instance.loadJsonAsset(rootBundle, name);
    final spriteFromJson = await Sprite.fromJson(jsonSprite).load();
    return spriteFromJson;
  }

  factory Sprite.fromJson(Map<String, dynamic> json) {
    return Sprite(
      imageRect: ImageRect.fromJson(json['imageRect']),
      transform: Transform2D.fromJson(json['transform']),
    );
  }
}

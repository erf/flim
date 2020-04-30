import 'dart:ui' as ui;

import 'image_rect.dart';
import 'int_rect.dart';
import 'transform2.dart';
import 'asset_cache.dart';

/// an image rect with transformations
class Sprite {
  ui.Image image;
  ImageRect imageRect;
  Transform2 transform;

  Sprite({this.image, this.imageRect, this.transform});

  Future<Sprite> load() async {
    image = await ImageAssets.instance.load(imageRect.image);
    if (imageRect.rect == null) {
      imageRect.rect = IntRect(0, 0, image.width, image.height);
    }
    return this;
  }

  static Future<Sprite> loadJson(String name) async {
    final jsonSprite = await JsonAssets.instance.load(name);
    return await Sprite.fromJson(jsonSprite).load();
  }

  factory Sprite.fromJson(Map<String, dynamic> json, {String image}) {
    return Sprite(
      imageRect: ImageRect.fromJson(json['imageRect'], image: image),
      transform: Transform2.fromJson(json['transform']),
    );
  }
}

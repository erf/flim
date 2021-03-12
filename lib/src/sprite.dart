import 'dart:ui';

import 'int_rect.dart';
import 'transform2.dart';
import 'asset_cache.dart';

/// an image rect with transformations
class Sprite {
  Image image;
  String imagePath;
  IntRect rect;
  Color color = Color(0x00000000);
  Transform2D transform;

  Sprite({this.image, this.imagePath, this.rect, this.color, this.transform});

  factory Sprite.fromJson(Map<String, dynamic> json, {String imagePath}) {
    final rect = json['rect'];
    return Sprite(
      imagePath: json['imagePath'] ?? imagePath,
      rect: rect == null ? null : IntRect.fromList(rect),
      transform: Transform2D.fromJson(json['transform']),
    );
  }

  Future<Sprite> loadImage() async {
    image = await imageAssetCache.load(imagePath);
    if (rect == null) {
      rect = IntRect(0, 0, image.width, image.height);
    }
    return this;
  }

  static Future<Sprite> loadJson(String name) async {
    final jsonSprite = await jsonAssetCache.load(name);
    return await Sprite.fromJson(jsonSprite).loadImage();
  }
}

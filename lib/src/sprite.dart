import 'dart:ui';

import 'package:asset_cache/asset_cache.dart';

import 'int_rect.dart';
import 'transform2.dart';

/// an image rect with transformations
class Sprite {
  final String imagePath;
  Transform2D transform;
  Image? image;
  IntRect? rect;
  Color? color = Color(0x00000000);

  Sprite({
    required this.imagePath,
    required this.transform,
    this.image,
    this.rect,
    this.color,
  });

  /// create a [Sprite] from json and an optional [imagePath]
  factory Sprite.fromJson(Map<String, dynamic> json, {String? imagePath}) {
    final rect = json['rect'];
    return Sprite(
      imagePath: json['imagePath'] ?? imagePath,
      rect: rect == null ? null : IntRect.fromList(rect),
      transform: Transform2D.fromJson(json['transform']),
    );
  }

  /// load the [image] from [imagePath] using [imageAssetCache] and return [Sprite]
  Future<Sprite> loadImage(ImageAssetCache imageAssetCache) async {
    image = await imageAssetCache.load(imagePath);
    if (rect == null) {
      rect = IntRect(
        left: 0,
        top: 0,
        width: image!.width,
        height: image!.height,
      );
    }
    return this;
  }

  /// load [Sprite] json and image using given [jsonAssetCache] and [imageAssetCache]
  static Future<Sprite> loadJson(
    String name,
    JsonAssetCache jsonAssetCache,
    ImageAssetCache imageAssetCache,
  ) async {
    final jsonSprite = await jsonAssetCache.load(name);
    return await Sprite.fromJson(jsonSprite).loadImage(imageAssetCache);
  }
}

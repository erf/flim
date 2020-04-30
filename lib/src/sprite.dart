import 'dart:ui' as ui;

import 'package:flutter/services.dart';

import 'image_rect.dart';
import 'int_rect.dart';
import 'transform2.dart';
import 'assets.dart';

/// an image rect with transformations
class Sprite {
  ui.Image image;
  ImageRect imageRect;
  Transform2 transform;

  Sprite({this.image, this.imageRect, this.transform});

  Future<Sprite> load() async {
    image = await Assets.instance.loadImage(imageRect.image);
    if (imageRect.rect == null) {
      imageRect.rect = IntRect(0, 0, image.width, image.height);
    }
    return this;
  }

  static Future<Sprite> loadJson(String name) async {
    final jsonSprite = await Assets.instance.loadJson(rootBundle, name);
    final spriteFromJson = await Sprite.fromJson(jsonSprite).load();
    return spriteFromJson;
  }

  factory Sprite.fromJson(Map<String, dynamic> json, {String image}) {
    return Sprite(
      imageRect: ImageRect.fromJson(json['imageRect'], image: image),
      transform: Transform2.fromJson(json['transform']),
    );
  }
}

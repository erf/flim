import 'dart:math';

import 'package:flutter/painting.dart';

import 'package:flim/flim.dart';
import 'package:asset_cache/asset_cache.dart';

class MyBenchmarkGame extends Game {
  SpriteBatchMap spriteBatchMap = SpriteBatchMap();
  Size size;

  MyBenchmarkGame(this.size);

  Future<Game> initialize(ImageAssetCache imageAssetCache) async {
    var random = Random();
    List<Future<Sprite>> spriteTasks = [];
    for (int i = 0; i < 2500; i++) {
      int rx = random.nextInt(8);
      int ry = random.nextInt(8);
      double dx = random.nextInt(size.width.toInt()).toDouble();
      double dy = random.nextInt(size.height.toInt()).toDouble();
      final spriteFuture = Sprite(
        imagePath: 'boom3.png',
        rect: IntRect.fromList([128 * rx, 128 * ry, 128, 128]),
        transform: Transform2D(
          translate: Offset(dx, dy),
          scale: 1,
          anchor: Offset(64, 64),
        ),
      ).loadImage(imageAssetCache);
      spriteTasks.add(spriteFuture);
    }
    final List<Sprite> sprites = await Future.wait(spriteTasks);
    spriteBatchMap.addAll(sprites);

    return this;
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  void render(Canvas canvas) {
    spriteBatchMap.render(canvas);
  }
}

import 'dart:math';

import 'package:flutter/painting.dart';

import 'package:flim/flim.dart';

class MyBenchmarkGame extends Game {
  SpriteBatchMap spriteBatchMap = SpriteBatchMap();
  Size size;

  MyBenchmarkGame(this.size);

  @override
  Future<Game> initialize() async {
    var random = Random();
    for (int i = 0; i < 2500; i++) {
      int rx = random.nextInt(8);
      int ry = random.nextInt(8);
      double dx = random.nextInt(size.width.toInt()).toDouble();
      double dy = random.nextInt(size.height.toInt()).toDouble();
      final boom = await Sprite(
        imageRect: ImageRect(
          image: 'boom3.png',
          rect: IntRect(128 * rx, 128 * ry, 128, 128),
        ),
        transform: Transform2(
          translate: Offset(dx, dy),
          scale: 1,
          anchor: Offset(64, 64),
        ),
      ).load();
      spriteBatchMap.add(boom);
    }
    return this;
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  void paint(Canvas canvas, Size size) {
    super.paint(canvas, size);

    spriteBatchMap.render(canvas, size);
  }
}

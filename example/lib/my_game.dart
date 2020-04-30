import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

import 'package:flim/flim.dart';

import 'level.dart';

class MyGame extends Game {
  SpriteBatchMap spriteRenderer = SpriteBatchMap();
  SpriteBatchMap spriteRendererLayer1 = SpriteBatchMap();
  SpriteBatchMap spriteRendererLayer2 = SpriteBatchMap();
  SpriteBatchMap spriteRendererBenchmark = SpriteBatchMap();
  Level level;
  AnimatedSprite rogueAnimation;
  AnimatedSprite jsonAnimation;

  MyGame();

  @override
  Future<Game> initialize() async {
    // load level with sprites and animations from json file
    level = Level.fromJson(await Assets.instance.loadJson(rootBundle, 'level.json'));

    // load and cache sprite images
    await Future.wait(level.sprites.map((sprite) => sprite.load()));
    await Future.wait(level.animations.map((sprite) => sprite.load()));

    // create a uniform sprite sheet
    rogueAnimation = await AnimatedSprite.fromUniformSpriteSheet(
      'rogue.png',
      spriteSize: IntSize(100, 100),
      atlasBounds: IntRect(0, 0, 10, 1),
      frameTime: 0.08,
      transform: Transform2D(
        translate: Offset(128 * 1.0, 450),
        anchor: Offset(50, 50),
        scale: 3.0,
      ),
    ).load();

    final angel = await Sprite(
      imageRect: ImageRect(image: 'AngelBrown.PNG'),
      transform: Transform2D(translate: Offset(260, 300), scale: 3),
    ).load();

    final rogue2 = await Sprite(
      imageRect: ImageRect(image: 'rogue.png', rect: IntRect(0, 0, 100, 100)),
      transform: Transform2D(translate: Offset(155, 300), scale: 3),
    ).load();

    spriteRendererLayer1.add(angel);
    spriteRendererLayer2.add(rogue2);

    final jsonSprite = await Sprite.loadJson('sprite.json');
    spriteRendererLayer1.add(jsonSprite);

    jsonAnimation = await AnimatedSprite.loadJson('animation.json');

    //await createRandomSprites();

    return this;
  }

  createRandomSprites() async {
    var random = Random();
    for (int i = 0; i < 10000; i++) {
      int rx = random.nextInt(8);
      int ry = random.nextInt(8);
      double dx = random.nextInt(500).toDouble(); // TODO use screen width
      double dy = random.nextInt(500).toDouble(); // TODO use screen height
      final boom = await Sprite(
        imageRect: ImageRect(image: 'boom3.png', rect: IntRect(128 * rx, 128 * ry, 128, 128)),
        transform: Transform2D(translate: Offset(dx, dy), scale: 1),
      ).load();
      spriteRendererBenchmark.add(boom);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    level.animations.forEach((animation) {
      animation.update(dt);
    });
    rogueAnimation.update(dt);
    jsonAnimation.update(dt);
  }

  @override
  void paint(Canvas canvas, Size size) {
    super.paint(canvas, size);

    spriteRendererBenchmark.render(canvas, size);

    spriteRenderer.clear();
    level.sprites.forEach((sprite) {
      spriteRenderer.add(sprite);
    });
    level.animations.forEach((animation) {
      spriteRenderer.add(animation.sprite);
    });
    spriteRenderer.add(rogueAnimation.sprite);
    spriteRenderer.add(jsonAnimation.sprite);
    spriteRenderer.render(canvas, size);

    spriteRendererLayer1.render(canvas, size);
    spriteRendererLayer2.render(canvas, size);
  }
}

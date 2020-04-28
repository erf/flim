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
  AnimatedSprite rogue;
  AnimatedSprite jsonAnimatedSprite;

  MyGame();

  @override
  Future<Game> initialize() async {
    // load level with sprites and animations from json file
    final json = await Assets.instance.loadJsonAsset(rootBundle, 'level.json');
    level = Level.fromJson(json);

    // load and cache sprite images
    await Assets.instance.preLoadSprites(level.sprites);
    await Assets.instance.preLoadSprites(level.animations);

    // create a uniform sprite sheet
    rogue = await AnimatedSprite.fromUniformSpriteSheet(
      'rogue.png',
      subImageSize: IntSize(100, 100),
      numSpriteBounds: IntRect(0, 0, 10, 1),
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

    spriteRendererLayer1.addSprite(angel);
    spriteRendererLayer2.addSprite(rogue2);

    final jsonSprite = await Sprite.loadJson('sprite.json');
    spriteRendererLayer1.addSprite(jsonSprite);

    jsonAnimatedSprite = await AnimatedSprite.loadJson('animation.json');

    //await createRandomSprites();

    return this;
  }

  createRandomSprites() async {
    var random = Random();
    List<Sprite> randomSprites = [];
    for (int i = 0; i < 10000; i++) {
      int rx = random.nextInt(8);
      int ry = random.nextInt(8);
      double dx = random.nextInt(500).toDouble(); // TODO use screen width
      double dy = random.nextInt(500).toDouble(); // TODO use screen height
      final boom = Sprite(
        imageRect: ImageRect(image: 'boom3.png', rect: IntRect(128 * rx, 128 * ry, 128, 128)),
        transform: Transform2D(translate: Offset(dx, dy), scale: 1),
      );
      randomSprites.add(boom);
    }
    await Assets.instance.preLoadImages(['boom3.png']);
    spriteRendererBenchmark.addSpriteList(randomSprites);
  }

  @override
  void update(double dt) {
    super.update(dt);

    level.animations.forEach((animation) {
      animation.update(dt);
    });

    rogue.update(dt);

    jsonAnimatedSprite.update(dt);
  }

  @override
  void paint(Canvas canvas, Size size) {
    super.paint(canvas, size);

    spriteRendererBenchmark.render(canvas, size);

    spriteRenderer.clear();
    spriteRenderer.addSpriteList(level.sprites);
    spriteRenderer.addSpriteList(level.animations);
    spriteRenderer.addSprite(rogue.asSprite());
    spriteRenderer.addSprite(jsonAnimatedSprite);
    spriteRenderer.render(canvas, size);

    spriteRendererLayer1.render(canvas, size);
    spriteRendererLayer2.render(canvas, size);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'package:flim/flim.dart';

import 'level.dart';

class MyPlaygroundGame extends Game {
  SpriteBatchMap spriteRenderer = SpriteBatchMap();
  SpriteBatchMap spriteRendererLayer1 = SpriteBatchMap();
  SpriteBatchMap spriteRendererLayer2 = SpriteBatchMap();
  SpriteBatchMap spriteRendererBenchmark = SpriteBatchMap();
  Level level;
  AnimatedSprite rogueAnimation;
  AnimatedSprite jsonAnimation;

  MyPlaygroundGame();

  @override
  Future<Game> initialize() async {
    // load level with sprites and animations from json file
    level = Level.fromJson(await JsonAssets.instance.load('level.json'));

    // load and cache sprite images
    await Future.wait(level.sprites.map((sprite) => sprite.loadImage()));
    await Future.wait(level.animations.map((sprite) => sprite.loadImages()));

    // create a uniform sprite sheet
    rogueAnimation = await AnimatedSprite.fromUniformSpriteSheet(
      'rogue.png',
      spriteSize: IntSize(100, 100),
      atlasBounds: IntRect(0, 0, 10, 1),
      frameDuration: 0.08,
      transform: Transform2(
        translate: Offset(128 * 1.0, 450),
        anchor: Offset(50, 50),
        scale: 3.0,
      ),
    ).loadImages();

    final angel = await Sprite(
      imageRect: ImageRect(image: 'AngelBrown.PNG'),
      transform: Transform2(translate: Offset(260, 300), scale: 3),
    ).loadImage();

    final rogue2 = await Sprite(
      imageRect: ImageRect(image: 'rogue.png', rect: IntRect(0, 0, 100, 100)),
      transform: Transform2(translate: Offset(155, 300), scale: 3),
    ).loadImage();

    spriteRendererLayer1.add(angel);
    spriteRendererLayer2.add(rogue2);

    final jsonSprite = await Sprite.loadJson('sprite.json');
    spriteRendererLayer1.add(jsonSprite);

    jsonAnimation = await AnimatedSprite.loadJson('animation.json');

    return this;
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
  void render(Canvas canvas) {
    spriteRendererBenchmark.render(canvas);

    spriteRenderer.clear();

    spriteRenderer.addAll(level.sprites);
    spriteRenderer.addAll(level.animations.map((e) => e.sprite).toList());

    spriteRenderer.add(rogueAnimation.sprite);
    spriteRenderer.add(jsonAnimation.sprite);

    spriteRenderer.render(canvas);

    spriteRendererLayer1.render(canvas);
    spriteRendererLayer2.render(canvas);
  }
}

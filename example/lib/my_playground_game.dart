import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'package:flim/flim.dart';
import 'package:asset_cache/asset_cache.dart';

import 'level.dart';

class MyPlaygroundGame extends Game {
  SpriteBatchMap spriteRenderer = SpriteBatchMap();
  SpriteBatchMap spriteRendererLayer1 = SpriteBatchMap();
  SpriteBatchMap spriteRendererLayer2 = SpriteBatchMap();
  Level level;
  AnimatedSprite rogueAnimation;
  AnimatedSprite jsonAnimation;

  MyPlaygroundGame();

  Future<Game> initialize(
    ImageAssetCache imageAssetCache,
    JsonAssetCache jsonAssetCache,
  ) async {
    // load level with sprites and animations from json file
    level = Level.fromJson(await jsonAssetCache.load('level.json'));

    // load and cache sprite images
    await Future.wait(
        level.sprites.map((sprite) => sprite.loadImage(imageAssetCache)));
    await Future.wait(
        level.animations.map((sprite) => sprite.loadImages(imageAssetCache)));

    // create a uniform sprite sheet
    rogueAnimation = await AnimatedSprite.fromUniformSpriteSheet(
      imagePath: 'rogue.png',
      spriteSize: IntSize(100, 100),
      atlasBounds: IntRect(0, 0, 10, 1),
      frameDuration: 0.08,
      transform: Transform2D(
        translate: Offset(128 * 1.0, 450),
        anchor: Offset(50, 50),
        scale: 3.0,
      ),
    ).loadImages(imageAssetCache);

    final angel = await Sprite(
      imagePath: 'AngelBrown.PNG',
      transform: Transform2D(translate: Offset(260, 300), scale: 3),
    ).loadImage(imageAssetCache);

    final rogue2 = await Sprite(
      imagePath: 'rogue.png',
      rect: IntRect(0, 0, 100, 100),
      transform: Transform2D(translate: Offset(155, 300), scale: 3),
    ).loadImage(imageAssetCache);

    spriteRendererLayer1.add(angel);
    spriteRendererLayer2.add(rogue2);

    final jsonSprite =
        await Sprite.loadJson('sprite.json', jsonAssetCache, imageAssetCache);
    spriteRendererLayer1.add(jsonSprite);

    jsonAnimation = await AnimatedSprite.loadJson(
        'animation.json', jsonAssetCache, imageAssetCache);

    return this;
  }

  @override
  void update(double dt) {
    super.update(dt);

    level.animations.forEach((animation) => animation.update(dt));
    rogueAnimation.update(dt);
    jsonAnimation.update(dt);
  }

  @override
  void render(Canvas canvas) {
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

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

import 'package:flim/flim.dart';
import 'package:asset_cache/asset_cache.dart';

class MyKeyboardGame extends Game {
  SpriteBatchMap spriteBatchMap = SpriteBatchMap();
  Sprite playerSprite;
  AnimatedSprite playerFireAnimation;
  AnimatedSprite boomAnimation;
  Offset vel = Offset(0, 0);
  Map<String, bool> keysPressed = {};
  bool fire = false;
  Size size;
  Random random = Random();

  MyKeyboardGame(this.size);

  Future<Game> initialize(ImageAssetCache imageAssetCache) async {
    playerSprite = await Sprite(
      imagePath: 'rogue.png',
      rect: IntRect(0, 0, 100, 100),
      transform: Transform2D(
        anchor: Offset(50, 50),
        scale: 3,
        translate: Offset(size.width / 2.0, size.height / 2.0),
      ),
    ).loadImage(imageAssetCache);

    playerFireAnimation = await AnimatedSprite.fromUniformSpriteSheet(
      imagePath: 'rogue.png',
      spriteSize: IntSize(100, 100),
      atlasBounds: IntRect(0, 0, 10, 1),
      frameDuration: 0.08,
      color: Colors.yellow,
      transform: Transform2D(
        anchor: Offset(50, 50),
        scale: 3.0,
      ),
    ).loadImages(imageAssetCache);

    boomAnimation = await AnimatedSprite.fromUniformSpriteSheet(
      imagePath: 'boom3.png',
      spriteSize: IntSize(128, 128),
      atlasBounds: IntRect(0, 0, 8, 8),
      frameDuration: 0.02,
      transform: Transform2D(
        anchor: Offset(64, 64),
      ),
    ).loadImages(imageAssetCache);

    return this;
  }

  bool isPressed(String key, Map<String, bool> keysPressed) {
    return keysPressed.containsKey(key) ? keysPressed[key] : false;
  }

  void onKey(RawKeyEvent rawKeyEvent) {
    //debugPrint(rawKeyEvent.logicalKey.keyLabel);
    //debugPrint(rawKeyEvent.runtimeType.toString());
    keysPressed[rawKeyEvent.logicalKey.keyLabel] =
        rawKeyEvent is RawKeyDownEvent;
    //debugPrint(keysPressed.toString());
  }

  Offset dir;

  void handleKeyboard(Map<String, bool> keysPressed) {
    dir = Offset(0, 0);
    if (isPressed('h', keysPressed)) {
      dir += Offset(-1, 0);
    }
    if (isPressed('l', keysPressed)) {
      dir += Offset(1, 0);
    }
    if (isPressed('j', keysPressed)) {
      dir += Offset(0, 1);
    }
    if (isPressed('k', keysPressed)) {
      dir += Offset(0, -1);
    }

    bool fPressed = isPressed('f', keysPressed);
    if (fPressed && !fire) {
      double dx = random.nextInt(size.width.toInt()).toDouble();
      double dy = random.nextInt(size.height.toInt()).toDouble();
      boomAnimation.transform.translate = Offset(dx, dy);
      boomAnimation.reset();
    }
    fire = fPressed;

    if (dir != Offset.zero) {
      vel = (dir / dir.distance) * 300.0;
    }
  }

  void updatePlayer(double dt) {
    playerSprite.transform.translate += vel * dt;
    vel *= 0.95;
    spriteBatchMap.clear();
    if (fire) {
      playerFireAnimation.transform.translate =
          playerSprite.transform.translate;
      playerFireAnimation.update(dt);
      spriteBatchMap.add(playerFireAnimation.sprite);

      boomAnimation.update(dt);
      spriteBatchMap.add(boomAnimation.sprite);
    } else {
      spriteBatchMap.add(playerSprite);
    }
  }

  @override
  void update(double dt) {
    if (playerSprite == null) return;
    handleKeyboard(keysPressed);
    updatePlayer(dt);
  }

  @override
  void render(Canvas canvas) {
    spriteBatchMap.render(canvas);
  }
}

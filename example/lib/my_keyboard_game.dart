import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'package:flim/flim.dart';
import 'package:flutter/services.dart';

class MyKeyboardGame extends Game {
  SpriteBatchMap spriteBatchMap = SpriteBatchMap();
  Sprite playerSprite;
  AnimatedSprite playerFireAnimation;
  AnimatedSprite boomAnimation;
  Offset vel = Offset(0, 0);
  Map<String, bool> keysPressed = {};
  bool fire = false;

  MyKeyboardGame();

  @override
  Future<Game> initialize() async {
    playerSprite = await Sprite(
      imageRect: ImageRect(
        image: 'rogue.png',
        rect: IntRect(0, 0, 100, 100),
        color: Colors.yellow,
      ),
      transform: Transform2(
        anchor: Offset(50, 50),
        scale: 3,
        translate: Offset(100, 100),
      ),
    ).load();

    playerFireAnimation = await AnimatedSprite.fromUniformSpriteSheet(
      'rogue.png',
      spriteSize: IntSize(100, 100),
      atlasBounds: IntRect(0, 0, 10, 1),
      frameDuration: 0.08,
      color: Colors.redAccent,
      transform: Transform2(
        anchor: Offset(50, 50),
        scale: 3.0,
      ),
    ).load();

    boomAnimation = await AnimatedSprite.fromUniformSpriteSheet(
      'boom3.png',
      spriteSize: IntSize(128, 128),
      atlasBounds: IntRect(0, 0, 8, 8),
      frameDuration: 0.03,
      transform: Transform2(
        anchor: Offset(64, 64),
      ),
    ).load();

    return this;
  }

  bool isPressed(String key, Map<String, bool> keysPressed) {
    return keysPressed.containsKey(key) ? keysPressed[key] : false;
  }

  void onKey(RawKeyEvent rawKeyEvent) {
    //debugPrint(rawKeyEvent.logicalKey.keyLabel);
    //debugPrint(rawKeyEvent.runtimeType.toString());
    keysPressed[rawKeyEvent.logicalKey.keyLabel] = rawKeyEvent is RawKeyDownEvent;
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
    fire = isPressed('f', keysPressed);

    if (dir != Offset.zero) {
      vel = (dir / dir.distance) * 300.0;
    }
  }

  void updatePlayer(double dt) {
    playerSprite.transform.translate += vel * dt;
    vel *= 0.95;
    spriteBatchMap.clear();
    if (fire) {
      playerFireAnimation.transform.translate = playerSprite.transform.translate;
      playerFireAnimation.update(dt);
      spriteBatchMap.add(playerFireAnimation.sprite);

      boomAnimation.transform.translate = playerSprite.transform.translate;
      boomAnimation.transform.translate += dir * 100.0 + Offset(0, -32);
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
  void paint(Canvas canvas, Size size) {
    spriteBatchMap.render(canvas, size);
  }
}

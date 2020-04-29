import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'package:flim/flim.dart';
import 'package:flutter/services.dart';

class MyKeyboardGame extends Game {
  SpriteBatchMapRenderer spriteRenderer = SpriteBatchMapRenderer();
  Sprite rogue;
  Offset vel = Offset(0, 0);
  Map<String, bool> keysPressed = {};

  MyKeyboardGame();

  @override
  Future<Game> initialize() async {
    rogue = await Sprite(
      imageRect: ImageRect(
        image: 'rogue.png',
        rect: IntRect(0, 0, 100, 100),
        color: Colors.yellow,
      ),
      transform: Transform2D(
        translate: Offset(50 * 3.0, 50 * 3.0),
        scale: 3,
        anchor: Offset(50, 50),
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

  void handleKeyboard(Map<String, bool> keysPressed) {
    Offset dir = Offset(0, 0);
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
    if (dir != Offset.zero) {
      vel = (dir / dir.distance) * 300.0;
    }
  }

  @override
  void update(double dt) {
    if (rogue == null) {
      return;
    }
    handleKeyboard(keysPressed);
    rogue.transform.translate += vel * dt;
    vel *= 0.95;
    spriteRenderer.clear();
    spriteRenderer.add(rogue);
  }

  @override
  void paint(Canvas canvas, Size size) {
    super.paint(canvas, size);

    spriteRenderer.render(canvas, size);
  }
}

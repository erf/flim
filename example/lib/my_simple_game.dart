import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

import 'package:flim/flim.dart';

class MySimpleGame extends Game {
  SpriteBatchMap spriteRenderer = SpriteBatchMap();

  MySimpleGame();

  @override
  Future<Game> initialize() async {
    final rogue = await Sprite(
      imageRect: ImageRect(
        image: 'rogue.png',
        rect: IntRect(0, 0, 100, 100),
      ),
      transform: Transform2D(
        translate: Offset(64, 64),
        scale: 1,
        anchor: Offset(50, 50)
      ),
    ).load();

    spriteRenderer.add(rogue);

    return this;
  }

  @override
  void update(double dt) {
    super.update(dt);
  }

  @override
  void paint(Canvas canvas, Size size) {
    super.paint(canvas, size);

    spriteRenderer.render(canvas, size);
  }
}

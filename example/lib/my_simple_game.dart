import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'package:flim/flim.dart';

class MySimpleGame extends Game {
  SpriteBatchMap spriteBatchMap = SpriteBatchMap();

  @override
  Future<Game> initialize() async {
    final rogue = await Sprite(
      imageRect: ImageRect(
        image: 'rogue.png',
        rect: IntRect(0, 0, 100, 100),
      ),
      transform: Transform2(
        translate: Offset(100, 100),
        scale: 3,
        anchor: Offset(50, 50),
      ),
    ).load();

    spriteBatchMap.add(rogue);

    return this;
  }

  void lifecycleStateChange(AppLifecycleState state) {
    debugPrint('lifeCycleStateChange' + state.toString());
  }

  void resize(Size size) {
    debugPrint('resize' + size.toString());
  }

  @override
  void paint(Canvas canvas, Size size) {
    super.paint(canvas, size);

    spriteBatchMap.render(canvas, size);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'package:flim/flim.dart';
import 'package:asset_cache/asset_cache.dart';

class MySimpleGame extends Game {
  SpriteBatchMap spriteBatchMap = SpriteBatchMap();

  Future<Game> initialize(ImageAssetCache imageAssetCache) async {
    final rogue = await Sprite(
      imagePath: 'rogue.png',
      rect: IntRect.fromList([0, 0, 100, 100]),
      transform: Transform2D(
        translate: Offset(100, 100),
        scale: 3,
        anchor: Offset(50, 50),
      ),
    ).loadImage(imageAssetCache);

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
  void render(Canvas canvas) {
    spriteBatchMap.render(canvas);
  }
}

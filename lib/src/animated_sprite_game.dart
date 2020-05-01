import 'dart:ui';

import 'package:flutter/painting.dart';

import 'animated_sprite.dart';
import 'game.dart';
import 'sprite_batch_map.dart';

/// A Game which updates and renders an AnimatedSprite, used by a GameWidget
class AnimatedSpriteGame extends Game {
  AnimatedSprite animatedSprite;
  SpriteBatchMap spriteBatchMap = SpriteBatchMap();

  AnimatedSpriteGame(this.animatedSprite);

  @override
  Future<AnimatedSpriteGame> initialize() async {
    await animatedSprite.loadImages();
    return this;
  }

  void update(double dt) {
    animatedSprite.update(dt);
    spriteBatchMap.clear();
    spriteBatchMap.add(animatedSprite.sprite);
  }

  void render(Canvas canvas) {
    spriteBatchMap.render(canvas);
  }
}

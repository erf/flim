import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'animated_sprite.dart';
import 'game_loop.dart';
import 'sprite_batch.dart';
import 'assets.dart';

class AnimatedSpriteRenderBox extends RenderBox with WidgetsBindingObserver {
  AnimatedSprite animatedSprite;
  SpriteBatch spriteBatch;
  Paint spritePaint = Paint();
  GameLoop gameLoop;

  AnimatedSpriteRenderBox(this.animatedSprite) {
    gameLoop = GameLoop(gameLoopCallback);
    ui.Image image = Assets.instance.imageCache[this.animatedSprite.imageRect.image];
    spriteBatch = SpriteBatch(image);
  }

  @override
  bool get sizedByParent => true;

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    WidgetsBinding.instance.addObserver(this);
    gameLoop.start();
  }

  @override
  void detach() {
    gameLoop.stop();
    WidgetsBinding.instance.removeObserver(this);
    super.detach();
  }

  void gameLoopCallback(double dt) {
    if (!attached) return;
    animatedSprite.update(dt);
    spriteBatch.clear();
    spriteBatch.addSprite(this.animatedSprite);
    markNeedsPaint();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    context.canvas.save();
    context.canvas.translate(offset.dx, offset.dy);
    spriteBatch.render(context.canvas, size);
    context.canvas.restore();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        gameLoop.muted = false;
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        gameLoop.muted = true;
        break;
    }
  }
}

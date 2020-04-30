import 'package:flim/flim.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'animated_sprite.dart';
import 'game_loop.dart';

class AnimatedSpriteRenderBox extends RenderBox with WidgetsBindingObserver {
  AnimatedSprite animatedSprite;
  SpriteBatchMap spriteBatchMap = SpriteBatchMap();
  GameLoop gameLoop;

  AnimatedSpriteRenderBox(this.animatedSprite) {
    gameLoop = GameLoop(update);
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

  void update(double dt) {
    if (!attached) return;
    animatedSprite.update(dt);
    spriteBatchMap.clear();
    spriteBatchMap.add(animatedSprite.sprite);
    markNeedsPaint();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    context.canvas.save();
    context.canvas.translate(offset.dx, offset.dy);
    spriteBatchMap.render(context.canvas, size);
    context.canvas.restore();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {}
}

import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

import 'game.dart';
import 'game_loop.dart';

/// update and paints a game
class GameRenderBox extends RenderBox with WidgetsBindingObserver {
  Game game;
  GameLoop gameLoop;

  GameRenderBox(this.game) {
    gameLoop = GameLoop(update);
  }

  @override
  bool get sizedByParent => true;

  @override
  void performResize() {
    super.performResize();
    game.resize(constraints.biggest);
  }

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
    game.update(dt);
    markNeedsPaint();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    context.canvas.save();
    context.canvas.translate(offset.dx, offset.dy);
    game.paint(context.canvas, size);
    context.canvas.restore();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    game.lifecycleStateChange(state);
  }
}

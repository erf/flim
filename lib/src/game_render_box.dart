import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'game.dart';
import 'game_loop.dart';

/// update and paints a game
class GameRenderBox extends RenderBox with WidgetsBindingObserver {
  final Game game;
  late GameLoop gameLoop;

  GameRenderBox(this.game) {
    gameLoop = GameLoop(_onTick);
  }

  @override
  bool get sizedByParent => true;

  @override
  void performResize() {
    super.performResize();
    final Size size = constraints.biggest;
    game.resize(size);
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

  void _onTick(double dt) {
    if (!attached) return;
    game.update(dt);
    markNeedsPaint();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    context.canvas.save();
    context.canvas.translate(offset.dx, offset.dy);
    game.render(context.canvas);
    context.canvas.restore();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    game.lifecycleStateChange(state);
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return Size.zero;
  }
}

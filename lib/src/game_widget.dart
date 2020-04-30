import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'game.dart';
import 'game_render_box.dart';

/// This a widget to embed a [Game] inside the Widget tree
class GameWidget extends LeafRenderObjectWidget {
  final Game game;
  final Size size;

  GameWidget(this.game, {this.size});

  @override
  RenderBox createRenderObject(BuildContext context) {
    return RenderConstrainedBox(
      child: GameRenderBox(game),
      additionalConstraints: BoxConstraints.expand(width: size?.width, height: size?.height),
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderConstrainedBox renderBox) {
    renderBox
      ..child = GameRenderBox(game)
      ..additionalConstraints = BoxConstraints.expand(width: size?.width, height: size?.height);
  }
}

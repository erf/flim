import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'game.dart';
import 'game_render_box.dart';

/// This a widget to embed a [Game] inside the Widget tree.
///
/// It handles positioning, size constraints and other factors that arise when your game is embedded within the component tree.
/// Provided it with a [Game] instance and an optional widget size.
/// Creating this without a fixed size might mess up how other components are rendered with relation to this one in the tree.
/// You can bind Gesture Recognizers immediately around this to add controls to your widgets, with easy coordinate conversions.
class EmbeddedGameWidget extends LeafRenderObjectWidget {
  final Game game;
  final Size size;

  EmbeddedGameWidget(this.game, {this.size});

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

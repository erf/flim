import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'game_widget_embedded.dart';
import 'game.dart';

/// Encapsulates widgets for keyboard input, gestures and a EmbeddedGameWidget
class GameWidget extends StatelessWidget {
  final Game game;
  final Size size;

  GameWidget(this.game, {this.size});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return RawKeyboardListener(
          focusNode: FocusNode(),
          autofocus: true,
          onKey: (rawKeyEvent) {
            game.onKey(rawKeyEvent);
          },
          child: GestureDetector(
            onTap: () {
              game.onTap();
            },
            child: EmbeddedGameWidget(game, size: size),
          ),
        );
      },
    );
  }
}

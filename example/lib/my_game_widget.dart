import 'package:example/my_keyboard_game.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:flim/flim.dart';

/// My game widget with keyboard input
class MyGameWidget extends StatelessWidget {
  final MyKeyboardGame game;
  final Size size;

  MyGameWidget(this.game, {this.size});

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
          child: GameWidget(game, size: size),
        );
      },
    );
  }
}

import 'package:flutter/rendering.dart';

import 'game.dart';

/// paints the game
class GamePainter extends CustomPainter {
  Game game;

  GamePainter(this.game);

  @override
  void paint(Canvas canvas, Size size) {
    game.paint(canvas, size);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

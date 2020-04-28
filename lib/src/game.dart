import 'dart:ui';

import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

/// abstract base class for games
/// inherit from it to update, paint, receive input and state changes in your game
abstract class Game {
  Future<Game> initialize();

  void update(double dt) {}

  void paint(Canvas canvas, Size size) {}

  void lifecycleStateChange(AppLifecycleState state) {}

  void onKey(RawKeyEvent rawKeyEvent) {}

  void onTap() {}

  void resize(Size size) {}
}

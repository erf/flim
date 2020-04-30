import 'dart:ui';

import 'package:flutter/painting.dart';

/// Abstract base class for games
///
/// Inherit from it to update, paint, receive input and state changes in your game
abstract class Game {
  Future<Game> initialize();

  void update(double dt) {}

  void paint(Canvas canvas, Size size) {}

  void lifecycleStateChange(AppLifecycleState state) {}

  void resize(Size size) {}
}

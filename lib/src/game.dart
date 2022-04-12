import 'dart:ui';

/// Abstract base class for games
///
/// Inherit from it to update, paint, receive input and state changes in your game
abstract class Game {
  void update(double dt) {}

  void render(Canvas canvas) {}

  void lifecycleStateChange(AppLifecycleState state) {}

  void resize(Size size) {}
}

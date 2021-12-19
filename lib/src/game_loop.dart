import 'package:flutter/scheduler.dart';

/// Deliver frame updates using a [Ticker]
class GameLoop {
  final Function callback;
  Duration _previous = Duration.zero;
  late final Ticker _ticker;

  GameLoop(this.callback) {
    _ticker = Ticker(_tick);
  }

  void start() {
    if (_ticker.isActive) return;
    _ticker.start();
  }

  void stop() {
    _ticker.stop();
    _previous = Duration.zero;
  }

  bool get muted => _ticker.muted;

  set muted(bool muted) => _ticker.muted = muted;

  void _tick(Duration elapsed) {
    callback(_dt(elapsed));
  }

  double _dt(Duration elapsed) {
    Duration delta = elapsed - _previous;
    _previous = elapsed;
    return delta.inMicroseconds / Duration.microsecondsPerSecond;
  }
}

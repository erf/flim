import 'package:flutter/scheduler.dart';

/// Deliver frame updates for [GameRenderBox] using a [Ticker]
class GameLoop {
  final Function callback;
  Duration _prev = Duration.zero;
  Ticker _ticker;

  GameLoop(this.callback) {
    _ticker = Ticker(_tick);
  }

  void start() {
    _ticker.start();
  }

  void stop() {
    _ticker.stop();
    _prev = Duration.zero;
  }

  bool get muted => _ticker.muted;

  set muted(bool value) => _ticker.muted = value;

  void _tick(Duration timestamp) {
    final double dt = _calcDt(timestamp);
    callback(dt);
  }

  double _calcDt(Duration now) {
    Duration delta = now - _prev;
    if (_prev == Duration.zero) {
      delta = Duration.zero;
    }
    _prev = now;
    final double dt = delta.inMicroseconds / Duration.microsecondsPerSecond;
    return dt;
  }
}

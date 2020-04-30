import 'package:flutter/scheduler.dart';

/// Deliver frame updates using a [Ticker]
class GameLoop {
  final Function callback;
  Duration _prev = Duration.zero;
  Ticker _ticker;

  GameLoop(this.callback) {
    _ticker = Ticker(_onTick);
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

  void _onTick(Duration timestamp) {
    callback(_dt(timestamp));
  }

  double _dt(Duration now) {
    Duration delta = now - _prev;
    if (_prev == Duration.zero) {
      delta = Duration.zero;
    }
    _prev = now;
    return delta.inMicroseconds / Duration.microsecondsPerSecond;
  }
}

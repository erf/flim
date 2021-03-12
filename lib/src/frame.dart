import 'sprite.dart';

/// A single frame in an [AnimatedSprite] as a [Sprite] with a given duration [duration]
class Frame {
  final Sprite sprite;
  final double duration;

  Frame({
    required this.sprite,
    required this.duration,
  });

  factory Frame.fromJson(json, {String? imagePath}) {
    final duration = json['duration'];
    return Frame(
      sprite: Sprite.fromJson(json['sprite'], imagePath: imagePath),
      duration: duration == null ? 0.0 : (duration as num).toDouble(),
    );
  }
}

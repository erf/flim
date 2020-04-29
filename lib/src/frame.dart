import 'sprite.dart';

/// a single frame in an animation
class Frame {
  Sprite sprite;
  double time;

  Frame({this.sprite, this.time});

  factory Frame.fromJson(json, {String image}) {
    return Frame(
      sprite: Sprite.fromJson(json['sprite'], image: image),
      time: json['time'] == null ? 0.0 : (json['time'] as num).toDouble(),
    );
  }
}

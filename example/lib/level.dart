import 'package:flim/flim.dart';

class Level {
  final List<Sprite> sprites;
  final List<AnimatedSprite> animations;

  Level({
    required this.sprites,
    required this.animations,
  });

  factory Level.fromJson(Map<String, dynamic> json) {
    return Level(
      sprites: json['sprites']
          .map<Sprite>((sprite) => Sprite.fromJson(sprite))
          .toList(),
      animations: json['animations']
          .map<AnimatedSprite>(
              (animation) => AnimatedSprite.fromJson(animation))
          .toList(),
    );
  }
}

import 'package:flim/flim.dart';

class Level {
  List<Sprite> sprites;
  List<AnimatedSprite> animations;

  Level({this.sprites, this.animations});

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

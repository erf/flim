import 'package:flim/flim.dart';

class Level {
  List<Sprite> sprites;
  List<AnimatedSprite> animations;

  Level({this.sprites, this.animations});

  factory Level.fromJson(Map<String, dynamic> json) {
    return Level(
      sprites: json['sprites'].map<Sprite>((spriteJson) {
        return Sprite.fromJson(spriteJson);
      }).toList(),
      animations: json['animations'].map<AnimatedSprite>((animationJson) {
        return AnimatedSprite.fromJson(animationJson);
      }).toList(),
    );
  }
}

import 'dart:ui';

/// group transform for sprites and animated sprites
class Transform2D {
  Offset translate;
  double scale;
  double rotation;
  Offset anchor;

  Transform2D({
    this.translate = Offset.zero,
    this.scale = 1.0,
    this.rotation = 0.0,
    this.anchor = Offset.zero,
  });

  factory Transform2D.fromJson(json) {
    if (json == null) {
      return Transform2D();
    }
    final translate = json['translate'];
    final rotation = json['rotation'];
    final scale = json['scale'];
    final anchor = json['anchor'];
    return Transform2D(
      translate: translate == null
          ? Offset.zero
          : Offset(
              (translate[0] as num).toDouble(),
              (translate[1] as num).toDouble(),
            ),
      rotation: rotation == null ? 0.0 : (rotation as num).toDouble(),
      scale: scale == null ? 1.0 : (scale as num).toDouble(),
      anchor: anchor == null
          ? Offset.zero
          : Offset(
              (anchor[0] as num).toDouble(),
              (anchor[1] as num).toDouble(),
            ),
    );
  }
}

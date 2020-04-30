import 'dart:ui';

/// transforms used by sprites
class Transform2 {
  Offset translate;
  double scale;
  double rotation;
  Offset anchor;

  Transform2({
    this.translate = Offset.zero,
    this.scale = 1.0,
    this.rotation = 0.0,
    this.anchor = Offset.zero,
  });

  factory Transform2.fromJson(json) {
    if (json == null) {
      return Transform2();
    }
    final translate = json['translate'];
    final rotation = json['rotation'];
    final scale = json['scale'];
    final anchor = json['anchor'];
    return Transform2(
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

  Transform2 operator +(Transform2 arg) {
    return Transform2(
      translate: translate + arg.translate,
      rotation: rotation + arg.rotation,
      scale: scale * arg.scale,
      anchor: anchor + arg.anchor,
    );
  }

  RSTransform get asRsTransform {
    return RSTransform.fromComponents(
      scale: scale,
      anchorX: anchor.dx,
      anchorY: anchor.dy,
      rotation: rotation,
      translateX: translate.dx,
      translateY: translate.dy,
    );
  }
}

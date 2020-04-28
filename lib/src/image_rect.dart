import 'dart:ui';

import 'int_rect.dart';

/// a rect in an image, useful for sprite atlases
class ImageRect {
  String image;
  IntRect rect;
  Color color = Color(0x00000000);

  ImageRect({
    this.image,
    this.rect,
    this.color,
  });

  factory ImageRect.fromJson(json, {String image}) {
    final rect = json['rect'];
    return ImageRect(
      image: json['image'] ?? image,
      rect: rect == null ? null : IntRect.fromList(rect),
    );
  }
}

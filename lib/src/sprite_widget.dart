import 'package:flutter/widgets.dart';

import 'sprite.dart';
import 'sprite_painter.dart';

/// widget for sprites
class SpriteWidget extends StatelessWidget {
  final Sprite sprite;

  SpriteWidget(this.sprite);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SpritePainter(sprite),
    );
  }
}

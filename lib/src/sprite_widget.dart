import 'package:flutter/widgets.dart';

import 'sprite.dart';
import 'sprite_painter.dart';

/// Widget for a single sprite
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

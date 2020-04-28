import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'animated_sprite.dart';
import 'animated_sprite_render_box.dart';

class AnimatedSpriteWidget extends LeafRenderObjectWidget {
  final AnimatedSprite animatedSprite;
  final Size size;

  AnimatedSpriteWidget(this.animatedSprite, {this.size});

  @override
  RenderBox createRenderObject(BuildContext context) {
    return RenderConstrainedBox(
      child: AnimatedSpriteRenderBox(animatedSprite),
      additionalConstraints: BoxConstraints.expand(width: size?.width, height: size?.height),
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderConstrainedBox renderBox) {
    renderBox
      ..child = AnimatedSpriteRenderBox(animatedSprite)
      ..additionalConstraints = BoxConstraints.expand(width: size?.width, height: size?.height);
  }
}

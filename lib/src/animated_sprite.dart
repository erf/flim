import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'assets.dart';
import 'frame.dart';
import 'image_rect.dart';
import 'sprite.dart';
import 'int_rect.dart';
import 'int_size.dart';
import 'transform2d.dart';

/// An animated sprite - a list of [Frame]'s which changes over time
class AnimatedSprite {
  final String image;
  Transform2D transform;
  final List<Frame> frames;
  int index;
  double time;
  final double totalTime;

  AnimatedSprite({
    this.image,
    this.transform,
    this.frames = const [],
    this.index = 0,
    this.time = 0.0,
  }) : totalTime = frames.fold(0.0, (prev, frame) => prev + frame.time);

  /// getter for current frame
  Frame get currentFrame => frames[index];

  /// return the current frame + transform as a sprite
  Sprite get sprite {
    final currentSprite = currentFrame.sprite;
    final currentTransform = currentSprite.transform;
    return Sprite(
      imageRect: currentSprite.imageRect,
      transform: Transform2D(
        translate: transform.translate + currentTransform.translate,
        rotation: transform.rotation + currentTransform.rotation,
        scale: transform.scale * currentTransform.scale,
        anchor: transform.anchor + currentTransform.anchor,
      ),
    );
  }

  Future<AnimatedSprite> load() async {
    await Assets.instance.preLoadSprites(frames.map((e) => e.sprite).toList());
    return this;
  }

  static Future<AnimatedSprite> loadJson(String name) async {
    final jsonAsset = await Assets.instance.loadJsonAsset(rootBundle, name);
    final animatedSprite = await AnimatedSprite.fromJson(jsonAsset).load();
    return animatedSprite;
  }

  factory AnimatedSprite.fromJson(Map<String, dynamic> json) {
    return AnimatedSprite(
      image: json['image'],
      transform: Transform2D.fromJson(json['transform']),
      frames: json['frames'].map<Frame>((frameJson) {
        return Frame.fromJson(frameJson, image: json['image']);
      }).toList(),
      index: json['index'] == null ? 0 : json['index'] as int,
      time: json['time'] == null ? 0.0 : (json['time'] as num).toDouble(),
    );
  }

  factory AnimatedSprite.fromUniformSpriteSheet(
    String image, {
    @required IntSize spriteSize, // the size of the sub-images inside the sprite sheet
    @required IntRect atlasBounds, // the bounds of the num of sprites inside the sheet
    @required double frameTime,
    Color color = const Color(0x00000000),
    Transform2D transform,
  }) {
    List<Frame> frames = [];
    for (int row = atlasBounds.top; row < atlasBounds.height; row++) {
      for (int col = atlasBounds.left; col < atlasBounds.width; col++) {
        frames.add(
          Frame(
            sprite: Sprite(
              transform: Transform2D(),
              imageRect: ImageRect(
                image: image,
                color: color,
                rect: IntRect(
                  col * spriteSize.width,
                  row * spriteSize.height,
                  spriteSize.width,
                  spriteSize.height,
                ),
              ),
            ),
            time: frameTime,
          ),
        );
      }
    }
    return AnimatedSprite(
      frames: frames,
      transform: transform,
    );
  }

  /// find index for frame given time
  int findIndex(double time) {
    double sumTime = 0.0;
    for (int i = 0; i < frames.length; i++) {
      sumTime += frames[i].time;
      if (time < sumTime) {
        return i;
      }
    }
    return frames.length - 1;
  }

  /// update time and find new frame index
  void update(double dt) {
    time += dt;
    if (time > totalTime) {
      time = time % totalTime;
    }
    index = findIndex(time);
  }
}

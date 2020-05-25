import 'dart:ui';

import 'package:flutter/foundation.dart';

import 'asset_cache.dart';
import 'sprite.dart';
import 'int_rect.dart';
import 'int_size.dart';
import 'transform2.dart';

/// A single frame in an [AnimatedSprite] as a [Sprite] with a given duration [duration]
class Frame {
  Sprite sprite;
  double duration;

  Frame({this.sprite, this.duration});

  factory Frame.fromJson(json, {String imagePath}) {
    return Frame(
      sprite: Sprite.fromJson(json['sprite'], imagePath: imagePath),
      duration: json['duration'] == null ? 0.0 : (json['duration'] as num).toDouble(),
    );
  }
}

/// An animated sprite - a list of [Frame]'s which changes over time
class AnimatedSprite {
  /// set if all frames use same image
  final String imagePath;
  Transform2D transform;
  final List<Frame> frames;
  int index;
  double time;
  final double totalTime;

  AnimatedSprite({
    this.imagePath,
    this.transform,
    this.frames = const [],
    this.index = 0,
    this.time = 0.0,
  }) : totalTime = frames.fold(0.0, (prev, frame) => prev + frame.duration);

  /// getter for current frame
  Frame get currentFrame => frames[index];

  /// return the current frame + animation transform as a sprite
  Sprite get sprite {
    final s = currentFrame.sprite;
    return Sprite(
      image: s.image,
      imagePath: s.imagePath,
      rect: s.rect,
      transform: transform + s.transform,
    );
  }

  /// parse animation json
  factory AnimatedSprite.fromJson(Map<String, dynamic> json) {
    return AnimatedSprite(
      imagePath: json['imagePath'],
      transform: Transform2D.fromJson(json['transform']),
      frames: json['frames']
          .map<Frame>((frameJson) => Frame.fromJson(frameJson, imagePath: json['imagePath']))
          .toList(),
      index: json['index'] == null ? 0 : json['index'] as int,
      time: json['time'] == null ? 0.0 : (json['time'] as num).toDouble(),
    );
  }

  /// load all images in frames
  Future<AnimatedSprite> loadImages() async {
    await Future.wait(frames.map((frame) => frame.sprite.loadImage()));
    return this;
  }

  /// load animation from json asset and load frame images
  static Future<AnimatedSprite> loadJson(String name) async {
    final jsonAsset = await JsonAssets.instance.load(name);
    return await AnimatedSprite.fromJson(jsonAsset).loadImages();
  }

  /// find index for frame given time
  int findIndex(double time) {
    double sumTime = 0.0;
    for (int i = 0; i < frames.length; i++) {
      sumTime += frames[i].duration;
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

  /// reset time and set index to 0
  void reset() {
    time = 0.0;
    index = 0;
  }

  /// Load an animation from a uniform sprite sheet given size and bounds
  ///
  /// [image] the image name
  /// [spriteSize] the size of the sub-images inside the sprite sheet
  /// [atlasBounds] the bounds of the num of sprites inside the sheet
  /// [frameDuration] the duration per frame
  /// [color] an  optional color per frame
  /// [transform] the animation transform
  /// .. could add per-frame-transform and duration
  /// .. move outside class/file?
  factory AnimatedSprite.fromUniformSpriteSheet({
    @required String imagePath,
    @required IntSize spriteSize,
    @required IntRect atlasBounds,
    @required double frameDuration,
    Color color = const Color(0x00000000),
    Transform2D transform,
  }) {
    List<Frame> frames = [];
    for (int row = atlasBounds.top; row < atlasBounds.height; row++) {
      for (int col = atlasBounds.left; col < atlasBounds.width; col++) {
        frames.add(
          Frame(
            duration: frameDuration,
            sprite: Sprite(
              transform: Transform2D(), // TODO i dont want to set this, null should be ok
              imagePath: imagePath,
              color: color,
              rect: IntRect(
                col * spriteSize.width,
                row * spriteSize.height,
                spriteSize.width,
                spriteSize.height,
              ),
            ),
          ),
        );
      }
    }
    return AnimatedSprite(
      imagePath: imagePath,
      transform: transform,
      frames: frames,
    );
  }
}

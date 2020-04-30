import 'dart:ui';

import 'package:flutter/foundation.dart';

import 'asset_cache.dart';
import 'image_rect.dart';
import 'sprite.dart';
import 'int_rect.dart';
import 'int_size.dart';
import 'transform2.dart';

/// A single frame in an [AnimatedSprite] as a [Sprite] with a given duration [duration]
class Frame {
  Sprite sprite;
  double duration;

  Frame({this.sprite, this.duration});

  factory Frame.fromJson(json, {String image}) {
    return Frame(
      sprite: Sprite.fromJson(json['sprite'], image: image),
      duration: json['duration'] == null ? 0.0 : (json['duration'] as num).toDouble(),
    );
  }
}

/// An animated sprite - a list of [Frame]'s which changes over time
class AnimatedSprite {
  final String image; // set if all frames use same image
  Transform2 transform;
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
  }) : totalTime = frames.fold(0.0, (prev, frame) => prev + frame.duration);

  /// getter for current frame
  Frame get currentFrame => frames[index];

  /// return the current frame + animation transform as a sprite
  Sprite get sprite {
    final s = currentFrame.sprite;
    return Sprite(
      image: s.image,
      imageRect: s.imageRect,
      transform: transform + s.transform,
    );
  }

  /// load all images in frames
  Future<AnimatedSprite> load() async {
    await Future.wait(frames.map((e) => e.sprite.load()));
    return this;
  }

  /// load animation from json asset and load frame images
  static Future<AnimatedSprite> loadJson(String name) async {
    final jsonAsset = await JsonAssets.instance.load(name);
    final animatedSprite = await AnimatedSprite.fromJson(jsonAsset).load();
    return animatedSprite;
  }

  /// parse animation json
  factory AnimatedSprite.fromJson(Map<String, dynamic> json) {
    return AnimatedSprite(
      image: json['image'],
      transform: Transform2.fromJson(json['transform']),
      frames: json['frames'].map<Frame>((frameJson) {
        return Frame.fromJson(frameJson, image: json['image']);
      }).toList(),
      index: json['index'] == null ? 0 : json['index'] as int,
      time: json['time'] == null ? 0.0 : (json['time'] as num).toDouble(),
    );
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

  /// helper for loading an animation from a uniform sprite sheet given size and bounds
  /// could add a per-frame-transform and duration
  factory AnimatedSprite.fromUniformSpriteSheet(
    String image, {
    @required IntSize spriteSize, // the size of the sub-images inside the sprite sheet
    @required IntRect atlasBounds, // the bounds of the num of sprites inside the sheet
    @required double frameDuration,
    Color color = const Color(0x00000000),
    Transform2 transform,
  }) {
    List<Frame> frames = [];
    for (int row = atlasBounds.top; row < atlasBounds.height; row++) {
      for (int col = atlasBounds.left; col < atlasBounds.width; col++) {
        frames.add(
          Frame(
            duration: frameDuration,
            sprite: Sprite(
              transform: Transform2(),
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
          ),
        );
      }
    }
    return AnimatedSprite(
      transform: transform,
      frames: frames,
    );
  }
}

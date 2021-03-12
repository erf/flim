import 'dart:ui';

import 'package:asset_cache/asset_cache.dart';

import 'sprite.dart';
import 'int_rect.dart';
import 'int_size.dart';
import 'transform2.dart';

/// A single frame in an [AnimatedSprite] as a [Sprite] with a given duration [duration]
class Frame {
  Sprite? sprite;
  double? duration;

  Frame({
    this.sprite,
    this.duration,
  });

  factory Frame.fromJson(json, {String? imagePath}) {
    final duration = json['duration'];
    return Frame(
      sprite: Sprite.fromJson(json['sprite'], imagePath: imagePath),
      duration: duration == null ? 0.0 : (duration as num).toDouble(),
    );
  }
}

/// An animated sprite - a list of [Frame]'s which changes over time
class AnimatedSprite {
  /// set if all frames use same image
  final String? imagePath;
  Transform2D? transform;
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
  }) : totalTime = frames.fold(0.0, (prev, frame) => prev + frame.duration!);

  /// getter for current frame
  Frame get currentFrame => frames[index];

  /// return the current frame + animation transform as a sprite
  Sprite get sprite {
    final s = currentFrame.sprite!;
    return Sprite(
      image: s.image,
      imagePath: s.imagePath,
      rect: s.rect,
      transform: transform! + s.transform!,
    );
  }

  /// parse animation json
  factory AnimatedSprite.fromJson(Map<String, dynamic> json) {
    final index = json['index'];
    final time = json['time'];
    return AnimatedSprite(
      imagePath: json['imagePath'],
      transform: Transform2D.fromJson(json['transform']),
      frames: json['frames']
          .map<Frame>(
              (frame) => Frame.fromJson(frame, imagePath: json['imagePath']))
          .toList(),
      index: index == null ? 0 : index as int,
      time: time == null ? 0.0 : (time as num).toDouble(),
    );
  }

  /// load all images in frames
  Future<AnimatedSprite> loadImages(ImageAssetCache imageAssetCache) async {
    await Future.wait(
        frames.map((Frame frame) => frame.sprite!.loadImage(imageAssetCache)));
    return this;
  }

  /// load animation from json asset and load frame images
  static Future<AnimatedSprite> loadJson(
    String name,
    JsonAssetCache jsonAssetCache,
    ImageAssetCache imageAssetCache,
  ) async {
    final jsonAsset = await jsonAssetCache.load(name);
    return await AnimatedSprite.fromJson(jsonAsset).loadImages(imageAssetCache);
  }

  /// find index for frame given time
  int findIndex(double time) {
    double sumTime = 0.0;
    for (int i = 0; i < frames.length; i++) {
      sumTime += frames[i].duration!;
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
    required String imagePath,
    required IntSize spriteSize,
    required IntRect atlasBounds,
    required double frameDuration,
    Color color = const Color(0x00000000),
    Transform2D? transform,
  }) {
    List<Frame> frames = [];
    for (int row = atlasBounds.top; row < atlasBounds.height!; row++) {
      for (int col = atlasBounds.left; col < atlasBounds.width!; col++) {
        frames.add(
          Frame(
            duration: frameDuration,
            sprite: Sprite(
              // TODO i don't want to set this, null should be ok
              transform: Transform2D(),
              imagePath: imagePath,
              color: color,
              rect: IntRect(
                col * spriteSize.width!,
                row * spriteSize.height!,
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

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'assets.dart';
import 'image_rect.dart';
import 'sprite.dart';
import 'int_rect.dart';
import 'int_size.dart';
import 'transform2d.dart';

/// a single frame in an animation
class Frame {
  ImageRect imageRect;
  double time;

  Frame({this.imageRect, this.time});

  factory Frame.fromJson(json, {String image}) {
    return Frame(
      imageRect: ImageRect.fromJson(json['imageRect'], image: image),
      time: json['time'] == null ? 0.0 : (json['time'] as num).toDouble(),
    );
  }
}

/// an animated sprite
/// a list of frames which change over time
/// a frame has an ImageRect, same as Sprite
/// so the current frame + transform is essentially the same as a sprite
class AnimatedSprite {
  String image;
  Transform2D transform;
  List<Frame> frames;
  int index;
  double time;

  AnimatedSprite({
    this.image,
    this.transform,
    this.frames,
    this.index = 0,
    this.time = 0.0,
  });

  /// getter for current frame
  Frame get currentFrame => frames[index];

  /// image rect for current frame
  ImageRect get imageRect => currentFrame.imageRect;

  /// return the current frame + transform as a sprite
  Sprite get sprite {
    return Sprite(
      transform: transform,
      imageRect: imageRect,
    );
  }

  Future<AnimatedSprite> load() async {
    await Assets.instance.preLoadSprites([sprite]);
    return this;
  }

  static Future<AnimatedSprite> loadJson(String name) async {
    final jsonSprite = await Assets.instance.loadJsonAsset(rootBundle, name);
    final spriteFromJson = await AnimatedSprite.fromJson(jsonSprite).load();
    return spriteFromJson;
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
    @required IntSize subImageSize, // the size of the sub-images inside the sprite sheet
    @required IntRect numSpriteBounds, // the bounds of the num of sprites inside the sheet
    @required double frameTime,
    Transform2D transform,
  }) {
    List<Frame> frames = [];
    for (int row = numSpriteBounds.top; row < numSpriteBounds.height; row++) {
      for (int col = numSpriteBounds.left; col < numSpriteBounds.width; col++) {
        frames.add(
          Frame(
            imageRect: ImageRect(
              image: image,
              rect: IntRect(
                col * subImageSize.width,
                row * subImageSize.height,
                subImageSize.width,
                subImageSize.height,
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

  double get sumTime => frames.fold(0.0, (prev, frame) => prev + frame.time);

  int findIndex(double time) {
    double totalTime = 0.0;
    for (int i = 0; i < frames.length; i++) {
      totalTime += frames[i].time;
      if (time < totalTime) {
        return i;
      }
    }
    return frames.length - 1;
  }

  void update(double dt) {
    time += dt;
    double totalTime = sumTime;
    if (time > totalTime) {
      time = time % totalTime;
    }
    index = findIndex(time);
  }
}

import 'image_rect.dart';
import 'transform2d.dart';

/// interface for sprite types ( Sprite and Animated )
abstract class SpriteBase {
  /// image rect
  ImageRect get imageRect;

  /// sprite transform ( translation, scale, rotation )
  Transform2D get transform;

  /// loaded the image asset and return sprite
  Future<SpriteBase> load();
}

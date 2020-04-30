import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

/// A generic asset cache, which returns a type T. Sub-classes need to overload [_load]
abstract class GenericCache<T> {
  /// cache
  Map<String, Future<T>> _cache = {};

  /// optional base path so you don't have to type full path
  String basePath;

  /// load asset of type T
  Future<T> _load(String name);

  /// load asset and add to cache if not there
  Future<T> load(String key) => _cache.putIfAbsent(key, () => _load(key));
}

typedef AssetDecoder<T> = Future<T> Function(Uint8List);

/// A generic cache for assets, which return a type [T] given a [AssetDecoder]
class AssetCache<T> extends GenericCache<T> {
  /// decode asset bytes to type T
  AssetDecoder<T> decoder;

  /// add asset decoder in constructor
  AssetCache(this.decoder);

  /// load an asset from a bundle given a key and optional base path and
  /// decode the asset using a given decoder
  Future<T> _load(String name) async {
    final String key = basePath == null ? name : basePath + name;
    final ByteData data = await rootBundle.load(key);
    return await decoder(data.buffer.asUint8List());
  }
}

/// asset caches for images
class ImageAssets extends AssetCache<Image> {
  ImageAssets._privateConstructor() : super((data) => decodeImageFromList(data));

  static final ImageAssets instance = ImageAssets._privateConstructor();
}

/// asset caches for strings
class StringAssets extends AssetCache<String> {
  StringAssets._privateConstructor() : super((data) => Future.value(utf8.decode(data)));

  static final StringAssets instance = StringAssets._privateConstructor();
}

/// asset caches for json files
class JsonAssets extends AssetCache<Map<String, dynamic>> {
  JsonAssets._privateConstructor() : super((data) => Future.value(jsonDecode(utf8.decode(data))));

  static final JsonAssets instance = JsonAssets._privateConstructor();
}

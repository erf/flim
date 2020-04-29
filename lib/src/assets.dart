import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

/// singleton for loading and caching image assets
class Assets {
  Assets._privateConstructor();

  static final Assets instance = Assets._privateConstructor();

  /// base image path
  String imagePath;

  /// base string path
  String stringPath;

  /// base json path
  String jsonPath;

  /// image cache
  Map<String, Future<Image>> _imageCache = {};

  /// load image asset
  Future<Image> _loadImage(AssetBundle rootBundle, String name) async {
    final String key = imagePath == null ? name : imagePath + name;
    final ByteData data = await rootBundle.load(key);
    final Image image = await decodeImageFromList(data.buffer.asUint8List());
    return image;
  }

  /// load image and add to cache
  Future<Image> loadImage(String key) {
    return _imageCache.putIfAbsent(key, () => _loadImage(rootBundle, key));
  }

  Future<String> loadString(AssetBundle rootBundle, String name) async {
    final String key = stringPath == null ? name : stringPath + name;
    final String data = await rootBundle.loadString(key, cache: true);
    return data;
  }

  Future<Map<String, dynamic>> loadJson(AssetBundle rootBundle, String name) async {
    final String key = jsonPath == null ? name : jsonPath + name;
    final String data = await rootBundle.loadString(key, cache: true);
    return await jsonDecode(data);
  }
}

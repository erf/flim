import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'sprite.dart';

/// singleton for loading and caching image assets
class Assets {
  Assets._privateConstructor();

  static final Assets instance = Assets._privateConstructor();

  /// set image path once, so we don't have to write the whole path all the time
  String imagePath;

  /// set json path once, so we don't have to write the whole path all the time
  String jsonPath;

  Future<Image> loadImageAsset(AssetBundle rootBundle, String asset) async {
    final String key = imagePath == null ? asset : imagePath + asset;
    final ByteData data = await rootBundle.load(key);
    return await decodeImageFromList(data.buffer.asUint8List());
  }

  Future<String> loadStringAsset(AssetBundle rootBundle, String asset) async {
    // disabled cache in debug for testing
    bool useCache = !kDebugMode;
    final String data = await rootBundle.loadString(asset, cache: useCache);
    return data;
  }

  Future<Map<String, dynamic>> loadJsonAsset(AssetBundle rootBundle, String asset) async {
    final String key = jsonPath == null ? asset : jsonPath + asset;
    final String data = await rootBundle.loadString(key);
    return await jsonDecode(data);
  }

  Future<Image> loadImageFile(File file) async {
    final Uint8List data = await file.readAsBytes();
    return await decodeImageFromList(data.buffer.asUint8List());
  }

  Map<String, Image> imageCache = {};

  Future preLoadSprites(List<Sprite> sprites) async {
    List<String> assets = sprites.map((e) => e.imageRect.image).toList();
    return await preLoadImages(assets);
  }

  Future preLoadImages(List<String> assets) async {
    if (assets == null || assets.isEmpty) {
      return;
    }

    // remove duplicates
    List<String> unique = assets.toSet().toList();

    // remove if already in cache
    unique.removeWhere((name) => imageCache.containsKey(name));

    // remove if nothing left to add to cache
    if (unique.isEmpty) {
      return;
    }

    // image futures
    List<Future<Image>> tasks = unique.map((asset) => loadImageAsset(rootBundle, asset)).toList();

    // load images in parallel
    List<Image> images = await Future.wait(tasks);

    // add images to cache
    for (int i = 0; i < images.length; i++) {
      imageCache[unique[i]] = images[i];
      if (kDebugMode) {
        debugPrint('added ${unique[i]} to cache');
      }
    }
  }
}

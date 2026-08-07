import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HiveService {
  static const String favoritesBoxName = 'favorites_box';
  static const String recentsBoxName = 'recents_box';
  static const String settingsBoxName = 'settings_box';
  static const String capturedPhotosBoxName = 'captured_photos_box';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox<String>(favoritesBoxName);
    await Hive.openBox<String>(recentsBoxName);
    await Hive.openBox(settingsBoxName);
    await Hive.openBox<String>(capturedPhotosBoxName);
  }

  // Favorites
  Box<String> get _favBox => Hive.box<String>(favoritesBoxName);

  List<String> getFavorites() {
    return _favBox.values.toList();
  }

  bool isFavorite(String id) {
    return _favBox.containsKey(id);
  }

  Future<void> toggleFavorite(String id) async {
    if (isFavorite(id)) {
      await _favBox.delete(id);
    } else {
      await _favBox.put(id, id);
    }
  }

  // Recents
  Box<String> get _recentsBox => Hive.box<String>(recentsBoxName);

  List<String> getRecents() {
    return _recentsBox.values.toList().reversed.toList();
  }

  Future<void> addRecent(String id) async {
    // Remove duplicate if exists then append at the end
    final keys = _recentsBox.keys;
    for (var k in keys) {
      if (_recentsBox.get(k) == id) {
        await _recentsBox.delete(k);
        break;
      }
    }
    await _recentsBox.add(id);
  }

  // Captured Photos
  Box<String> get _photosBox => Hive.box<String>(capturedPhotosBoxName);

  List<String> getCapturedPhotos() {
    return _photosBox.values.toList().reversed.toList();
  }

  Future<void> addCapturedPhoto(String path) async {
    await _photosBox.add(path);
  }

  Future<void> deleteCapturedPhoto(String path) async {
    final Map<dynamic, String> map = _photosBox.toMap();
    for (var entry in map.entries) {
      if (entry.value == path) {
        await _photosBox.delete(entry.key);
        break;
      }
    }
  }

  // Settings
  Box get _settingsBox => Hive.box(settingsBoxName);

  dynamic getSetting(String key, {dynamic defaultValue}) {
    return _settingsBox.get(key, defaultValue: defaultValue);
  }

  Future<void> setSetting(String key, dynamic value) async {
    await _settingsBox.put(key, value);
  }
}

final hiveServiceProvider = Provider<HiveService>((ref) {
  return HiveService();
});

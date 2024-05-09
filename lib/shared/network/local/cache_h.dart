import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences cache;

  static init() async {
    cache = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData({
    required String key,
    required dynamic val,
  }) async {
    if (val is String) return await cache.setString(key, val);
    if (val is int) return await cache.setInt(key, val);
    if (val is bool) return await cache.setBool(key, val);
    return await cache.setDouble(key, val);
  }

  static dynamic getData({
    required String key,
  }) {
    return cache.get(key);
  }

  static Future<bool> clearData({
    required String key,
  }) async {
    return await cache.remove(key);
  }
}

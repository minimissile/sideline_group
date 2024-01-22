import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

/// 缓存管理类
class Cache {
  SharedPreferences? prefs;

  Cache._() {
    init();
  }

  static Cache? _instance;

  Cache._pre(SharedPreferences this.prefs);

  /// 预初始化，防止在使用get时，prefs还未完成初始化
  static Future<Cache> preInit() async {
    if (_instance == null) {
      var prefs = await SharedPreferences.getInstance();
      _instance = Cache._pre(prefs);
    }
    return _instance!;
  }

  static Cache getInstance() {
    _instance ??= Cache._();
    return _instance!;
  }

  void init() async {
    prefs ??= await SharedPreferences.getInstance();
  }

  setString(String key, String value) {
    prefs?.setString(key, value);
  }

  setDouble(String key, double value) {
    prefs?.setDouble(key, value);
  }

  setInt(String key, int value) {
    prefs?.setInt(key, value);
  }

  setBool(String key, bool value) {
    prefs?.setBool(key, value);
  }

  setStringList(String key, List<String> value) {
    prefs?.setStringList(key, value);
  }

  setJSON(String key, dynamic jsonVal) {
    String jsonString = jsonEncode(jsonVal);
    return prefs?.setString(key, jsonString);
  }

  remove(String key) {
    prefs?.remove(key);
  }

  getJSON(String key) {
    String? jsonString = prefs?.getString(key);
    return jsonString == null ? null : jsonDecode(jsonString);
  }

  getBool(String key) {
    bool? boolString = prefs?.getBool(key);
    return boolString;
  }

  T? get<T>(String key) {
    var result = prefs?.get(key);
    if (result != null) {
      return result as T;
    }
    return null;
  }
}

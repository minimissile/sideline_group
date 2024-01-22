import 'package:sideline_group/config/storage.dart';
import 'package:sideline_group/db/cache.dart';
import 'package:sideline_group/model/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 状态管理结合本地缓存
class UserProvider extends ChangeNotifier {
  bool _isFirstTimeLogin = true;
  bool _isLoggedIn = false;
  bool _isFirstGuide = true;

  /// 是否首次登录
  bool get isFirstTimeLogin => _isFirstTimeLogin;

  /// 是否已登录
  bool get isLoggedIn => _isLoggedIn;

  /// 是否首次进行创建角色
  bool get isFirstGuide => _isFirstGuide;

  UserModel? _userInfo;

  /// 登录的用户信息
  UserModel? get userInfo => _userInfo;

  UserProvider() {
    checkStatus();
  }

  /// 初始化时从缓存中加载数据
  Future<void> checkStatus() async {
    Cache prefs = Cache.getInstance();
    _isFirstTimeLogin = prefs.getBool('isFirstTimeLogin') ?? true;
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    _isFirstGuide = prefs.getBool('isFirstGuide') ?? true;

    var userInfoData = prefs.getJSON(Storage.userProfile);
    if (userInfoData != null) {
      _userInfo = UserModel.fromJson(userInfoData);
    }
    notifyListeners();
  }

  /// 保存登录的用户信息
  Future<void> setUserInfo(UserModel value) async {
    var prefs = Cache.getInstance();
    await prefs.setJSON(Storage.userProfile, value);
    _userInfo = value;
    notifyListeners();
  }

  /// 设置是否首次登录状态
  Future<void> setFirstTimeLogin(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTimeLogin', value);
    _isFirstTimeLogin = value;
    notifyListeners();
  }

  /// 是否首次进行创建角色
  Future<void> setFirstGuide(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstGuide', value);
    _isFirstGuide = value;
    notifyListeners();
  }

  /// 登录
  Future<void> login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    _isLoggedIn = true;
    notifyListeners();
  }

  /// 退出登录
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);
    _isLoggedIn = false;
    notifyListeners();
  }
}

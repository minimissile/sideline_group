import 'dart:io';
import 'package:sideline_group/core/cache_manager.dart';
import 'package:sideline_group/utils/logger_util.dart';
import 'package:sideline_group/utils/screen_util.dart';
import 'package:sideline_group/utils/system_util.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';

/// 全局配置
class Global {
  /// 发布渠道
  static String channel = '';

  /// 是否 ios
  static bool isIOS = Platform.isIOS;

  /// 是否是 Android
  static bool isAndroid = Platform.isAndroid;

  /// android 设备信息
  static late AndroidDeviceInfo androidDeviceInfo;

  /// ios 设备信息
  static late IosDeviceInfo iosDeviceInfo;

  /// 包信息
  static late PackageInfo packageInfo;

  /// 是否第一次打开
  static bool isFirstOpen = false;

  /// 是否离线登录
  static bool isOfflineLogin = false;

  /// tabbar高度
  static double tabbarHeight = setHeight(154);

  /// 系统语言 （zh-CN，zh-TW，en-US）
  static String systemLanguage = 'en-US';

  /// 是否 release
  static bool get isRelease => const bool.fromEnvironment("dart.vm.product");

  /// init
  static Future init() async {
    Logger.log('global开始初始化', title: 'Global');

    // 本地缓存初始化
    await CacheManager.preInit();

    // 读取设备信息
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    if (Global.isIOS) {
      Global.iosDeviceInfo = await deviceInfoPlugin.iosInfo;
    } else {
      Global.androidDeviceInfo = await deviceInfoPlugin.androidInfo;
    }

    // 包信息
    Global.packageInfo = await PackageInfo.fromPlatform();

    // 系统语言
    Global.systemLanguage = getSystemLanguage();

    Logger.log("当前系统语言：${Global.systemLanguage}", title: 'Global');
  }
}

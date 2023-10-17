import 'dart:developer' as dev;
import 'package:sideline_group/global.dart';

/// log工具
class Logger {
  /// 是否启用log, 只在调试模式下启用
  static bool _isEnable = !Global.isRelease;

  /// 是否启用调试工具
  static set isEnable(bool value) {
    _isEnable = value;
  }

  /// 自定义log
  static void log(String message, {title = 'Logger'}) {
    if (!_isEnable) {
      return;
    }
    dev.log(message, name: title);
  }
}

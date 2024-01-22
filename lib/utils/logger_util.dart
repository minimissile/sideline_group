import 'dart:convert';
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
  static void log(String message, {String title = 'Logger'}) {
    if (!_isEnable) {
      return;
    }

    dev.log(_formatMessage(message), name: title);
  }

  /// 格式化JSON字符串
  static String _formatMessage(String message) {
    try {
      // 尝试解析JSON
      var decodedJson = jsonDecode(message);
      // 使用JsonEncoder来格式化JSON
      var prettyJson = const JsonEncoder.withIndent('  ').convert(decodedJson);
      return prettyJson;
    } catch (_) {
      // 如果解析失败，返回原始消息
      return message;
    }
  }
}

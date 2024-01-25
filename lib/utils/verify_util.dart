/**
 * 数据校验相关
 */

/// 不为空
bool isNotEmpty(String? text) {
  return text?.isNotEmpty ?? false;
}

/// 为空
bool isEmpty(String? text) {
  return text?.isEmpty ?? true;
}

/// 检查邮箱格式
bool isEmail(String input) {
  if (input.isEmpty) return false;
  // 邮箱正则
  String regexEmail = "^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$";
  return RegExp(regexEmail).hasMatch(input);
}

/// 数据校验工具类
class VerifyUtil {
  /// 判断字符串是否为空
  static isEmpty(String? str) {
    if (str == null || str == "") return true;
    return false;
  }
}

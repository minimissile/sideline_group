import 'package:flutter/material.dart';

/// 应用色彩体系
class AppColor {
  /// 主要文字颜色
  static Color primaryText = const Color(0xff382c22);

  /// 次级文字颜色
  static Color secondaryTextColor = const Color(0xff606060);

  /// 禁用颜色
  static Color disableColor = const Color(0xffbdbdbd);

  /// appbar背景颜色
  static Color appbarColor = const Color(0xffddb163);

  /// 主色调
  static Color primaryColor = const Color(0xffddb163);

  /// 链接颜色
  static Color linkColor = const Color(0xff2f53f8);

  /// 重点提示颜色
  static Color hintColor = const Color(0xffff6143);
}

/// 自定义主色调
const MaterialColor customPrimaryColor = MaterialColor(
  0xFFDDB163,
  <int, Color>{
    50: Color(0xFFFFF8E1),
    100: Color(0xFFFFECB3),
    200: Color(0xFFFFE082),
    300: Color(0xFF3C3F41),
    400: Color(0xFFFFCA28),
    500: Color(0xFFDDB163), // 主色调值
    600: Color(0xFFFBC02D),
    700: Color(0xFFF9A825),
    800: Color(0xFFF57F17),
    900: Color(0xFFF57F17),
  },
);

import 'dart:ui';

/// 获取系统语言
String getSystemLanguage() {
  Locale systemLocale = window.locale;
  String languageCode = systemLocale.languageCode;
  String countryCode = systemLocale.countryCode ?? ""; // 国家代码可能为空

  // 根据需要返回语言代码和国家代码的组合
  if (countryCode.isNotEmpty) {
    return '$languageCode-$countryCode';
  } else {
    return languageCode;
  }
}

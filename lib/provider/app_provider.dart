import 'package:flutter/foundation.dart';
import 'package:sideline_group/utils/logger_util.dart';

/// App状态管理
class AppProvider extends ChangeNotifier {
  /// 清除账号数据
  void clearAccountData() {
    Logger.log('清除账号数据', title: 'AppProvider');
    notifyListeners();
  }
}

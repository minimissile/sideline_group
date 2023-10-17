import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:sideline_group/utils/logger_util.dart';

/// App状态管理
class AppProvider extends ChangeNotifier {
  String _homeBackground = "";

  bool _showItineraryDot = false;

  ConnectivityResult _internetStatus = ConnectivityResult.none;

  /// 获取网络状态
  ConnectivityResult get internetStatus => _internetStatus;

  /// 是否显示行程提示小红点
  bool get showItineraryDot => _showItineraryDot;

  /// 首页、聊天页背景装饰
  String get homeBackground => _homeBackground;

  /// 设置首页背景装饰
  void setHomeBackground(String url) {
    _homeBackground = url;
    notifyListeners();
  }

  /// 更新网络状态
  void updateInternetStatus(ConnectivityResult newStatus) {
    if (_internetStatus != newStatus) {
      _internetStatus = newStatus;
      notifyListeners();
    }
  }

  /// 设置是否显示行程提示小红点
  setShowItineraryDot(bool val) {
    Logger.log('设置是否显示行程提示小红点 $val', title: 'AppProvider');
    _showItineraryDot = val;
    notifyListeners();
  }
}

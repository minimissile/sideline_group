import 'package:sideline_group/widgets/toast/custom_toast.dart';

/// 吐司工具类
class Toast {
  static show(String msg) {
    CustomToast.showToast(msg);
  }

  /// 提示Success类型
  static showSuccess(String msg) {
    CustomToast.showSuccess(msg);
  }

  /// 提示Info类型
  static showInfo(String msg) {
    CustomToast.showInfo(msg);
  }

  /// 提示Error类型
  static showError(String msg) {
    CustomToast.showError(msg);
  }

  /// 提示Progress类型
  /// [progress] 进度 0.0 ~ 1.0
  static showProgress(String msg, double progress) {
    CustomToast.showProgress(progress, status: msg);
    if(progress == 1) {
      CustomToast.dismiss();
    }
  }
}

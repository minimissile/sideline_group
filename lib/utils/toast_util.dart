import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// 消息提示类型枚举
enum ToastType {
  /// 成功提示
  success,

  /// 错误提示
  error,

  /// 警告提示
  warning,

  /// 信息提示
  info,

  /// 加载提示
  loading,
}

class Toast {
  static const double _fontSize = 16.0;
  static const Color _textColor = Colors.white;

  static show(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black54,
      textColor: _textColor,
      fontSize: _fontSize,
    );
  }

  /// 提示错误消息
  static showError(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black54,
      textColor: _textColor,
      fontSize: _fontSize,
    );
  }
}

/// 显示横幅式提示框 (预留消息提示类型)
void showAppMaterialBanner(BuildContext context, {String title = '操作成功', ToastType type = ToastType.info}) {
  const baseColor = Colors.white;

  ScaffoldMessenger.of(context).showMaterialBanner(
    MaterialBanner(
      contentTextStyle: const TextStyle(color: baseColor),
      elevation: 5,
      backgroundColor: Colors.white12,
      padding: const EdgeInsets.all(10),
      leading: const Icon(Icons.notifications_none, color: baseColor),
      content: Text(title),
      actions: [
        TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
          },
          child: const Text('Dismiss', style: TextStyle(color: baseColor)),
        )
      ],
    ),
  );
}

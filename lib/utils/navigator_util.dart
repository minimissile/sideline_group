import 'package:flutter/material.dart';

/// 导航封装，方便后期替换
class NavigatorUtil {
  ///跳转到指定页面
  static push(BuildContext context, String routeName, {Object? arguments}) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  /// 返回上一页
  static pop(BuildContext context) {
    Navigator.pop(context);
  }

  /// 清除当前页堆栈并跳转到新的页面
  static removeAndPush(BuildContext context, String routeName) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      routeName,
      (Route<dynamic> route) => false,
    );
  }

  /// 替换当前页路由跳转到下一路由 （只清空当前页路由）
  static pushReplacement(BuildContext context, String routeName) {
    Navigator.of(context).pushReplacementNamed(
      routeName,
    );
  }

  /// 退出登录
  static logout(BuildContext context) {
    removeAndPush(context, '/login');
  }

  /// 获取当前正在展示的路由
  // 前提目标路由设置了name
  static getCurrentRoute(BuildContext context) {
    Route<dynamic>? currentRoute;

    Navigator.of(context).popUntil((route) {
      currentRoute = route;
      return true;
    });

    String routeName = "";
    if (currentRoute != null) {
      // 获取当前路由的名称
      routeName = ModalRoute.of(context)!.settings.name ?? '';
    }
    return routeName;
  }
}

/// 路由动画类型
enum TransitionType {
  /// 淡入淡出
  fade,

  /// 缩放
  scale,

  /// 旋转缩放
  rotateScale,

  /// 幻灯片
  slide,

  /// 添加无动画选项
  none,
}

/// 自定义路由动画
class CustomRoute extends PageRouteBuilder {
  final Widget widget;
  final Duration duration;
  final Curve curve;
  final TransitionType transitionType;
  final RouteSettings? customSettings;

  CustomRoute({
    required this.widget,
    this.duration = const Duration(milliseconds: 800),
    this.curve = Curves.fastOutSlowIn,
    this.transitionType = TransitionType.fade,
    this.customSettings,
  }) : super(
          transitionDuration: duration,
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return widget;
          },
          settings: customSettings,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            switch (transitionType) {
              // 淡入淡出
              case TransitionType.fade:
                return FadeTransition(
                  opacity: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: animation, curve: curve)),
                  child: child,
                );

              // 缩放
              case TransitionType.scale:
                return ScaleTransition(
                  scale: Tween(begin: 0.0, end: 1.0)
                      .animate(CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn)),
                  child: child,
                );

              // 旋转 + 比例转换路由
              case TransitionType.rotateScale:
                return RotationTransition(
                  turns: Tween(begin: -1.0, end: 1.0)
                      .animate(CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn)),
                  child: ScaleTransition(
                    scale: Tween(begin: 0.0, end: 1.0)
                        .animate(CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn)),
                    child: child,
                  ),
                );

              // 幻灯片
              case TransitionType.slide:
                return SlideTransition(
                  position: Tween<Offset>(begin: const Offset(0.0, -1.0), end: const Offset(0.0, 0.0)).animate(
                    CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn),
                  ),
                  child: child,
                );

              case TransitionType.none:
                // 无动画切换
                return child;

              default:
                return FadeTransition(
                  opacity: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: animation, curve: curve)),
                  child: child,
                );
            }
          },
        );
}

import 'package:sideline_group/navigator/tab_navigator.dart';
import 'package:sideline_group/pages/login/forget_password_page.dart';
import 'package:sideline_group/pages/login/login_page.dart';

var staticRoutes = {
  "/login": (context) => const LoginPage(), // 登录
  "/tabbar": (context) => const TabNavigator(), // Tabbar
  "/forget_password": (context) => const ForgetPasswordPage(), // 忘记密码
};
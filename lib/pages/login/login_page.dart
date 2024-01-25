import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sideline_group/config/storage.dart';
import 'package:sideline_group/db/cache.dart';
import 'package:sideline_group/model/user_model.dart';
import 'package:sideline_group/provider/user_provider.dart';
import 'package:sideline_group/utils/logger_util.dart';
import 'package:sideline_group/utils/navigator_util.dart';
import 'package:sideline_group/utils/toast_util.dart';
import 'package:sideline_group/utils/verify_util.dart';
import 'package:sideline_group/widgets/appbar_widget.dart';
import 'package:sideline_group/widgets/button_widget.dart';
import 'package:sideline_group/widgets/hide_keyboard_widget.dart';

/// 登录页
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /// 账号
  String username = '';

  /// 密码
  String password = '';

  /// 登录校验是否通过
  bool loginEnable = false;

  /// 检查登录
  void _checkInput() {
    bool enable;
    if (isNotEmpty(username) && isNotEmpty(password)) {
      enable = true;
    } else {
      enable = false;
    }
    setState(() {
      loginEnable = enable;
    });
  }

  _handleLogin() {
    UserProvider provider = context.read<UserProvider>();
    var user = provider.userInfo ?? UserModel();

    // 如果有账号
    if (user.username != null) {
      if (user.username == username) {
        user.username = username;
        user.password = password;

        provider.setUserInfo(user);
        NavigatorUtil.login(context);
      } else {
        Toast.show('账号出错');
      }
    }
  }

  /// 读取缓存账号
  void _getCacheAccounts() {
    Logger.log('开始读取缓存账号', title: 'Login');

    var user = Cache.getInstance().getJSON(Storage.userProfile);

    if (user != null) {
      setState(() {
        username = user['username'];
        password = user['password'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getCacheAccounts();
    _checkInput();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: '登录'),
      resizeToAvoidBottomInset: false,
      body: HideKeyboardWidget(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 100).copyWith(top: 200),
          child: Column(
            children: [
              TextFormField(
                initialValue: username,
                decoration: const InputDecoration(
                  hintText: '请输入账号',
                ),
                onChanged: (val) {
                  username = val;
                  _checkInput();
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: password,
                obscureText: true,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                decoration: const InputDecoration(hintText: '请输入密码'),
                onChanged: (val) {
                  password = val;
                  _checkInput();
                },
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      NavigatorUtil.push(context, '/forget_password');
                    },
                    child: const Text('忘记密码？'),
                  )
                ],
              ),
              const SizedBox(height: 40),
              Button(onPressed: _handleLogin, disable: !loginEnable, title: '登录/注册'),
            ],
          ),
        ),
      ),
    );
  }
}

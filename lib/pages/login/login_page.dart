import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sideline_group/config/storage.dart';
import 'package:sideline_group/db/cache.dart';
import 'package:sideline_group/provider/user_provider.dart';
import 'package:sideline_group/utils/logger_util.dart';
import 'package:sideline_group/utils/navigator_util.dart';
import 'package:sideline_group/widgets/button_widget.dart';

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

  _handleLogin() {
    UserProvider provider = context.read<UserProvider>();
    var user = provider.userInfo;

    user?.username = username;
    user?.password = password;

    provider.setUserInfo(user!);
    NavigatorUtil.login(context);
  }

  /// 读取缓存账号
  void _getCacheAccounts() {
    Logger.log('开始读取缓存账号', title: 'Login');

    if (username != '') return;

    var user = Cache.getInstance().getJSON(Storage.userProfile);

    if (user != null) {
      setState(() {
        username = user.account;
        password = user.password;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getCacheAccounts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('登录'),
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 100).copyWith(top: 200),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(hintText: '请输入账号'),
              onChanged: (val) {
                setState(() {
                  username = val;
                });
              },
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(hintText: '请输入密码'),
              onChanged: (val) {
                setState(() {
                  password = val;
                });
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
            Button(onPressed: _handleLogin, title: '登录/注册'),
          ],
        ),
      ),
    );
  }
}

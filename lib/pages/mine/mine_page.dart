import 'package:flutter/material.dart';
import 'package:sideline_group/utils/navigator_util.dart';
import 'package:sideline_group/widgets/appbar_widget.dart';
import 'package:sideline_group/widgets/button_widget.dart';

/// 我的
class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  void _handleLogout() {
    NavigatorUtil.logout(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: '我的',),
      body: Center(
        child: Column(
          children: [
            Button(onPressed: _handleLogout, title: '退出登录'),
          ],
        ),
      ),
    );
  }
}

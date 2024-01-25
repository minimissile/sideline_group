import 'package:flutter/material.dart';
import 'package:sideline_group/utils/navigator_util.dart';

/// 首页
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('首页'),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                NavigatorUtil.push(context, '/anti_leek_alliance');
              },
              child: const Text('反韭菜联盟'),
            ),

            TextButton(
              onPressed: () {
                NavigatorUtil.push(context, '/host_monitor');
              },
              child: const Text('主机监控'),
            ),
          ],
        ),
      ),
    );
  }
}

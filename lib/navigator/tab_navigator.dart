import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sideline_group/pages/group/group_page.dart';
import 'package:sideline_group/pages/learn/learn_page.dart';
import 'package:sideline_group/pages/mine/mine_page.dart';
import 'package:sideline_group/pages/resource/resource_page.dart';
import 'package:sideline_group/pages/home/home_page.dart';
import 'package:sideline_group/utils/toast_util.dart';

/// Tabbar
class TabNavigator extends StatefulWidget {
  final int selectedIndex;

  const TabNavigator({super.key, this.selectedIndex = 0});

  @override
  State<TabNavigator> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  late PageController pageController;

  /// 激活的tabbar下标
  int pageIndex = 1;

  /// 记录返回拦截点击时间
  int lastTime = 0;

  /// 页面切换
  void onPageChanged(int value) {
    setState(() => pageIndex = value);
  }

  /// 点击tabBar
  void onTap(int value) {
    setState(() => pageIndex = value);
    // 控制页面切换，可添加动画切换效果
    pageController.jumpToPage(value);
  }

  /// Tabbar Item
  _bottomNavigationBarItem({
    required IconData icon,
    required String title,
    required int index,
  }) {
    return BottomNavigationBarItem(
      activeIcon: Icon(icon, color: Colors.blue),
      icon: Icon(icon, color: Colors.grey),
      label: title,
    );
  }

  @override
  void initState() {
    pageController = PageController(initialPage: widget.selectedIndex);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        int newTime = DateTime.now().millisecondsSinceEpoch;
        int result = newTime - lastTime;
        lastTime = newTime;
        if (result > 2000) {
          Toast.show('press again to exit');
          return true;
        } else {
          SystemNavigator.pop();
        }
        return false;
      },
      child: Scaffold(
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              PageView(
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: onPageChanged,
                controller: pageController,
                children: const <Widget>[
                  HomePage(),
                  ResourcePage(),
                  GroupPage(),
                  LearnPage(),
                  MinePage(),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 3,
          backgroundColor: const Color(0xffffffff),
          selectedFontSize: 13.0,
          selectedLabelStyle: const TextStyle(color: Colors.red),
          unselectedFontSize: 12.0,
          type: BottomNavigationBarType.fixed,
          fixedColor: Theme.of(context).primaryColor,
          onTap: onTap,
          currentIndex: pageIndex,
          items: [
            _bottomNavigationBarItem(
              icon: Icons.home,
              index: 0,
              title: '首页',
            ),
            _bottomNavigationBarItem(
              icon: Icons.source,
              index: 1,
              title: '资源',
            ),
            _bottomNavigationBarItem(
              icon: Icons.group,
              index: 2,
              title: '社群',
            ),
            _bottomNavigationBarItem(
              icon: Icons.calculate_rounded,
              index: 3,
              title: '教学',
            ),
            _bottomNavigationBarItem(
              icon: Icons.person,
              index: 4,
              title: '我的',
            ),
          ],
        ),
      ),
    );
  }
}

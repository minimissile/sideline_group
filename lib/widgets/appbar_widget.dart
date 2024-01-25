import 'package:sideline_group/config/color.dart';
import 'package:flutter/material.dart';

/// 自定义顶部appBar
class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String title;
  final List<Widget>? actions;

  const AppBarWidget({
    Key? key,
    this.height = kToolbarHeight,
    required this.title,
    this.actions,
  }) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero, // 设置内边距为零
      child: AppBar(
        scrolledUnderElevation: 0,
        // automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
          // borderRadius: BorderRadius.vertical(
          //   bottom: Radius.circular(16.0), // 设置底部边框的圆角半径
          // ),
        ),
        // 其他 AppBar 属性
        centerTitle: true,
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: AppColor.primaryColor,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            color: AppColor.primaryTextColor,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: actions,
      ),
    );
  }
}

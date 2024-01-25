import 'dart:math';

import 'package:flutter/material.dart';

/// 带输入框页面容器， 解决输入框键盘收起问题
class HideKeyboardWidget extends StatelessWidget {
  final Widget child;
  final Function()? onClick;

  const HideKeyboardWidget({Key? key, required this.child, this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: Colors.transparent,
        child: child,
      ),
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }

        if (onClick != null) {
          onClick!();
        }
      },
    );
  }
}

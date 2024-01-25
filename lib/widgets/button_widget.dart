import 'package:sideline_group/config/color.dart';
import 'package:sideline_group/utils/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// 按钮的颜色类型
enum ButtonType {
  /// 主要按钮颜色, 通常用于表示主要操作或突出的按钮，比如提交、确认等。一般为应用的主题色或品牌色
  primary,

  /// 次要按钮颜色, 用于表示次要操作或次要信息的按钮，比如取消、返回等。一般为主题色的变体，用于与主要按钮形成对比
  secondary,

  /// 成功按钮颜色, 用于表示成功或积极的操作的按钮，比如保存、完成等。一般为绿色或鼓励类的颜色
  success,

  /// 危险按钮颜色, 用于表示危险、警告或消极的操作的按钮，比如删除、取消等。一般为红色或警示类的颜色
  danger,

  /// 信息按钮颜色, 用于表示提供额外信息或提示的按钮，比如查看详情、了解更多等。一般为蓝色或信息类的颜色
  info,

  /// 中性按钮颜色, 用于表示普通或默认操作的按钮，比如重置、清除等。一般为灰色或中性类的颜色
  neutral,
}

/// 根据按钮类型获取对应的按钮颜色
Color getColorFromButtonColor(ButtonType buttonType) {
  switch (buttonType) {
    case ButtonType.primary:
      return const Color(0xffffdb7d);
    case ButtonType.secondary:
      return const Color(0xffffdb7d);
    case ButtonType.success:
      return Colors.green;
    case ButtonType.danger:
      return Colors.red;
    case ButtonType.info:
      return const Color(0xffffdb7d);
    case ButtonType.neutral:
      return const Color(0xffffdb7d);
    default:
      return Colors.blue;
  }
}

/// 通用按钮
class Button extends StatefulWidget {
  final String title;
  final double? width;
  final double? height;
  final double top;
  final double bottom;
  final VoidCallback onPressed;
  final ButtonType type;
  final Widget? prefix;

  /// 是否禁用
  final bool disable;

  /// 是否显示loading
  final bool loading;

  const Button({
    super.key,
    required this.onPressed,
    this.width,
    this.height,
    required this.title,
    this.type = ButtonType.primary,
    this.prefix,
    this.disable = false,
    this.loading = false,
    this.top = 0,
    this.bottom = 0,
  });

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  /// 是否禁用
  final bool isDisable = false;

  /// 是否加载中
  final bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? setHeight(52),
      width: widget.width ?? setWidth(240),
      margin: EdgeInsets.only(top: widget.top, bottom: widget.bottom),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: (widget.disable == true || widget.loading == true)
            ? AppColor.disableColor
            : getColorFromButtonColor(widget.type),
      ),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        disabledColor: AppColor.disableColor,
        disabledTextColor: AppColor.secondaryTextColor,
        onPressed: (widget.disable == true || widget.loading == true) ? null: widget.onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (widget.loading)
              Container(
                padding: const EdgeInsets.only(right: 10),
                child: SpinKitFadingCircle(
                  size: 30,
                  color: AppColor.primaryTextColor,
                ),
              ),
            if (widget.prefix != null)
              (Container(
                padding: const EdgeInsets.only(right: 10),
                child: widget.prefix,
              )),
            Text(
              widget.title,
              style: TextStyle(
                fontSize: setFontSize(20),
                fontWeight: FontWeight.w700,
                color: widget.disable ? AppColor.secondaryTextColor : AppColor.primaryTextColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}

/// 唤起选择菜单的按钮
class ChooseButton extends StatefulWidget {
  /// 选中的提示文案
  final String title;
  final VoidCallback onPressed;

  /// 是否禁用
  final bool disable;

  final bool showArrow;

  const ChooseButton({
    super.key,
    required this.onPressed,
    this.title = '',
    this.disable = false,
    this.showArrow = true,
  });

  @override
  State<ChooseButton> createState() => _ChooseButtonState();
}

class _ChooseButtonState extends State<ChooseButton> {
  final bool _isDropdownOpen = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.disable
          ? null
          : () {
        widget.onPressed();
      },
      child: Container(
        width: setWidth(268),
        height: setHeight(48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              widget.title.isNotEmpty ? widget.title : "确认",
              style: TextStyle(
                fontSize: setFontSize(14),
                fontWeight: FontWeight.w700,
                color: AppColor.secondaryTextColor,
              ),
              textAlign: TextAlign.center,
            ),
            if (widget.showArrow)
              Positioned(
                right: 0,
                child: Icon(
                  _isDropdownOpen ? Icons.arrow_drop_up_rounded : Icons.arrow_drop_down_rounded,
                  size: 44.0,
                  color: AppColor.secondaryTextColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

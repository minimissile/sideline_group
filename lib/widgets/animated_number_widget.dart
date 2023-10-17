import 'package:flutter/material.dart';
import 'package:sideline_group/utils/screen_util.dart';

/// 带动画的数字
class AnimatedNumber extends StatefulWidget {
  final int number;

  // 数字动画持续时间
  final Duration duration;

  // 自定义样式
  final TextStyle? customStyle;

  // 后缀
  final String? suffix;

  // 前缀
  final String? prefix;

  const AnimatedNumber({
    Key? key,
    required this.number,
    this.duration = const Duration(milliseconds: 500),
    this.customStyle,
    this.suffix = '',
    this.prefix = '',
  }) : super(key: key);

  @override
  State<AnimatedNumber> createState() => _AnimatedNumberState();
}

class _AnimatedNumberState extends State<AnimatedNumber> {
  late int _currentNumber;

  @override
  void initState() {
    super.initState();
    _currentNumber = widget.number;
  }

  @override
  void didUpdateWidget(covariant AnimatedNumber oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.number != oldWidget.number) {
      setState(() {
        _currentNumber = widget.number;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle defaultStyle = TextStyle(
      fontSize: setFontSize(18),
      fontWeight: FontWeight.w700,
      color: Colors.white,
    );

    final mergedStyle = defaultStyle.merge(widget.customStyle);

    return TweenAnimationBuilder<int>(
      tween: IntTween(begin: _currentNumber, end: widget.number),
      duration: widget.duration,
      builder: (context, value, child) {
        return Text(
          '${widget.prefix}${value.toString()}${widget.suffix}',
          style: mergedStyle,
          textAlign: TextAlign.center,
        );
      },
    );
  }
}

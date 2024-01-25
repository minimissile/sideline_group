import 'package:flutter/material.dart';
import './custom_toast.dart';
import './animations/animation.dart';
import './animations/opacity_animation.dart';
import './animations/offset_animation.dart';
import './animations/scale_animation.dart';

class EasyLoadingTheme {
  /// color of indicator
  static Color get indicatorColor =>
      CustomToast.instance.loadingStyle == EasyLoadingStyle.custom
          ? CustomToast.instance.indicatorColor!
          : CustomToast.instance.loadingStyle == EasyLoadingStyle.dark
              ? Colors.white
              : Colors.black;

  /// progress color of loading
  static Color get progressColor =>
      CustomToast.instance.loadingStyle == EasyLoadingStyle.custom
          ? CustomToast.instance.progressColor!
          : CustomToast.instance.loadingStyle == EasyLoadingStyle.dark
              ? Colors.white
              : Colors.black;

  /// background color of loading
  static Color get backgroundColor =>
      CustomToast.instance.loadingStyle == EasyLoadingStyle.custom
          ? CustomToast.instance.backgroundColor!
          : CustomToast.instance.loadingStyle == EasyLoadingStyle.dark
              ? Colors.black.withOpacity(0.9)
              : Colors.white;

  /// boxShadow color of loading
  static List<BoxShadow>? get boxShadow =>
      CustomToast.instance.loadingStyle == EasyLoadingStyle.custom
          ? CustomToast.instance.boxShadow ?? [const BoxShadow()]
          : null;

  /// font color of status
  static Color get textColor =>
      CustomToast.instance.loadingStyle == EasyLoadingStyle.custom
          ? CustomToast.instance.textColor!
          : CustomToast.instance.loadingStyle == EasyLoadingStyle.dark
              ? Colors.white
              : Colors.black;

  /// mask color of loading
  static Color maskColor(EasyLoadingMaskType? maskType) {
    maskType ??= CustomToast.instance.maskType;
    return maskType == EasyLoadingMaskType.custom
        ? CustomToast.instance.maskColor!
        : maskType == EasyLoadingMaskType.black
            ? Colors.black.withOpacity(0.5)
            : Colors.transparent;
  }

  /// loading animation
  static EasyLoadingAnimation get loadingAnimation {
    EasyLoadingAnimation _animation;
    switch (CustomToast.instance.animationStyle) {
      case EasyLoadingAnimationStyle.custom:
        _animation = CustomToast.instance.customAnimation!;
        break;
      case EasyLoadingAnimationStyle.offset:
        _animation = OffsetAnimation();
        break;
      case EasyLoadingAnimationStyle.scale:
        _animation = ScaleAnimation();
        break;
      default:
        _animation = OpacityAnimation();
        break;
    }
    return _animation;
  }

  /// font size of status
  static double get fontSize => CustomToast.instance.fontSize;

  /// size of indicator
  static double get indicatorSize => CustomToast.instance.indicatorSize;

  /// width of progress indicator
  static double get progressWidth => CustomToast.instance.progressWidth;

  /// width of indicator
  static double get lineWidth => CustomToast.instance.lineWidth;

  /// loading indicator type
  static EasyLoadingIndicatorType get indicatorType =>
      CustomToast.instance.indicatorType;

  /// toast position
  static EasyLoadingToastPosition get toastPosition =>
      CustomToast.instance.toastPosition;

  /// toast position
  static AlignmentGeometry alignment(EasyLoadingToastPosition? position) =>
      position == EasyLoadingToastPosition.bottom
          ? AlignmentDirectional.bottomCenter
          : (position == EasyLoadingToastPosition.top
              ? AlignmentDirectional.topCenter
              : AlignmentDirectional.center);

  /// display duration
  static Duration get displayDuration => CustomToast.instance.displayDuration;

  /// animation duration
  static Duration get animationDuration =>
      CustomToast.instance.animationDuration;

  /// contentPadding of loading
  static EdgeInsets get contentPadding => CustomToast.instance.contentPadding;

  /// padding of status
  static EdgeInsets get textPadding => CustomToast.instance.textPadding;

  /// textAlign of status
  static TextAlign get textAlign => CustomToast.instance.textAlign;

  /// textStyle of status
  static TextStyle? get textStyle => CustomToast.instance.textStyle;

  /// radius of loading
  static double get radius => CustomToast.instance.radius;

  /// should dismiss on user tap
  static bool? get dismissOnTap => CustomToast.instance.dismissOnTap;

  static bool ignoring(EasyLoadingMaskType? maskType) {
    maskType ??= CustomToast.instance.maskType;
    return CustomToast.instance.userInteractions ??
        (maskType == EasyLoadingMaskType.none ? true : false);
  }
}

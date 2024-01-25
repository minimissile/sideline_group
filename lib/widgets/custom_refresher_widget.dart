import 'package:sideline_group/config/color.dart';
import 'package:sideline_group/utils/logger_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 自定义刷新容器
class CustomRefresher extends StatelessWidget {
  final RefreshController controller;
  final ScrollController? scrollController;
  final void Function()? onRefresh;
  final void Function()? onLoading;
  final Widget? child;
  final Color? tipsColor;
  final bool hideFooterWhenNotFull;

  ///  启用下拉刷新
  final bool enablePullDown;

  /// 启用上拉加载
  final bool enablePullUp;

  /// 是否显示滚动条
  final bool? showScrollbar;

  /// 列表数据条数
  final int? itemCount;

  const CustomRefresher({
    super.key,
    required this.controller,
    this.onRefresh,
    this.onLoading,
    this.child,
    this.itemCount,
    this.showScrollbar = false,
    this.scrollController,
    this.enablePullDown = true,
    this.enablePullUp = true,
    this.tipsColor = Colors.white70,
    this.hideFooterWhenNotFull = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: scrollController,
      thumbVisibility: showScrollbar,
      child: RefreshConfiguration(
        hideFooterWhenNotFull: hideFooterWhenNotFull,
        child: SmartRefresher(
          controller: controller,
          onRefresh: onRefresh,
          onLoading: onLoading,
          enablePullDown: enablePullDown,
          enablePullUp: enablePullUp,
          enableTwoLevel: false,
          header: WaterDropMaterialHeader(
            distance: 50,
            offset: -2,
            backgroundColor: AppColor.primaryColor,
          ),
          footer: CustomFooter(
            height: 50,
            builder: (BuildContext context, LoadStatus? mode) {
              Logger.log('当前列表状态：${mode.toString()}');
              Widget body;
              if (mode == LoadStatus.idle) {
                body = _buildText('上拉加载'); // 上拉加载
              } else if (mode == LoadStatus.loading) {
                body = const CupertinoActivityIndicator();
              } else if (mode == LoadStatus.failed) {
                body = _buildText('加载失败,点击重试'); // 加载失败,点击重试
              } else if (mode == LoadStatus.canLoading) {
                body = _buildText('松手,加载更多'); // 松手,加载更多
              } else {
                if (itemCount == 0) {
                  body = _buildText('暂无数据'); // 暂无数据
                } else {
                  body = _buildText('没有更多数据了~'); // 没有更多数据了~
                }
              }
              return SizedBox(
                height: 50,
                child: Center(child: body),
              );
            },
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _buildText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: tipsColor,
      ),
    );
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sideline_group/model/host_model.dart';
import 'package:sideline_group/utils/logger_util.dart';
import 'package:sideline_group/widgets/appbar_widget.dart';
import 'package:sideline_group/widgets/custom_refresher_widget.dart';

/// 主机监控
class HostMonitorPage extends StatefulWidget {
  const HostMonitorPage({super.key});

  @override
  State<HostMonitorPage> createState() => _HostMonitorPageState();
}

class _HostMonitorPageState extends State<HostMonitorPage> {
  /// 滚动控制器
  final ScrollController _scrollController = ScrollController();

  /// 刷新控制器
  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  Map<String, dynamic> params = {"pageNo": 1, "pageSize": 200};

  List<HostModel> list = [];

  Future<void> _getDataList({bool isLoadMore = false}) async {
    String url = 'https://backend.stock.hostmonit.com/monitor/findMonitorLess';
    Dio dio = Dio();

    try {
      Response response = await dio.post(url, data: params);

      var res = HostResponseModel.fromJson(response.data);
      var tempList = res.content ?? [];

      // 是否为加载更多
      if (isLoadMore) {
        tempList = [...list, ...tempList];
      }

      setState(() {
        list.clear();
        list = tempList;
      });
    } catch (e) {
      Logger.log("获取主机列表出错：${e.toString()}");
    }
  }

  /// 加载中事件
  void _onLoading() async {
    await _getDataList(isLoadMore: true);
  }

  /// 刷新事件
  void _onRefresh() async {
    await _getDataList();
    _refreshController.refreshCompleted(resetFooterState: true);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getDataList();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: '主机监控'),
      body: Column(
        children: [
          Expanded(
            child: CustomRefresher(
              itemCount: list.length,
              tipsColor: Colors.black38,
              scrollController: _scrollController,
              showScrollbar: true,
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: ListView.separated(
                controller: _scrollController,
                padding: const EdgeInsets.all(15).copyWith(bottom: 0),
                itemCount: list.length,
                itemBuilder: (context, index) {
                  final hostData = list[index];
                  return _buildHostItem(data: hostData);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 10,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHostItem({required HostModel data}) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12), // 阴影颜色
            spreadRadius: 5, // 阴影扩散程度
            blurRadius: 10, // 阴影模糊程度
            offset: const Offset(0, 3), // 阴影偏移
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          rowCell(title: 'title', value: data.title ?? '--'),
          rowCell(title: 'location', value: data.location ?? '--'),
          rowCell(title: 'level', value: (data.level ?? 1).toString()),
        ],
      ),
    );
  }
}

Widget rowCell({
  required String title,
  required String value,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 70,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
              height: 18 / 12,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.black54,
              height: 18 / 12,
            ),
          ),
        )
      ],
    ),
  );
}

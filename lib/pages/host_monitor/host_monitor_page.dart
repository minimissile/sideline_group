import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sideline_group/model/host_model.dart';
import 'package:sideline_group/utils/logger_util.dart';
import 'package:sideline_group/widgets/appbar_widget.dart';

/// 主机监控
class HostMonitorPage extends StatefulWidget {
  const HostMonitorPage({super.key});

  @override
  State<HostMonitorPage> createState() => _HostMonitorPageState();
}

class _HostMonitorPageState extends State<HostMonitorPage> {
  Map<String, dynamic> params = {"pageNo": 1, "pageSize": 100};

  List<HostModel> list = [];

  void _getDataList() async {
    String url = 'https://backend.stock.hostmonit.com/monitor/findMonitorLess';

    Map<String, dynamic> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer your_token_here', // 添加需要的授权头
    };

    Dio dio = Dio();

    try {
      Response response = await dio.post(
        url,
        options: Options(headers: headers), // 添加 headers
      );


      // 处理响应数据
      print('Response data: ${response.data}');


    } catch (e) {
      Logger.log(e.toString());
    }

    dio.post(url);
  }

  @override
  void initState() {
    super.initState();
    _getDataList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: '主机监控',
      ),
      body: Container(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}

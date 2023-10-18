import 'package:flutter/material.dart';
import 'package:sideline_group/utils/screen_util.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('首页', style: TextStyle(fontSize: setFontSize(18)),),
      ),
      body: Column(
        children: [
          Text('data')
        ],
      ),
    );
  }
}

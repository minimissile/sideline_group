import 'package:flutter/material.dart';
import 'package:sideline_group/widgets/appbar_widget.dart';

/// 反韭菜联盟
class AntiLeekAlliancePage extends StatefulWidget {
  const AntiLeekAlliancePage({super.key});

  @override
  State<AntiLeekAlliancePage> createState() => _AntiLeekAlliancePageState();
}

class _AntiLeekAlliancePageState extends State<AntiLeekAlliancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: '反韭菜联盟',),
      body: Container(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}

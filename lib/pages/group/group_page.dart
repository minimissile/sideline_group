import 'package:flutter/material.dart';

/// 社群
class GroupPage extends StatefulWidget {
  const GroupPage({super.key});

  @override
  State<GroupPage> createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('社群'),
      ),
      body: const Column(
        children: [
          Text("社群")
        ],
      ),
    );
  }
}

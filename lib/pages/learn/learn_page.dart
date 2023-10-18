import 'package:flutter/material.dart';

/// 教学
class LearnPage extends StatefulWidget {
  const LearnPage({super.key});

  @override
  State<LearnPage> createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('教学'),
      ),
      body: const Column(
        children: [
          Text("教学")
        ],
      ),
    );
  }
}

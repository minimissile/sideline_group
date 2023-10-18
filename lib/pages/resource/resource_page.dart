import 'package:flutter/material.dart';

/// 资源
class ResourcePage extends StatefulWidget {
  const ResourcePage({super.key});

  @override
  State<ResourcePage> createState() => _ResourcePageState();
}

class _ResourcePageState extends State<ResourcePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('资源'),
      ),
      body: const Column(
        children: [
          Text("资源")
        ],
      ),
    );
  }
}

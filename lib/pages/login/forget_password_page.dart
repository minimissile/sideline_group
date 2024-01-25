import 'package:flutter/material.dart';

/// 忘记密码
class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('忘记密码'),),
      body: Container(
        child: Column(
          children: [
            Text('忘记密码')
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class PasswordPage extends StatelessWidget {
  PasswordPage({super.key});

  final PasswordLogic logic = Get.put(PasswordLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('密码'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('密码'),
          ],
        ),
      ),
    );
  }
}

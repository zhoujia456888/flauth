import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  final SettingsLogic logic = Get.put(SettingsLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设置'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('设置'),
          ],
        ),
      )
    );
  }
}

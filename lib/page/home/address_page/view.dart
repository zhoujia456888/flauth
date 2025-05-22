import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class AddressPage extends StatelessWidget {
  AddressPage({super.key});

  final AddressLogic logic = Get.put(AddressLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('地址'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('地址'),
          ],
        ),
      )
    );
  }
}

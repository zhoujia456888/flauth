import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/get_pages.dart';
import 'logic.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeLogic logic = Get.put(HomeLogic());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: logic.pageList[logic.currentIndex],
        bottomNavigationBar: NavigationBar(
          selectedIndex: logic.currentIndex,
          onDestinationSelected: (index) {
            logic.currentIndex = index;
          },
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          destinations: [
            NavigationDestination(icon: Icon(Icons.security), label: '安全码'),
            NavigationDestination(icon: Icon(Icons.password), label: '密码'),
            NavigationDestination(icon: Icon(Icons.location_city), label: '地址'),
            NavigationDestination(icon: Icon(Icons.settings), label: '设置'),
          ],
        ),
      ),
    );
  }
}

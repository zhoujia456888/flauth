import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  final SettingsLogic logic = Get.put(SettingsLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('设置')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text("深色模式"),
              trailing: Obx(
                () => Switch(
                  value: logic.isDarkMode,
                  onChanged: (value) {
                    logic.changeDarkMode(value);
                  },
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text("自动隐藏安全码"),
              trailing: Obx(
                () => Switch(
                  value: logic.isAutoHideCode,
                  onChanged: (value) {
                    logic.awaitHideCode(value);
                  },
                ),
              ),
              onTap: () {},
            ),
            Obx(
              () => logic.canAuthenticate
                  ? ListTile(
                      title: Text("生物识别"),
                      trailing: Obx(
                        () => Switch(
                          value: logic.openAuthenticateWithBiometrics,
                          onChanged: (value) async {
                            logic.awaitOpenAuthenticateWithBiometrics(value);
                          },
                        ),
                      ),
                      onTap: () {},
                    )
                  : SizedBox(height: 0),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../config/get_pages.dart';
import 'logic.dart';

class ScanCodePage extends StatelessWidget {
  ScanCodePage({super.key});

  final ScanCodeLogic logic = Get.put(ScanCodeLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // 允许body内容延伸到AppBar下面
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.transparent, // 设置AppBar背景为透明
        elevation: 0, // 移除阴影
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: logic.controller,
            onDetect: (barcodes) {
              Barcode? barcode = barcodes.barcodes.firstOrNull;
              if (barcode != null) {
                logic.controller.stop();
                Get.back(result: {"barcode": barcode.displayValue});
                Get.snackbar("扫码成功", barcode.displayValue!);
              }
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Row(
                children: [
                  IconButton(
                    iconSize: 30,
                    onPressed: () {
                      logic.flashlightController();
                    },
                    icon: Obx(() => Icon(logic.flashlightOn ? Icons.flashlight_off : Icons.flashlight_on)),
                  ),
                  Spacer(),
                  IconButton(
                    iconSize: 30,
                    onPressed: () {
                      logic.imagePicker();
                    },
                    icon: Icon(Icons.image_outlined),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

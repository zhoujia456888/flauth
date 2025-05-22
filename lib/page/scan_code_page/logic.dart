import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanCodeLogic extends GetxController {
  MobileScannerController controller = MobileScannerController();

  final _flashlightOn = false.obs; //
  get flashlightOn => _flashlightOn.value; //
  set flashlightOn(val) => _flashlightOn.value = val; //

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  flashlightController() {
    flashlightOn = !flashlightOn;
    controller.toggleTorch();
  }

  imagePicker() {
    ImagePicker imagePicker = ImagePicker();
    imagePicker.pickImage(source: ImageSource.gallery).then((value) async {
      if (value == null) {
        return;
      }
      BarcodeCapture? barcodeCapture = await controller.analyzeImage(value.path);
      if (barcodeCapture == null) {
        Get.snackbar("扫码失败", "请重新扫码");
        return;
      }
      Get.back(result: {"barcode": barcodeCapture.barcodes.first.displayValue});
    });
  }
}

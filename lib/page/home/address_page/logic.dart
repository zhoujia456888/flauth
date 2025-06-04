import 'dart:async';

import 'package:FlAuth/model/address_model.dart';
import 'package:FlAuth/model/address_tag_model.dart';
import 'package:FlAuth/objectBox/addressModelBoxUtils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class AddressLogic extends GetxController {
  final tagList = <Rx<AddressTagModel>>[
    AddressTagModel(tagName: "家", isSelected: false).obs,
    AddressTagModel(tagName: "公司", isSelected: false).obs,
    AddressTagModel(tagName: "学校", isSelected: false).obs,
  ].obs;

  final addressModelList = <Rx<AddressModel>>[].obs; //

  final searchShowIndexList = <int>[].obs; //

  TextEditingController postalCodeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  @override
  void onReady() {
    getAddressByDb();
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void getAddressByDb() {
    addressModelList.clear();
    List<AddressModel> addressList = AddressModelBoxUtils().getAllAddress();
    for (int i = 0; i < addressList.length; i++) {
      AddressModel addressModel = addressList[i];
      addressModelList.add(Rx(addressModel));
      searchShowIndexList.add(i);
    }
    addressModelList.refresh();
  }

  void searchAddress(String text) {
    searchShowIndexList.clear();
    text = text.toLowerCase();
    if (text.isEmpty) {
      cleanSearch();
      return;
    }
    for (int i = 0; i < addressModelList.length; i++) {
      if ((addressModelList[i].value.postalCode ?? "").toLowerCase().contains(text) ||
          (addressModelList[i].value.address ?? "").toLowerCase().contains(text) ||
          (addressModelList[i].value.username ?? "").toLowerCase().contains(text) ||
          (addressModelList[i].value.phoneNumber ?? "").toLowerCase().contains(text)) {
        searchShowIndexList.add(i);
        searchShowIndexList.refresh();
      }
    }
    addressModelList.refresh();
  }

  void cleanSearch() {
    searchShowIndexList.clear();
    for (int i = 0; i < addressModelList.length; i++) {
      searchShowIndexList.add(i);
      searchShowIndexList.refresh();
    }
    addressModelList.refresh();
  }

  void updateAddress(Rx<AddressModel> addressModel) {
    String postalCode = postalCodeController.text;
    String address = addressController.text;
    String username = usernameController.text;
    String phoneNumber = phoneNumberController.text;

    String tag = tagList.firstWhere((element) => element.value.isSelected).value.tagName;

    addressModel.value = addressModel.value.copyWith(
      postalCode: postalCode,
      address: address,
      username: username,
      phoneNumber: phoneNumber,
      tag: tag,
    );
    int isUpdate = AddressModelBoxUtils().updateAddress(addressModel.value);
    if (isUpdate >= 0) {
      SmartDialog.dismiss();
      SmartDialog.showToast("修改成功");
      postalCodeController.clear();
      addressController.clear();
      usernameController.clear();
      phoneNumberController.clear();
      resetTagList();
    } else {
      SmartDialog.showToast("修改失败");
    }
  }

  void saveAddress() {
    String postalCode = postalCodeController.text;
    String address = addressController.text;
    String username = usernameController.text;
    String phoneNumber = phoneNumberController.text;

    String tag = tagList.firstWhere((element) => element.value.isSelected).value.tagName;

    if (postalCode.isEmpty || address.isEmpty || username.isEmpty || phoneNumber.isEmpty) {
      SmartDialog.showToast("请填写完整地址信息");
      return;
    }

    AddressModel addressModel = AddressModel(
      postalCode: postalCode,
      address: address,
      username: username,
      phoneNumber: phoneNumber,
      tag: tag,
    );

    if (AddressModelBoxUtils().addAddress(addressModel) >= 0) {
      addressModelList.add(addressModel.obs);
      postalCodeController.clear();
      addressController.clear();
      usernameController.clear();
      phoneNumberController.clear();
      resetTagList();
      SmartDialog.dismiss();
      SmartDialog.showToast("添加成功");
      getAddressByDb();
    }
  }

  void selectTag(Rx<AddressTagModel> tagModel, bool value) {
    for (var element in tagList) {
      element.value.isSelected = false;
    }
    tagModel(tagModel.value.copyWith(isSelected: true));
  }

  void resetTagList() {
    for (var element in tagList) {
      element.value.isSelected = false;
    }
  }

  FutureOr<dynamic> deleteAddress(AddressModel addressModel) {
    if (AddressModelBoxUtils().deleteAddress(addressModel)) {
      SmartDialog.dismiss();
      SmartDialog.showToast("删除成功");
      getAddressByDb();
    }
  }
}

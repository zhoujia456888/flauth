import 'dart:async';

import 'package:FlAuth/model/address_model.dart';
import 'package:FlAuth/widget/add_dialog.dart';
import 'package:FlAuth/widget/delete_dialog.dart';
import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

import 'logic.dart';

class AddressPage extends StatelessWidget {
  AddressPage({super.key});

  final AddressLogic logic = Get.put(AddressLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithSearchSwitch(
        fieldHintText: "搜索",
        onChanged: (text) {
          logic.searchAddress(text);
        },
        onCleared: () {
          logic.cleanSearch();
        },
        onClosed: () {
          logic.cleanSearch();
        },

        appBarBuilder: (context) {
          return AppBar(title: Text('地址'), actions: [AppBarSearchButton()]);
        },
      ),
      body: Obx(
        () => RefreshIndicator(
          onRefresh: () async {
            await Future.delayed(Duration(seconds: 2), () {
              logic.getAddressByDb();
              return Future.value(true);
            });
          },
          child: ListView.custom(
            childrenDelegate: SliverChildBuilderDelegate((context, index) {
              Rx<AddressModel> model = logic.addressModelList[index];
              bool searchIndex = logic.searchShowIndexList.contains(index);
              return searchIndex
                  ? Card(
                      elevation: 0,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {},
                        onLongPress: () {
                          showLongPress(model);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.secondaryContainer,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                child: Text("${model.value.tag}"),
                              ),
                              addressItem("邮编", model.value.postalCode ?? ""),
                              addressItem("地址", model.value.address ?? ""),
                              addressItem("用户名", model.value.username ?? ""),
                              addressItem("手机号码", model.value.phoneNumber ?? ""),
                            ],
                          ),
                        ),
                      ),
                    )
                  : SizedBox();
            }, childCount: logic.addressModelList.length),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showAddDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Row addressItem(String titleText, String contentText) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: 300, child: Text("$titleText:  $contentText", maxLines: 1, overflow: TextOverflow.ellipsis)),
        Spacer(),
        InkWell(
          borderRadius: BorderRadius.circular(20),
          child: Padding(padding: EdgeInsets.all(8), child: Icon(Icons.copy, size: 18)),
          onTap: () {
            Clipboard.setData(ClipboardData(text: contentText));
            SmartDialog.showToast("$titleText复制成功");
          },
        ),
      ],
    );
  }

  //添加
  void showAddDialog() {
    SmartDialog.show(
      builder: (context) {
        return AddDialog(
          addItemList: [
            AddDialogItem(
              title: '手动输入添加',
              icon: Icons.input,
              onTapAction: () {
                SmartDialog.dismiss().then((_) => showInputOrEditAddressDialog(false, AddressModel().obs));
              },
            ),
          ],
        );
      },
    );
  }

  //长按
  void showLongPress(Rx<AddressModel> model) {
    SmartDialog.show(
      builder: (context) {
        return AddDialog(
          addItemList: [
            AddDialogItem(
              title: '删除地址',
              icon: Icons.delete,
              onTapAction: () {
                SmartDialog.dismiss().then((_) => showDeleteDialog(model));
              },
            ),
            AddDialogItem(
              title: '编辑地址',
              icon: Icons.edit_note,
              onTapAction: () async {
                SmartDialog.dismiss().then((_) => showInputOrEditAddressDialog(true, model));
              },
            ),
          ],
        );
      },
    );
  }

  //输入或编辑地址
  void showInputOrEditAddressDialog(bool isEdit, Rx<AddressModel> addressModel) {
    logic.postalCodeController.text = addressModel.value.postalCode ?? "";
    logic.addressController.text = addressModel.value.address ?? "";
    logic.usernameController.text = addressModel.value.username ?? "";
    logic.phoneNumberController.text = addressModel.value.phoneNumber ?? "";

    for (var addressTagModel in logic.tagList) {
      if (addressTagModel.value.tagName == addressModel.value.tag) {
        addressTagModel.value.isSelected = true;
      }
    }
    logic.tagList.refresh();

    SmartDialog.show(
      onDismiss: () => FocusScope.of(Get.context!).requestFocus(),
      builder: (context) {
        return AnimatedPadding(
          padding: MediaQuery.of(context).viewInsets,
          duration: const Duration(milliseconds: 100),
          child: Card(
            elevation: 0,
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("添加地址"),
                  SizedBox(height: 10),
                  SizedBox(height: 10),
                  TextField(
                    controller: logic.postalCodeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: "邮编", border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: logic.addressController,
                    decoration: InputDecoration(labelText: "地址", border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: logic.usernameController,
                    decoration: InputDecoration(labelText: "姓名", border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: logic.phoneNumberController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: "手机号码", border: OutlineInputBorder()),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text("标签"),
                        Obx(
                          () => Wrap(
                            spacing: 5,
                            children: logic.tagList.map((tagModel) {
                              String tagName = tagModel.value.tagName;
                              bool isSelected = tagModel.value.isSelected;
                              return ChoiceChip(
                                label: Text(tagName),
                                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                selected: isSelected,
                                onSelected: (bool value) {
                                  logic.selectTag(tagModel, value);
                                },
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          SmartDialog.dismiss();
                        },
                        child: Text("取消"),
                      ),
                      TextButton(
                        onPressed: () {
                          if (isEdit) {
                            logic.updateAddress(addressModel);
                          } else {
                            logic.saveAddress();
                          }
                        },
                        child: Text("确定"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  FutureOr<dynamic> showDeleteDialog(Rx<AddressModel> model) {
    SmartDialog.show(
      builder: (context) {
        return DeleteDialog(
          dialogTitle: "删除地址",
          dialogContent: "确定删除这个地址吗？删除之后没办法恢复哦！",
          dialogAction: () {
            SmartDialog.dismiss().then((_) => logic.deleteAddress(model.value));
          },
        );
      },
    );
  }
}

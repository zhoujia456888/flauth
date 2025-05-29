import 'package:flutter/material.dart';

class AddDialog extends StatelessWidget {
  final List<AddDialogItem> addItemList;

  const AddDialog({super.key,  required this.addItemList});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: addItemList.map((item) {
            return InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: item.onTapAction,
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Icon(size: 24, item.icon),
                    SizedBox(width: 10),
                    Text(item.title, style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class AddDialogItem {
  String title;
  IconData icon;
  Function() onTapAction;

  AddDialogItem({required this.title, required this.icon, required this.onTapAction});
}

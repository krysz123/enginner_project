import 'package:enginner_project/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SharedAccountScreen extends StatelessWidget {
  const SharedAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appBarHeight = DeviceUtility.getAppBarHeight();
    return Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.only(top: appBarHeight, right: 30),
            child: IconButton(
              onPressed: () => Get.snackbar('Siema', 'SSSS'),
              icon: const Icon(
                Icons.add,
                size: 30,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

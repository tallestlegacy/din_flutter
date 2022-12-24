import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/constants/strings.dart';
import '/utils/json.dart';
import '/utils/store.dart';

class Bismi extends StatelessWidget {
  const Bismi({super.key});

  @override
  Widget build(BuildContext context) {
    final ReaderStoreController readerStoreController =
        Get.put(ReaderStoreController());
    return Obx(
      () => Text(
        bismi,
        style: googleFontify(
          readerStoreController.arabicFont.value,
          TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: readerStoreController.fontSize * 3,
          ),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

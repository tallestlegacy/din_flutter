import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:din/utils/store.dart';
import "package:get/get.dart";
import '/constants/strings.dart';

const Widget linkIcon = Icon(
  Icons.link_rounded,
  color: Colors.grey,
  size: 16,
);

class DinAppIcon extends StatelessWidget {
  const DinAppIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final ReaderStoreController readerStoreController =
        Get.put(ReaderStoreController());
    return Obx(
      () => Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(100)),
            color: Theme.of(context).backgroundColor.withAlpha(50),
          ),
          padding: const EdgeInsets.all(16),
          child: Text(
            din,
            textHeightBehavior: const TextHeightBehavior(
              applyHeightToFirstAscent: true,
              applyHeightToLastDescent: false,
            ),
            style: TextStyle(
              fontSize: 48,
              fontFamily: readerStoreController.arabicFont.value,
            ),
          ),
        ),
      ),
    );
  }
}

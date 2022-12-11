import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/utils/store.dart';
import '/constants/strings.dart';

class FontSetting extends StatelessWidget {
  const FontSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final ReaderStoreController readerStoreController =
        Get.put(ReaderStoreController());

    return Container(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        runSpacing: 12,
        spacing: 12,
        children: [
          ...readerStoreController.arabicFonts
              .map(
                (fontFamily) => Obx(
                  () => ActionChip(
                    visualDensity: VisualDensity.compact,
                    backgroundColor:
                        readerStoreController.arabicFont.value == fontFamily
                            ? Theme.of(context).backgroundColor
                            : null,
                    label: Text(din),
                    labelStyle: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: readerStoreController.fontSize.value * 1.2),
                    surfaceTintColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      readerStoreController.setArabicFont(fontFamily);
                    },
                    side: BorderSide(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ),
              )
              .toList()
        ],
      ),
    );
  }
}

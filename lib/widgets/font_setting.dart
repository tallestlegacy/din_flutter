import 'package:din/widgets/padded_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/utils/json.dart';
import '/utils/store.dart';
import '/constants/strings.dart';

class FontSetting extends StatelessWidget {
  const FontSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final ReaderStoreController readerStoreController =
        Get.put(ReaderStoreController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() => PaddedText(
            text:
                "Arabic fonts (Current : ${readerStoreController.arabicFont.value})",
            padding: 8)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          key: const PageStorageKey<String>("arabic fonts"),
          child: Wrap(
            direction: Axis.horizontal,
            children: arabicFonts
                .map(
                  (fontFamily) => Container(
                    margin: const EdgeInsets.all(4),
                    child: Obx(
                      () => ActionChip(
                        visualDensity: VisualDensity.compact,
                        backgroundColor:
                            readerStoreController.arabicFont.value == fontFamily
                                ? Theme.of(context).backgroundColor
                                : null,
                        label: const Text(din),
                        labelStyle: googleFontify(fontFamily, null),
                        surfaceTintColor: Theme.of(context).primaryColor,
                        onPressed: () {
                          readerStoreController.setArabicFont(fontFamily);
                        },
                        side: BorderSide(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}

import 'package:din/utils/string_locale.dart';
import 'package:din/widgets/padded_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/utils/json.dart';
import '/utils/store.dart';
import '/constants/strings.dart';

class FontSetting extends StatelessWidget {
  final bool isAyaEnd;
  const FontSetting({super.key, this.isAyaEnd = false});

  @override
  Widget build(BuildContext context) {
    final ReaderStoreController readerStoreController =
        Get.put(ReaderStoreController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() => PaddedText(
            text: isAyaEnd
                ? "End of Aya : ${readerStoreController.ayaEndFont.value}"
                : "Arabic fonts : ${readerStoreController.arabicFont.value}",
            padding: 8)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          key: const PageStorageKey<String>("arabic fonts"),
          child: Wrap(
            direction: Axis.horizontal,
            children: (isAyaEnd ? ayaEndFonts : arabicFonts)
                .map(
                  (fontFamily) => Container(
                    margin: const EdgeInsets.all(4),
                    child: Obx(
                      () => ActionChip(
                        shape: isAyaEnd ? const CircleBorder() : null,
                        visualDensity: VisualDensity.compact,
                        backgroundColor: (isAyaEnd
                                    ? readerStoreController.ayaEndFont.value
                                    : readerStoreController.arabicFont.value) ==
                                fontFamily
                            ? Theme.of(context)
                                .colorScheme
                                .primary
                                .withAlpha(120)
                            : null,
                        label: isAyaEnd
                            ? Text("\u06dd${toFarsi(123)}")
                            : const Text(din),
                        labelStyle: googleFontify(fontFamily, null),
                        surfaceTintColor: Theme.of(context).primaryColor,
                        onPressed: () {
                          isAyaEnd
                              ? readerStoreController.setAyaEndFont(fontFamily)
                              : readerStoreController.setArabicFont(fontFamily);
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

import 'package:din/widgets/padded_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/utils/store.dart';
import '/widgets/divider.dart';
import 'font_setting.dart';

class TextSettings extends StatelessWidget {
  const TextSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final ReaderStoreController readerStoreController =
        Get.put(ReaderStoreController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const PaddedText(text: "Text formats", padding: 8),
        Obx(
          () => CheckboxListTile(
            title: const Text("Arabic text"),
            value: readerStoreController.showArabicText.value,
            onChanged: ((value) {
              readerStoreController.setShowArabicText(value!);
            }),
          ),
        ),
        Obx(
          () => CheckboxListTile(
            title: const Text("Transliteration"),
            value: readerStoreController.showTransliteration.value,
            onChanged: ((value) {
              readerStoreController.setTransliteration(value!);
            }),
          ),
        ),
        Obx(
          () => CheckboxListTile(
            title: const Text("Translation"),
            value: readerStoreController.showTranslation.value,
            onChanged: ((value) {
              readerStoreController.setTranslation(value!);
            }),
          ),
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              const Icon(Icons.text_decrease_rounded),
              Expanded(
                  child: Obx(() => Slider(
                        value: readerStoreController.fontSize.value,
                        onChanged: readerStoreController.setFontSize,
                        min: 8,
                        max: 32,
                        divisions: (32 - 8) ~/ 2,
                        label: readerStoreController.fontSize.value
                            .toInt()
                            .toString(),
                      ))),
              const Icon(Icons.text_increase_rounded),
            ],
          ),
        ),
      ],
    );
  }
}

class TextSettingsAction extends StatelessWidget {
  const TextSettingsAction({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.text_format_rounded),
      onPressed: () {
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          context: context,
          builder: ((context) {
            return Container(
              constraints:
                  BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                color: Theme.of(context).canvasColor,
              ),
              child: SafeArea(
                bottom: true,
                child: ListView(
                  padding: const EdgeInsets.only(bottom: 16),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: const [
                    HandleBar(),
                    TextSettings(),
                    Divider(),
                    FontSetting(),
                    Spacing(padding: 16),
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

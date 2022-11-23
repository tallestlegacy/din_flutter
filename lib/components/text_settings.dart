import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/util/store.dart';
import '/components/divider.dart';

class TextSettings extends StatelessWidget {
  const TextSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final ReaderStoreController readerStoreController =
        Get.put(ReaderStoreController());
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            "Text Format".toUpperCase(),
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
        Obx(
          () => SwitchListTile(
            title: const Text("Arabic text"),
            value: readerStoreController.showArabicText.value,
            onChanged: ((value) {
              readerStoreController.setShowArabicText(value);
            }),
            inactiveThumbColor: Colors.grey,
            inactiveTrackColor: Colors.grey.withAlpha(100),
          ),
        ),
        Obx(
          () => SwitchListTile(
            title: const Text("Transliteration"),
            value: readerStoreController.showTransliteration.value,
            onChanged: ((value) {
              readerStoreController.setTransliteration(value);
            }),
            inactiveThumbColor: Colors.grey,
            inactiveTrackColor: Colors.grey.withAlpha(100),
          ),
        ),
        Obx(
          () => SwitchListTile(
            title: const Text("Translation"),
            value: readerStoreController.showTranslation.value,
            onChanged: ((value) {
              readerStoreController.setTranslation(value);
            }),
            inactiveThumbColor: Colors.grey,
            inactiveTrackColor: Colors.grey.withAlpha(100),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            "Text Size".toUpperCase(),
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
        Obx(() => Slider(
              value: readerStoreController.fontSize.value,
              onChanged: readerStoreController.setFontSize,
              min: 8,
              max: 24,
              divisions: 8,
              label: readerStoreController.fontSize.value.toInt().toString(),
            ))
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
          context: context,
          builder: ((context) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                color: Theme.of(context).canvasColor,
              ),
              child: Column(
                children: const [
                  HandleBar(),
                  TextSettings(),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}

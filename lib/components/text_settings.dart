import 'package:din/util/store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextSettings extends StatelessWidget {
  const TextSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsStoreController settingsStoreController =
        Get.put(SettingsStoreController());
    return Column(
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
            value: settingsStoreController.showArabicText.value,
            onChanged: ((value) {
              settingsStoreController.setShowArabicText(value);
            }),
            inactiveThumbColor: Colors.grey,
            inactiveTrackColor: Colors.grey.withAlpha(100),
          ),
        ),
        Obx(
          () => SwitchListTile(
            title: const Text("Transliteration"),
            value: settingsStoreController.showTransliteration.value,
            onChanged: ((value) {
              settingsStoreController.setTransliteration(value);
            }),
            inactiveThumbColor: Colors.grey,
            inactiveTrackColor: Colors.grey.withAlpha(100),
          ),
        ),
        Obx(
          () => SwitchListTile(
            title: const Text("Translation"),
            value: settingsStoreController.showTranslation.value,
            onChanged: ((value) {
              settingsStoreController.setTranslation(value);
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
              value: settingsStoreController.fontSize.value,
              onChanged: settingsStoreController.setFontSize,
              min: 8,
              max: 24,
              divisions: 8,
              label: settingsStoreController.fontSize.value.toInt().toString(),
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
              child: const TextSettings(),
            );
          }),
        );
      },
    );
  }
}

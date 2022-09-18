import 'package:din/util/store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextToggles extends StatelessWidget {
  const TextToggles({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsStoreController settingsStoreController =
        Get.put(SettingsStoreController());

    return PopupMenuButton(itemBuilder: ((context) {
      return <PopupMenuItem>[
        PopupMenuItem(
          child: Obx(
            () => CheckboxListTile(
                title: const Text("Arabic text"),
                value: settingsStoreController.showArabicText.value,
                onChanged: (value) {
                  settingsStoreController.setShowArabicText(value!);
                }),
          ),
        ),
        PopupMenuItem(
          child: Obx(
            () => CheckboxListTile(
                title: const Text("Transliteration"),
                value: settingsStoreController.showTransliteration.value,
                onChanged: (value) {
                  settingsStoreController.setTransliteration(value!);
                }),
          ),
        ),
        PopupMenuItem(
          child: Obx(() => CheckboxListTile(
              title: const Text("Translation"),
              value: settingsStoreController.showTranslation.value,
              onChanged: (value) {
                settingsStoreController.setTranslation(value!);
              })),
        ),
      ];
    }));
  }
}

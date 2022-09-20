import 'package:din/util/store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextSettings extends StatelessWidget {
  const TextSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsStoreController settingsStoreController =
        Get.put(SettingsStoreController());

    return IconButton(
      icon: const Icon(Icons.text_format_rounded),
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: ((context) {
              return Container();
            }));
      },
    );
  }
}

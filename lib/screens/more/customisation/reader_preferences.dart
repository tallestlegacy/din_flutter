import 'package:din/widgets/font_setting.dart';
import 'package:din/widgets/theme_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/widgets/back_button.dart';
import '/widgets/text_settings.dart';
import '/widgets/verse.dart';
import '/utils/store.dart';

class ReaderPreferences extends StatelessWidget {
  ReaderPreferences({super.key});
  final ReaderStoreController readerStoreController =
      Get.put(ReaderStoreController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reader preferences"),
        leading: const CustomBackButton(),
        //backgroundColor: Theme.of(context).backgroundColor,
        elevation: 1,
        actions: const [ThemeToggleButton()],
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: VersePreview(),
          ),
          const Divider(),
          const FontSetting(),
          const Divider(),
          const TextSettings(),
          const Divider(),
          Obx(
            () => SwitchListTile(
              value: readerStoreController.reverseScrolling.value,
              onChanged: (bool? value) =>
                  readerStoreController.setReverseScrolling(value!),
              title: ListTile(
                contentPadding: const EdgeInsets.all(0),
                minVerticalPadding: 0,
                minLeadingWidth: 0,
                title: const Text("Reverse page scroll direction"),
                leading: Icon(
                  readerStoreController.reverseScrolling.value
                      ? Icons.swipe_right_rounded
                      : Icons.swipe_left_rounded,
                ),
              ),
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.grey.withAlpha(100),
            ),
          ),
        ],
      ),
    );
  }
}

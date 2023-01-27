import 'package:din/widgets/theme_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/widgets/back_button.dart';
import '/widgets/verse.dart';
import '/utils/store.dart';
import '../../../widgets/theme_toggle_action.dart';

class Appearance extends StatelessWidget {
  const Appearance({super.key});

  @override
  Widget build(BuildContext context) {
    final AppearanceStoreController appearanceStoreController =
        Get.put(AppearanceStoreController());

    Widget getColors(bool isDarkMode) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(16),
        child: Wrap(
          direction: Axis.horizontal,
          spacing: 12,
          children: [
            for (MaterialColor color in appearanceStoreController.colors)
              ThemePreview(color: color, isDarkMode: isDarkMode)
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Appearance"),
        actions: const [ThemeToggleAction()],
        elevation: 1,
        leading: const CustomBackButton(),
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: VersePreview(),
          ),
          const Divider(),
          Column(
            children: [
              ListTile(
                leading: const Icon(Icons.light_mode_outlined),
                title: Text(
                  "Light mode theme",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
              getColors(false),
            ],
          ),
          const Divider(),
          Column(
            children: [
              ListTile(
                leading: const Icon(Icons.dark_mode_outlined),
                title: Text(
                  "Dark mode theme",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
              getColors(true),
            ],
          )
        ],
      ),
    );
  }
}

import 'package:din/widgets/theme_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: Theme.of(context).colorScheme.primary,
      ),
      child: Scaffold(
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
                    "Light mode theme : ${appearanceStoreController.swatchName}",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
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
                    "Dark mode theme: ${appearanceStoreController.darkSwatchName}",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ),
                getColors(true),
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/widgets/back_button.dart';
import '/widgets/verse.dart';
import '/utils/store.dart';
import '/utils/theme.dart';
import '/widgets/theme_toggle_button.dart';

class Appearance extends StatelessWidget {
  const Appearance({super.key});

  @override
  Widget build(BuildContext context) {
    final AppearanceStoreController appearanceStoreController =
        Get.put(AppearanceStoreController());

    Widget getColors(bool isDarkMode) {
      return SingleChildScrollView(
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          crossAxisAlignment: WrapCrossAlignment.center,
          runAlignment: WrapAlignment.center,
          children: [
            for (MaterialColor color in appearanceStoreController.colors)
              SizedBox(
                height: 40,
                width: 40,
                child: Obx(
                  () => GestureDetector(
                    onTap: () {
                      if (isDarkMode) {
                        appearanceStoreController.setDarkSwatch(color);
                      } else {
                        appearanceStoreController.setSwatch(color);
                      }

                      appearanceStoreController.setForceDarkMode(isDarkMode);

                      Get.changeThemeMode(ThemeMode.light);
                      Get.changeTheme(
                          Styles(swatch: color, isDarkMode: isDarkMode)
                              .themeData);
                    },
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: color,
                        border: Border.all(
                          color: color ==
                                  (isDarkMode
                                      ? appearanceStoreController
                                          .darkSwatch.value
                                      : appearanceStoreController.swatch.value)
                              ? color.shade200
                              : Colors.transparent,
                          width: 5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Appearance"),
        actions: const [ThemeToggleButton()],
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
          ListTile(
            leading: const Icon(Icons.light_mode_outlined),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                "Light mode accent",
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
            subtitle: getColors(false),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.dark_mode_outlined),
            title: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                "Dark mode accent",
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
            subtitle: getColors(true),
          )
        ],
      ),
    );
  }
}

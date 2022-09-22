import 'package:din/components/back_button.dart';
import 'package:din/components/verse.dart';
import 'package:din/util/store.dart';
import 'package:din/util/theme.dart';
import 'package:din/widgets/theme_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Appearance extends StatelessWidget {
  const Appearance({super.key});

  @override
  Widget build(BuildContext context) {
    final AppearanceStoreController appearanceStoreController =
        Get.put(AppearanceStoreController());

    Widget getColors(bool isDarkMode) {
      return Wrap(
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

                    Get.changeThemeMode(ThemeMode
                        .light); // FIXME PlatfrmIsDarkMode automatic change
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
                                    ? appearanceStoreController.darkSwatch.value
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
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Appearance"),
        actions: const [ThemeToggleButton()],
        backgroundColor: Theme.of(context).backgroundColor,
        leading: const CustomBackButton(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: VersePreview(),
              ),
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
      ),
    );
  }
}

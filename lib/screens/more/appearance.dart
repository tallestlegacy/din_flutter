import 'package:din/components/verse.dart';
import 'package:din/util/store.dart';
import 'package:din/util/theme.dart';
import 'package:din/widgets/theme_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class Appearance extends StatelessWidget {
  const Appearance({super.key});

  @override
  Widget build(BuildContext context) {
    final AppearanceStoreController appearanceStoreController =
        Get.put(AppearanceStoreController());

    Widget getColors(bool isDark) {
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
                    bool darkModeIsSet = Get.isDarkMode;

                    if (isDark) {
                      appearanceStoreController.setDarkSwatch(color);
                    } else {
                      appearanceStoreController.setSwatch(color);
                    }

                    if (isDark == darkModeIsSet) {
                      Get.changeTheme(
                          Styles(swatch: color, isDarkMode: isDark).themeData);
                    }
                  },
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: color,
                      border: Border.all(
                        color: color ==
                                (isDark
                                    ? appearanceStoreController.darkSwatch.value
                                    : appearanceStoreController.swatch.value)
                            ? Theme.of(context).primaryColor
                            : Colors.transparent,
                        width: 3,
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
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                      width: 2, color: Theme.of(context).backgroundColor),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Verse(
                    verse: {
                      "id": 1,
                      "text": "بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيمِ",
                      "translation":
                          "In the name of Allah, the Entirely Merciful, the Especially Merciful",
                      "transliteration": "Bismi Allahi alrrahmani alrraheemi"
                    },
                  ),
                ),
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.light_mode_outlined),
              title: getColors(false),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.dark_mode_outlined),
              title: getColors(true),
            )
          ],
        ),
      ),
    );
  }
}

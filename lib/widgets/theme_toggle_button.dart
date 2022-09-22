import 'package:din/util/store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({Key? key}) : super(key: key);

  @override
  build(BuildContext context) {
    final AppearanceStoreController appearanceStoreController =
        Get.put(AppearanceStoreController());

    return IconButton(
      onPressed: () {
        Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
        appearanceStoreController.setForceDarkMode(!Get.isDarkMode);
      },
      icon: Obx(
        () => Icon(
          appearanceStoreController.forceDarkMode.value
              ? Icons.brightness_4_rounded
              : Icons.brightness_5_rounded,
        ),
      ),
    );
  }
}

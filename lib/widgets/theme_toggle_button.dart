import 'package:din/util/store.dart';
import 'package:din/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeToggleButton extends StatefulWidget {
  const ThemeToggleButton({Key? key}) : super(key: key);

  @override
  State<ThemeToggleButton> createState() => _ThemeToggleButtonState();
}

class _ThemeToggleButtonState extends State<ThemeToggleButton> {
  bool _isDarkMode = Get.isDarkMode;
  final AppearanceStoreController appearanceStoreController =
      Get.put(AppearanceStoreController());

  @override
  build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Get.isDarkMode
            ? Get.changeTheme(
                Styles(swatch: appearanceStoreController.swatch.value)
                    .themeData)
            : Get.changeTheme(Styles(
                    isDarkMode: true,
                    swatch: appearanceStoreController.darkSwatch.value)
                .themeData);

        setState(() {
          _isDarkMode = !Get.isDarkMode;
        });
      },
      icon: Icon(
          _isDarkMode ? Icons.dark_mode_rounded : Icons.light_mode_rounded),
    );
  }
}

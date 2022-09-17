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

  @override
  build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Get.isDarkMode
            ? Get.changeTheme(Styles.themeData(false, context))
            : Get.changeTheme(Styles.themeData(true, context));

        setState(() {
          _isDarkMode = !Get.isDarkMode;
        });
      },
      icon: Icon(
          _isDarkMode ? Icons.dark_mode_rounded : Icons.light_mode_outlined),
    );
  }
}

import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkMode, BuildContext context) {
    return ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: isDarkMode ? Colors.white : Colors.black,
      primaryColorLight: isDarkMode ? Colors.blueGrey : Colors.grey,
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      primaryIconTheme: const IconThemeData(color: Colors.white),
      appBarTheme: AppBarTheme(
        backgroundColor: isDarkMode ? Colors.blueGrey : Colors.blue,
      ),
      useMaterial3: true,
    );
  }
}

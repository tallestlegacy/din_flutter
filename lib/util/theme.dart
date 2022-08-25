import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkMode, BuildContext context) {
    return ThemeData(
      primarySwatch: isDarkMode ? Colors.blueGrey : Colors.blue,
      primaryTextTheme: TextTheme(
        bodyText1: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
        bodyText2: TextStyle(color: isDarkMode ? Colors.blueGrey : Colors.grey),
      ),
      primaryColor: Colors.blue,
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      primaryIconTheme: const IconThemeData(color: Colors.white),
      appBarTheme: AppBarTheme(
        backgroundColor: isDarkMode ? Colors.blueGrey : Colors.blue,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      tabBarTheme: const TabBarTheme(labelColor: Colors.white),
      useMaterial3: true,
    );
  }
}

import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkMode, BuildContext context) {
    MaterialColor primarySwatch = isDarkMode ? Colors.blueGrey : Colors.indigo;

    Color themeColor = Colors.blueGrey;

    Color? accentColor = primarySwatch[200];
    Color? darkAccent = primarySwatch[900];
    Color? backgroundColor = isDarkMode ? Colors.black54 : primarySwatch[50];
    Color? cardColor = isDarkMode ? Colors.grey[800] : Colors.white;
    Color? textColor = isDarkMode ? primarySwatch[800] : primarySwatch[900];

    return ThemeData(
      backgroundColor: backgroundColor,
      primarySwatch: primarySwatch,
      primaryTextTheme: TextTheme(
        bodyText1: TextStyle(color: isDarkMode ? Colors.white : Colors.black87),
        bodyText2:
            TextStyle(color: isDarkMode ? primarySwatch[200] : Colors.grey),
      ),
      primaryColor: primarySwatch,
      primaryColorDark: primarySwatch[900],
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      primaryIconTheme: const IconThemeData(color: Colors.white),
      appBarTheme: AppBarTheme(
        backgroundColor: accentColor,
        titleTextStyle: TextStyle(color: textColor, fontSize: 20),
        iconTheme: IconThemeData(color: textColor),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: accentColor,
        selectedItemColor: darkAccent,
        unselectedItemColor: darkAccent,
      ),
      tabBarTheme: TabBarTheme(
        labelColor: textColor,
      ),
      useMaterial3: true,
      cardTheme: CardTheme(
        color: cardColor,
      ),
      iconTheme: IconThemeData(
        color: accentColor,
      ),
      accentColor: accentColor,
    );
  }
}

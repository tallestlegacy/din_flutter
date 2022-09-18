import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkMode, BuildContext context) {
    MaterialColor primarySwatch = isDarkMode ? Colors.blueGrey : Colors.indigo;

    Color? accentColor = primarySwatch[200];
    Color? backgroundColor = isDarkMode ? Colors.grey[900] : primarySwatch[50];
    Color? cardColor = isDarkMode ? Colors.grey[850] : Colors.white;

    ColorScheme colorScheme = ColorScheme(
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      primary: primarySwatch,
      onPrimary: primarySwatch.shade900,
      secondary: isDarkMode ? Colors.grey.shade800 : primarySwatch.shade200,
      onSecondary: isDarkMode ? Colors.grey.shade300 : primarySwatch.shade900,
      tertiary: primarySwatch.shade400,
      onTertiary: primarySwatch.shade600,
      error: Colors.amber,
      onError: Colors.red,
      background: isDarkMode ? Colors.grey.shade900 : primarySwatch.shade50,
      onBackground: Colors.indigoAccent,
      surface: isDarkMode ? Colors.grey.shade700 : primarySwatch.shade200,
      onSurface: isDarkMode ? Colors.white : primarySwatch.shade900,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      primaryColor: accentColor,
      primarySwatch: primarySwatch,
      primaryTextTheme: TextTheme(
        bodyText1: TextStyle(color: isDarkMode ? Colors.white : Colors.black87),
        bodyText2: TextStyle(
            color: isDarkMode ? primarySwatch[200] : Colors.grey,
            fontFamily: "Naskh"),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.secondary,
        titleTextStyle: TextStyle(color: colorScheme.onSecondary, fontSize: 20),
        iconTheme: IconThemeData(color: colorScheme.onSecondary),
        scrolledUnderElevation: 10,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.secondary,
        selectedItemColor: colorScheme.onSecondary,
        unselectedItemColor: colorScheme.onSecondary,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        enableFeedback: true,
      ),
      tabBarTheme: TabBarTheme(
        labelColor: colorScheme.onSecondary,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
      cardTheme: CardTheme(
          color: cardColor,
          elevation: 0.5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      iconTheme: IconThemeData(
        color: accentColor,
      ),
      listTileTheme: const ListTileThemeData(
        dense: true,
        minLeadingWidth: 4,
        minVerticalPadding: 16,
      ),
      scaffoldBackgroundColor: backgroundColor,
      textTheme: TextTheme(
        headline6: TextStyle(
            fontSize: 16, color: isDarkMode ? primarySwatch[200] : Colors.grey),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStatePropertyAll(primarySwatch),
        checkColor: const MaterialStatePropertyAll(Colors.white),
      ),
    );
  }
}

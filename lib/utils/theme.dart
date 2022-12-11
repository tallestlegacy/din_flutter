import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Styles {
  MaterialColor swatch;
  bool isDarkMode;

  Styles({
    this.isDarkMode = false,
    this.swatch = Colors.blue,
  });

  ThemeData get themeData {
    MaterialColor primarySwatch = swatch;

    Color? accentColor = primarySwatch[200];
    Color? backgroundColor = isDarkMode ? Colors.grey[900] : primarySwatch[50];
    Color? cardColor = isDarkMode ? Colors.grey[850] : Colors.white;

    ColorScheme colorScheme = ColorScheme(
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      primary: primarySwatch,
      onPrimary: primarySwatch.shade900,
      secondary: isDarkMode ? Colors.grey.shade800 : primarySwatch.shade200,
      onSecondary: isDarkMode ? Colors.grey.shade300 : primarySwatch.shade900,
      tertiary: isDarkMode ? primarySwatch.shade200 : primarySwatch.shade600,
      onTertiary: isDarkMode ? Colors.white : Colors.white,
      error: Colors.amber,
      onError: Colors.red,
      background: isDarkMode ? Colors.grey.shade900 : primarySwatch.shade50,
      onBackground: Colors.indigoAccent,
      surface: isDarkMode ? Colors.grey.shade700 : primarySwatch.shade200,
      onSurface: isDarkMode ? primarySwatch.shade50 : primarySwatch.shade900,
    );

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: colorScheme.tertiary,
    ));

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      primaryColor: accentColor,
      primarySwatch: primarySwatch,
      primaryTextTheme: TextTheme(
        bodyText1: TextStyle(color: isDarkMode ? Colors.white : Colors.black87),
        bodyText2: TextStyle(
          color: isDarkMode ? primarySwatch[100] : Colors.black.withAlpha(100),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundColor,
        titleTextStyle: TextStyle(
          color: colorScheme.onSecondary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: colorScheme.onSecondary),
        scrolledUnderElevation: 1,
        shadowColor: primarySwatch.shade100,
        surfaceTintColor: primarySwatch,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.secondary,
        selectedItemColor: colorScheme.onSecondary,
        unselectedItemColor: colorScheme.onSecondary,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        enableFeedback: true,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: colorScheme.secondary,
        labelTextStyle:
            MaterialStatePropertyAll(TextStyle(color: colorScheme.onSurface)),
        elevation: 1,
        indicatorColor: colorScheme.onSecondary.withAlpha(50),
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: isDarkMode ? colorScheme.secondary : Colors.white,
        elevation: 2,
        indicatorColor: colorScheme.onSecondary.withAlpha(50),
        // /labelType: NavigationRailLabelType.selected,
      ),
      tabBarTheme: TabBarTheme(
        labelColor: colorScheme.onSecondary,
        indicatorSize: TabBarIndicatorSize.label,
      ),
      cardTheme: CardTheme(
          color: cardColor,
          elevation: 0.5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
      iconTheme: IconThemeData(
        color: accentColor,
      ),
      listTileTheme: ListTileThemeData(
        dense: true,
        minLeadingWidth: 4,
        minVerticalPadding: 16,
        iconColor: accentColor,
      ),
      scaffoldBackgroundColor: backgroundColor,
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
              side: MaterialStatePropertyAll(
        BorderSide(color: primarySwatch),
      ))),
      textTheme: TextTheme(
        headline6: TextStyle(
          fontSize: 16,
          color: primarySwatch[200],
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStatePropertyAll(primarySwatch),
        checkColor: const MaterialStatePropertyAll(Colors.white),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return primarySwatch;
          }

          return Colors.grey.withAlpha(100);
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return primarySwatch.withAlpha(50);
          }
          return Colors.grey.withAlpha(100);
        }),
      ),
      sliderTheme: SliderThemeData(
        thumbColor: isDarkMode ? Colors.white : primarySwatch,
        activeTrackColor: primarySwatch.shade300,
        inactiveTrackColor: isDarkMode
            ? primarySwatch.shade100.withAlpha(50)
            : primarySwatch.shade100,
        valueIndicatorColor: accentColor,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorScheme.primary,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: colorScheme.surface.withAlpha(100),
      ),
    );
  }
}

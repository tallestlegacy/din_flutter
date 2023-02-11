import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Styles {
  MaterialColor swatch;
  bool isDarkMode;

  Styles({
    this.isDarkMode = false,
    this.swatch = Colors.blue,
  });

  get bodyText1 => TextStyle(color: isDarkMode ? Colors.white : Colors.black87);
  get bodyText2 =>
      TextStyle(color: isDarkMode ? swatch[100] : Colors.black.withAlpha(100));

  ThemeData get themeData {
    MaterialColor primarySwatch = swatch;

    Color? accentColor = primarySwatch[200];
    Color? text2 =
        isDarkMode ? primarySwatch[100] : Colors.black.withAlpha(100);
    Color? cardColor = isDarkMode ? Colors.grey[850] : Colors.white;

    ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: swatch,
    );

    Color? backgroundColor =
        isDarkMode ? colorScheme.onSurface : colorScheme.secondaryContainer;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: colorScheme.primary,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: swatch,
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      splashColor: colorScheme.primary.withAlpha(20),
      primaryTextTheme: TextTheme(
        bodySmall: TextStyle(color: isDarkMode ? Colors.white : Colors.black87),
        bodyMedium: TextStyle(
          color:
              isDarkMode ? colorScheme.primaryContainer : colorScheme.secondary,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        backgroundColor: backgroundColor,
        elevation: 2,
      ),
      cardTheme: CardTheme(
        color: isDarkMode
            ? colorScheme.primaryContainer.withAlpha(20)
            : colorScheme.onPrimaryContainer.withAlpha(20),
        elevation: .5,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: Colors.grey.withAlpha(20),
      ),
      listTileTheme: ListTileThemeData(
        dense: true,
        minLeadingWidth: 4,
        minVerticalPadding: 16,
        iconColor: colorScheme.secondary,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colorScheme.primary,
        contentTextStyle: TextStyle(
          color: colorScheme.onPrimary,
        ),
        actionTextColor: colorScheme.onPrimary,
      ),
      iconTheme: IconThemeData(
        color: colorScheme.secondary,
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStatePropertyAll(colorScheme.secondary),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
              side: MaterialStatePropertyAll(
        BorderSide(color: primarySwatch),
      ))),
      appBarTheme: AppBarTheme(
        scrolledUnderElevation: 1,
        shadowColor: isDarkMode
            ? primarySwatch.shade100.withAlpha(100)
            : primarySwatch.shade100,
        backgroundColor: backgroundColor,
      ),
      scaffoldBackgroundColor: backgroundColor,
      switchTheme: SwitchThemeData(
        thumbIcon: MaterialStateProperty.resolveWith<Icon?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return const Icon(Icons.check);
            }
          },
        ),
      ),
    );

    // // ignore: dead_code
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
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
        shadowColor: isDarkMode
            ? primarySwatch.shade100.withAlpha(100)
            : primarySwatch.shade100,
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
      radioTheme: RadioThemeData(
        fillColor: MaterialStatePropertyAll(accentColor),
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
        fillColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return isDarkMode ? Colors.grey.shade500 : Colors.grey.shade400;
          }
          return primarySwatch;
        }),
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

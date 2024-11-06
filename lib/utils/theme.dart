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
        fillColor: WidgetStatePropertyAll(colorScheme.secondary),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
              side: WidgetStatePropertyAll(
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
        thumbIcon: WidgetStateProperty.resolveWith<Icon?>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return const Icon(Icons.check);
            }
            return null;
          },
        ),
      ),
    );
  }
}

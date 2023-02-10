import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/utils/theme.dart';
import '/utils/store.dart';

class ThemePreview extends StatelessWidget {
  final bool isDarkMode;
  final MaterialColor color;

  ThemePreview({super.key, this.isDarkMode = false, required this.color});

  final AppearanceStoreController appearanceStoreController =
      Get.put(AppearanceStoreController());

  bool get selected =>
      color ==
      (isDarkMode
          ? appearanceStoreController.darkSwatch.value
          : appearanceStoreController.swatch.value);

  @override
  Widget build(BuildContext context) {
    ThemeData themeData =
        Styles(isDarkMode: isDarkMode, swatch: color).themeData;

    Color? cardColor = themeData.cardTheme.color;
    Color? backgroundColor = themeData.scaffoldBackgroundColor;
    Color? textColor = themeData.textTheme.bodySmall!.color!.withAlpha(70);
    Color? bottomBar = themeData.colorScheme.primary;
    Color? selectedTextColor = color;

    Container textDecoration(double scalar1, double scalar2) => Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(1)),
            color: selected ? selectedTextColor : textColor,
          ),
          height: 1,
          width: scalar1 * scalar2,
        );

    return SizedBox(
      height: 150,
      width: 80,
      child: Obx(
        () => GestureDetector(
          onTap: () {
            if (isDarkMode) {
              appearanceStoreController.setDarkSwatch(color);
            } else {
              appearanceStoreController.setSwatch(color);
            }

            appearanceStoreController.setForceDarkMode(isDarkMode);

            Get.changeThemeMode(ThemeMode.light);
            Get.changeTheme(
                Styles(swatch: color, isDarkMode: isDarkMode).themeData);
          },
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: color,
              border: Border.all(
                color: isDarkMode
                    ? selected
                        ? color.shade400
                        : color.shade100
                    : selected
                        ? color.shade600
                        : color.shade200,
                width: 2,
                style: BorderStyle.solid,
                strokeAlign: 1,
              ),
            ),
            child: Container(
              color: backgroundColor,
              child: Column(
                children: [
                  Container(
                    height: 16,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: color.withAlpha(30),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.check_circle_rounded,
                          color: selected ? color : Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Flex(
                      direction: Axis.vertical,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (double i in [6, 4, 14, 5, 3])
                          Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 8),
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: cardColor,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4)),
                            ),
                            child: Wrap(
                              spacing: 2,
                              runSpacing: 2,
                              children: [
                                textDecoration(100, 1),
                                textDecoration(3, i * i),
                                textDecoration(5, i),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                  Container(height: 16, color: bottomBar)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

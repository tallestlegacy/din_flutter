import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '/screens/app.dart';
import 'utils/store.dart';
import 'utils/theme.dart';

void main() async {
  await GetStorage.init();
  runApp(const DinFlutterApp());
}

class DinFlutterApp extends StatelessWidget {
  const DinFlutterApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AppearanceStoreController appearanceStoreController =
        Get.put(AppearanceStoreController());

    bool forceDarkMode = appearanceStoreController.forceDarkMode.value;

    return GetMaterialApp(
      title: "Din",
      debugShowCheckedModeBanner: false,
      home: const App(),
      theme: Styles(
        isDarkMode: forceDarkMode,
        swatch: forceDarkMode
            ? appearanceStoreController.darkSwatch.value
            : appearanceStoreController.swatch.value,
      ).themeData,
      darkTheme: Styles(
        isDarkMode: true,
        swatch: appearanceStoreController.darkSwatch.value,
      ).themeData,
      themeMode: ThemeMode.system,
    );
  }
}

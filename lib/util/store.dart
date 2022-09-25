import 'package:din/util/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsStoreController extends GetxController {
  var showTranslation = true.obs;
  var showTransliteration = true.obs;
  var showArabicText = true.obs;
  var fontSize = 12.0.obs;

  final box = GetStorage();

  void setTransliteration(bool value) {
    showTransliteration(value);
    box.write("showTransliteration", value);
  }

  void setTranslation(bool value) {
    showTranslation(value);
    box.write("showTranslation", value);

    if (value == false) showArabicText(true);
    box.write("showArabicText", true);
  }

  void setShowArabicText(bool value) {
    showArabicText(value);
    box.write("showArabicText", value);

    if (value == false) showTranslation(true);
    box.write("showTranslation", true);
  }

  void setFontSize(double value) {
    fontSize(value);
    box.write("fontSize", value);
  }

  SettingsStoreController() {
    showTransliteration(box.read("showTransliteration") ?? true);
    showTranslation(box.read("showTranslation") ?? true);
    showArabicText(box.read("showArabicText") ?? true);
    fontSize(box.read("fontSize") ?? 12);
  }
}

class AppearanceStoreController extends GetxController {
  var swatch = Colors.blue.obs;
  var darkSwatch = Colors.blue.obs;
  var forceDarkMode = false.obs;

  List<MaterialColor> get colors => <MaterialColor>[
        Colors.blue,
        Colors.cyan,
        Colors.indigo,
        Colors.purple,
        Colors.pink,
        Colors.red,
        Colors.deepOrange,
        Colors.orange,
        Colors.yellow,
        Colors.lime,
        Colors.lightGreen,
        Colors.green,
        Colors.teal,
        Colors.brown,
        Colors.grey,
        Colors.blueGrey,
      ];

  MaterialColor resolver() {
    return Colors.blue;
  }

  final box = GetStorage();

  void setSwatch(MaterialColor color) {
    swatch(color);
    box.write("swatch", colors.indexOf(color));
  }

  void setDarkSwatch(MaterialColor color) {
    darkSwatch(color);
    box.write("darkSwatch", colors.indexOf(color));
  }

  void setForceDarkMode(bool value) {
    box.write("forceDarkMode", value);
    forceDarkMode(value);

    Get.isDarkMode
        ? Get.changeTheme(Styles(swatch: swatch.value).themeData)
        : Get.changeTheme(
            Styles(isDarkMode: true, swatch: darkSwatch.value).themeData);
  }

  AppearanceStoreController() {
    swatch(colors[box.read("swatch") ?? 0]);
    darkSwatch(colors[box.read("darkSwatch") ?? 0]);
    forceDarkMode(box.read("forceDarkMode") ?? false);
  }
}

class GlobalStoreController extends GetxController {
  final box = GetStorage();
  var lastSurahIndex = 0.obs;

  void setLastSurahIndex(int pageIndex) {
    lastSurahIndex(pageIndex);
    box.write("lastSurahIndex", pageIndex);
  }

  GlobalStoreController() {
    lastSurahIndex(box.read("lastSurahIndex") ?? 0);
  }
}

class DebugController extends GetxController {
  final box = GetStorage();
  var countObs = 0.obs;
  int get count => box.read("count") ?? 0;
  increment(int val) {
    if (kDebugMode) {
      print("Incrementing >> ${val + 1}");
    }
    box.write("count", val + 1);
    countObs(val + 1);
  }

  DebugController() {
    countObs(box.read("count") ?? 0);
  }
}

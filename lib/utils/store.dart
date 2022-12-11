import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '/constants/strings.dart';
import '/utils/json.dart';
import '/utils/network.dart';
import '/utils/theme.dart';

/// Reader Store Controller
/// manages the reading experience for users

class ReaderStoreController extends GetxController {
  var showTranslation = true.obs;
  var showTransliteration = true.obs;
  var showArabicText = true.obs;
  var fontSize = 12.0.obs;
  var reverseScrolling = true.obs;
  var arabicFont = "".obs;

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

  void setArabicFont(String value) {
    arabicFont(value);
    box.write("arabicFont", value);
  }

  void setReverseScrolling(bool value) {
    reverseScrolling(value);
    box.write("reverseScrolling", value);
  }

  ReaderStoreController() {
    showTransliteration(box.read("showTransliteration") ?? true);
    showTranslation(box.read("showTranslation") ?? true);
    showArabicText(box.read("showArabicText") ?? true);
    fontSize(box.read("fontSize") ?? 12);
    reverseScrolling(box.read("reverseScrolling") ?? true);
    arabicFont(box.read("arabicFont") ?? arabicFonts[0]);
  }
}

/// Appearance Store Controller
/// manages teh app theme
class AppearanceStoreController extends GetxController {
  var swatch = Colors.blue.obs;
  var darkSwatch = Colors.blue.obs;
  var forceDarkMode = false.obs;

  List<MaterialColor> get colors => <MaterialColor>[
        Colors.blue,
        Colors.cyan,
        Colors.indigo,
        Colors.deepPurple,
        Colors.purple,
        Colors.pink,
        Colors.red,
        Colors.deepOrange,
        Colors.orange,
        Colors.amber,
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

/// Global Store Controller
/// Collects general user interaction info

class GlobalStoreController extends GetxController {
  final box = GetStorage();
  var currentSurah = 0.obs;
  RxList favouriteVerses = [].obs;

  RxDouble lat = 0.0.obs;
  RxDouble lon = 0.0.obs;

  RxBool drawerIsOpen = false.obs;

  RxMap<dynamic, dynamic> prayerTimes = {}.obs;

  void setcurrentSurah(int pageIndex) {
    currentSurah(pageIndex);
    box.write("currentSurah", pageIndex);
  }

  void addFavouriteAya(aya) {
    if (!isFavouriteVerse(aya)) {
      favouriteVerses.add(aya);
    } else {
      favouriteVerses.removeWhere((element) =>
          element["id"] == aya["id"] && element["chapter"] == aya["chapter"]);
    }
    favouriteVerses.sort((a, b) => a["id"] - b["id"]);
    favouriteVerses.sort((a, b) => a["chapter"] - b["chapter"]);
    box.write("favouriteVerses", jsonEncode(favouriteVerses));
  }

  bool isFavouriteVerse(aya) {
    bool fav = false;

    for (var a in favouriteVerses) {
      if (a['id'] == aya['id'] && a['chapter'] == aya['chapter']) {
        fav = true;
        break;
      }
    }
    return fav;
  }

  void setLocation(double latitude, double longitude) {
    lat(latitude);
    lon(longitude);
    box.write("lat", lat.value);
    box.write("lon", lon.value);
  }

  void setPrayerTimeForMonth(var data) {
    prayerTimes(data);
    box.write("prayerTimes", jsonEncode(data));
  }

  GlobalStoreController() {
    currentSurah(box.read("currentSurah") ?? 0);
    favouriteVerses(jsonDecode(box.read("favouriteVerses") ?? "[]"));
    lat(box.read("lat") ?? 0.0);
    lat(box.read("lat") ?? 0.0);
    prayerTimes(jsonDecode(box.read("prayerTimes") ?? "{}"));
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

/// Translations store controller
/// stores translations and API data

class TranslationsStoreController extends GetxController {
  var box = GetStorage();

  RxMap defaultTranslation =
      {"language": "en", "edition": "quran-in-english"}.obs;
  RxList quranTranslations = [].obs;
  RxList downloadedQuranEditions = [].obs;

  Future<void> updateQuranTranslations() async {
    var data = await fetchTranslations();
    quranTranslations(data);
    box.write("quranTranslations", jsonEncode(quranTranslations.toJson()));
  }

  bool editionIsDownloaded(String language, String edition) {
    return downloadedQuranEditions.firstWhereOrNull(
            (e) => e["language"] == language && e["edition"] == edition) !=
        null;
  }

  Future<void> saveEdition(String language, String edition, var data) async {
    for (var i = 1; i < data.length; i++) {
      // save to local json
      await writeChapter(language, edition, data[i]);
    }

    downloadedQuranEditions.removeWhere(
        (e) => e["language"] == language && e["edition"] == edition);
    downloadedQuranEditions.add({"language": language, "edition": edition});

    box.write("downloadedQuranEditions", jsonEncode(downloadedQuranEditions));
  }

  dynamic getEditionChapter(String language, String edition, int chapter) {
    return jsonDecode(box.read("quran_$language-$edition-$chapter"));
  }

  void setTranslation(var translation) {
    defaultTranslation(translation);
    box.write("defaultTranslation", jsonEncode(defaultTranslation));
  }

  TranslationsStoreController() {
    quranTranslations(jsonDecode(box.read("quranTranslations") ?? "[]"));
    downloadedQuranEditions(
        jsonDecode(box.read("downloadedQuranEditions") ?? "[]"));

    var tr = jsonDecode(
        box.read("defaultTranslation") ?? jsonEncode(defaultTranslation));

    setTranslation({
      "edition": tr["edition"].toString(),
      "language": tr["language"].toString(),
    });

    if (quranTranslations.isEmpty) updateQuranTranslations();
  }
}

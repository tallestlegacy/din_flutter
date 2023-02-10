import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '/constants/strings.dart';
import '/utils/json.dart';
import '/utils/network.dart';
import '/utils/theme.dart';
import 'location.dart';

/// Reader Store Controller
/// manages the reading experience for users

class ReaderStoreController extends GetxController {
  var showTranslation = true.obs;
  var showTransliteration = true.obs;
  var showArabicText = true.obs;
  var fontSize = 12.0.obs;
  var reverseScrolling = true.obs;
  var ayaSpans = false.obs;
  var arabicFont = arabicFonts[0].obs;
  var ayaEndFont = ayaEndFonts[0].obs;
  var reciter = "Abdul_Basit_Murattal_64kbps".obs;
  var selectedAya = "".obs;

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

  void setAyaEndFont(String value) {
    ayaEndFont(value);
    box.write("ayaEndFont", value);
  }

  void setReverseScrolling(bool value) {
    reverseScrolling(value);
    box.write("reverseScrolling", value);
  }

  void setAyaSpans(bool value) {
    ayaSpans(value);
    box.write("ayaSpans", value);
  }

  void setReciter(String value) {
    reciter(value);
    box.write("reciter", value);
  }

  bool hasSubfolder(List tracks) {
    return tracks
            .indexWhere((element) => element["subfolder"] == reciter.value) !=
        -1;
  }

  void setSelectedAya(String value) {
    selectedAya(value);
  }

  void resetSelectedAya() {
    selectedAya("");
  }

  ReaderStoreController() {
    showTransliteration(box.read("showTransliteration") ?? true);
    showTranslation(box.read("showTranslation") ?? true);
    showArabicText(box.read("showArabicText") ?? true);
    ayaSpans(box.read("ayaSpans") ?? false);
    fontSize(box.read("fontSize") ?? 12);
    reverseScrolling(box.read("reverseScrolling") ?? true);
    arabicFont(box.read("arabicFont") ?? arabicFonts[0]);
    ayaEndFont(box.read("ayaEndFont") ?? ayaEndFonts[0]);
    reciter(box.read("reciter") ?? "Abdul_Basit_Murattal_64kbps");
  }
}

/// Appearance Store Controller
/// manages teh app theme
class AppearanceStoreController extends GetxController {
  var swatch = Colors.blue.obs;
  var darkSwatch = Colors.blue.obs;
  var forceDarkMode = false.obs;

  get swatchName => colorNames[colors.indexOf(swatch.value)];
  get darkSwatchName => colorNames[colors.indexOf(darkSwatch.value)];

  List<String> get colorNames => [
        "blue",
        "cyan",
        "indigo",
        "deepPurple",
        "purple",
        "pink",
        "red",
        "deepOrange",
        "orange",
        "amber",
        "yellow",
        "lime",
        "lightGreen",
        "green",
        "teal",
        "brown",
        "grey",
        "blueGrey",
      ];

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
  RxBool locationInitialised = false.obs;

  RxBool drawerIsOpen = false.obs;

  RxMap<dynamic, dynamic> prayerTimes = {}.obs;

  void setCurrentSurah(int pageIndex) {
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

  Future<String> setLocation() async {
    try {
      Position position = await determinePosition();

      lat(position.latitude);
      lon(position.longitude);
      locationInitialised(true);
      box.write("lat", lat.value);
      box.write("lon", lon.value);
      box.write("locationInitialised", locationInitialised.value);
      return "Location confirmed";
    } catch (e) {
      return "Please enable location services";
    }
  }

  void setPrayerTimeForMonth(Map data) {
    prayerTimes(data);
    box.write("prayerTimes", jsonEncode(data));
  }

  GlobalStoreController() {
    currentSurah(box.read("currentSurah") ?? 0);
    favouriteVerses(jsonDecode(box.read("favouriteVerses") ?? "[]"));
    lat(box.read("lat") ?? 0.0);
    lon(box.read("lon") ?? 0.0);
    locationInitialised(box.read("locationInitialised") ?? false);
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

  RxMap defaultTranslation = {"language": "en", "edition": "default"}.obs;
  RxList quranTranslations = [].obs;
  RxList downloadedQuranEditions = [].obs;

  Future<void> updateQuranTranslations() async {
    var data = await fetchTranslations();
    if (data.isNotEmpty) {
      quranTranslations(data);
      box.write("quranTranslations", jsonEncode(quranTranslations.toJson()));
    }
  }

  bool editionIsDownloaded(String language, String edition) {
    return downloadedQuranEditions.firstWhereOrNull(
            (e) => e["language"] == language && e["edition"] == edition) !=
        null;
  }

  bool editionIsDefault(String language, String edition) {
    return defaultTranslation["language"] == language &&
        defaultTranslation["edition"] == edition;
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

  Future<void> deleteEdition(String language, String edition) async {
    downloadedQuranEditions.removeWhere(
        (e) => e["language"] == language && e["edition"] == edition);
    await deleteEditionFromStorage(language, edition);
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

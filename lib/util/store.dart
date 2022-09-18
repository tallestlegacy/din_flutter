import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsStoreController extends GetxController {
  var showTranslation = true.obs;
  var showTransliteration = true.obs;
  var showArabicText = true.obs;

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

  SettingsStoreController() {
    showTransliteration(box.read("showTransliteration") ?? true);
    showTranslation(box.read("showTranslation") ?? true);
    showArabicText(box.read("showArabicText") ?? true);
  }
}

// TODO : Add accent colors
class AppearanceStoreController extends GetxController {}

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
    print("Incrementing >> ${val + 1}");
    box.write("count", val + 1);
    countObs(val + 1);
  }

  DebugController() {
    countObs(box.read("count") ?? 0);
  }
}

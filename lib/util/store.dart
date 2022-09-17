import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsStoreController extends GetxController {
  var showTranslation = true.obs;
  var showTransliteration = true.obs;

  final box = GetStorage();

  void setTransliteration(bool value) {
    showTransliteration(value);
    box.write("showTransliteration", value);
  }

  void setTranslation(bool value) {
    showTranslation(value);
    box.write("showTransliteration", value);
  }

  SettingsStoreController() {
    showTransliteration(box.read("showTransliteration") ?? true);
    showTranslation(box.read("showTranslation") ?? true);
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
    countObs += box.read("count");
  }
}

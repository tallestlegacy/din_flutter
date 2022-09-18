import 'package:din/components/verse.dart';
import 'package:din/util/store.dart';
import 'package:din/widgets/theme_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final SettingsStoreController settingsStoreController =
        Get.put(SettingsStoreController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Preferences and More"),
        actions: const [ThemeToggleButton()],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: const Icon(Icons.text_format_outlined),
                    title: Text(
                      "Text Preferences".toUpperCase(),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8))),
                    child: const Verse(
                      verse: {
                        "id": 1,
                        "text": "بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيمِ",
                        "translation":
                            "In the name of Allah, the Entirely Merciful, the Especially Merciful",
                        "transliteration": "Bismi Allahi alrrahmani alrraheemi"
                      },
                    ),
                  ),
                  Obx(() => CheckboxListTile(
                      title: const Text("Arabic text"),
                      value: settingsStoreController.showArabicText.value,
                      onChanged: (value) {
                        settingsStoreController.setShowArabicText(value!);
                      })),
                  Obx(() => CheckboxListTile(
                      title: const Text("Transliteration"),
                      value: settingsStoreController.showTransliteration.value,
                      onChanged: (value) {
                        settingsStoreController.setTransliteration(value!);
                      })),
                  Obx(() => CheckboxListTile(
                      title: const Text("Translation"),
                      value: settingsStoreController.showTranslation.value,
                      onChanged: (value) {
                        settingsStoreController.setTranslation(value!);
                      })),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.color_lens_sharp),
                    title: Text(
                      "Appearance".toUpperCase(),
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

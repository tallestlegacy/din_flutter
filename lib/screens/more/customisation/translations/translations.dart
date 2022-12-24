import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'translation.dart';
import '/utils/store.dart';
import '/widgets/back_button.dart';
import '/widgets/theme_toggle_button.dart';

class Translations extends StatelessWidget {
  const Translations({super.key});

  @override
  Widget build(BuildContext context) {
    final TranslationsStoreController translationsStoreController =
        Get.put(TranslationsStoreController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Translations"),
        leading: const CustomBackButton(),
        actions: const [ThemeToggleButton()],
      ),
      body: RefreshIndicator(
        onRefresh: translationsStoreController.updateQuranTranslations,
        child: Obx(
          () => Container(
            child: translationsStoreController.quranTranslations.isEmpty
                ? ListView(
                    padding: const EdgeInsets.all(40),
                    children: [
                      Flex(
                        direction: Axis.vertical,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: const [
                              Icon(Icons.refresh),
                              Icon(
                                Icons.arrow_downward_rounded,
                                size: 12,
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Text(
                                "Ensure network is turned on then pull to refresh.",
                                style: TextStyle(
                                  fontSize: 12,
                                )),
                          ),
                        ],
                      ),
                    ],
                  )
                : ListView(
                    children: [
                      ListTile(
                        title: const Text("Installed"),
                        subtitle: Obx(
                          () => Column(
                            children: [
                              TranslationRadio(translation: const {
                                "edition": "default",
                                "language": "en",
                              }),
                              for (var translation
                                  in translationsStoreController
                                      .downloadedQuranEditions)
                                TranslationRadio(translation: translation)
                            ],
                          ),
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        title: const Text("Available Languages"),
                        subtitle: Column(children: [
                          for (var language
                              in translationsStoreController.quranTranslations)
                            ListTile(
                              leading: Text(language["emoji"],
                                  style: const TextStyle(fontSize: 20)),
                              trailing: const Icon(Icons.chevron_right_rounded),
                              title: Text(language["language"]),
                              subtitle: Text(language["abbrev"]),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(builder: (context) {
                                    return LanguageScreen(
                                        language: Language.fromJson(language));
                                  }),
                                );
                              },
                            )
                        ]),
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class Language {
  String emoji = "🤔";
  String language = "NULL";
  String abbrev = "NULL";
  List editions = [];

  Language({
    required this.emoji,
    required this.language,
    required this.abbrev,
    required this.editions,
  });

  factory Language.fromJson(dynamic json) {
    return Language(
      emoji: json["emoji"],
      language: json["language"],
      abbrev: json["abbrev"],
      editions: json["editions"],
    );
  }
}

class LanguageScreen extends StatelessWidget {
  final Language language;

  LanguageScreen({super.key, required this.language});

  final TranslationsStoreController translationsStoreController =
      Get.put(TranslationsStoreController());

  @override
  Widget build(BuildContext context) {
    List editions = translationsStoreController.quranTranslations.firstWhere(
        (element) => element["abbrev"] == language.abbrev)["editions"];

    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: Text(language.language),
      ),
      body: ListView(
        children: [
          for (String edition in editions)
            Translation(
              edition: edition,
              language: language.abbrev,
            )
        ],
      ),
    );
  }
}

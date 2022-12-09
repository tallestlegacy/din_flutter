// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';
import 'dart:io';
import 'package:din/util/store.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class LoadJson {
  Future load(String path) async {
    final String response = await rootBundle.loadString(path);
    final data = await json.decode(response);
    return data;
  }
}

Future<dynamic> getVerses(int chapter) async {
  var translation;
  TranslationsStoreController translationsStoreController =
      TranslationsStoreController();

  String language = translationsStoreController.defaultTranslation["language"];
  String edition = translationsStoreController.defaultTranslation["edition"];

  if (translationsStoreController.defaultTranslation["edition"] !=
      "quran-in-english") {
    final directory = await getApplicationDocumentsDirectory();
    String path = directory.path;

    final file = File("$path/quran_$language-${edition}_$chapter.json");
    translation = jsonDecode(await file.readAsString());
  } else {
    translation = await LoadJson()
        .load("assets/json/quran_editions/en.quran-in-english/${chapter}.json");
  }

  final text = await LoadJson()
      .load("assets/json/quran_editions/\$.original/${chapter}.json");
  final transliteration = await LoadJson()
      .load("assets/json/quran_editions/\$.transliteration/${chapter}.json");

  var verses = [];

  for (var i = 0; i < text["verses"].length; i++) {
    verses.add({
      "id": i + 1,
      "text": text["verses"][i],
      "translation": translation["verses"][i],
      "transliteration": transliteration["verses"][i],
    });
  }

  return verses;
}

Future<void> writeChapter(String language, String edition, var chapter) async {
  // get directory
  final directory = await getApplicationDocumentsDirectory();
  String path = directory.path;
  final file = File("$path/quran_$language-${edition}_${chapter["id"]}.json");
  print("writing to ${file.path}");
  file.writeAsString(jsonEncode(chapter));
}

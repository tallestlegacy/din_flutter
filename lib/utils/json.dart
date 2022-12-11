// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '/utils/store.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class LoadJson {
  Future load(String path) async {
    final String response = await rootBundle.loadString(path);
    final data = await json.decode(response);
    return data;
  }
}

Future<List> getVerses(int chapter) async {
  // ignore: prefer_typing_uninitialized_variables
  var translation;
  TranslationsStoreController translationsStoreController =
      TranslationsStoreController();

  String language = translationsStoreController.defaultTranslation["language"];
  String edition = translationsStoreController.defaultTranslation["edition"];

  if (translationsStoreController.defaultTranslation["edition"] !=
      "quran-in-english") {
    final directory = await getApplicationDocumentsDirectory();
    String path = directory.path;

    final file = File("$path/quran/$language/$edition/$chapter.json");
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
      "text": text["verses"][i].toString(),
      "translation": translation["verses"][i].toString(),
      "transliteration": transliteration["verses"][i].toString(),
    });
  }

  return verses;
}

Future<void> writeChapter(String language, String edition, var chapter) async {
  // get directory
  final directory = await getApplicationDocumentsDirectory();
  String path = directory.path;

  final folder =
      await Directory("$path/quran/$language/$edition").create(recursive: true);
  final file = File("${folder.path}/${chapter["id"]}.json");

  if (kDebugMode) {
    print("writing to ${file.path}");
  }

  file.writeAsString(jsonEncode(chapter));
}

TextStyle googleFontify(String fontName, TextStyle? style) {
  if (fontName != "") return GoogleFonts.getFont(fontName, textStyle: style);
  return style!;
}

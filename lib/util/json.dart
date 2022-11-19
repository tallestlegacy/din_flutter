// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';
import 'package:flutter/services.dart';

class LoadJson {
  Future load(String path) async {
    final String response = await rootBundle.loadString(path);
    final data = await json.decode(response);
    return data;
  }
}

Future<dynamic> getVerses(int chapter) async {
  final text = await LoadJson()
      .load("assets/json/quran_editions/\$.original/${chapter}.json");
  final transliteration = await LoadJson()
      .load("assets/json/quran_editions/\$.transliteration/${chapter}.json");
  final translation = await LoadJson()
      .load("assets/json/quran_editions/en.quran-in-english/${chapter}.json");

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

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import "package:http/http.dart" as http;

Future<void> openLink(String url) async {
  if (!await launchUrl(
    Uri.parse(url),
    mode: LaunchMode.externalApplication,
  )) {
    throw "Could not launch $url";
  }
}

String editionsUrl = "https://din-99-default-rtdb.firebaseio.com/editions";

Future<List<String>> fetchEditions(String language) async {
  try {
    String url = "$editionsUrl/$language.json?shallow=true";

    var data = (await http.get(Uri.parse(url))).body;

    if (kDebugMode) {
      print(data.toString());
    }
    return (jsonDecode(data).keys.toList());
  } catch (e) {
    if (kDebugMode) {
      print(e.toString());
    }
  }

  return [];
}

Future<dynamic> fetchTranslations() async {
  try {
    String url = "$editionsUrl.json?shallow=true";

    var data = (await http.get(Uri.parse(url))).body;
    List translations = [];
    var iter = jsonDecode(data).keys.toList();

    for (int i = 0; i < iter.length; i++) {
      String language = iter[i];
      List editions = await fetchEditions(language);

      translations.add({
        "language": language,
        "editions": editions,
      });
    }

    translations.sort((a, b) => a["language"].compareTo(b["language"]));
    if (kDebugMode) {
      print(translations.toString());
    }
    return (translations);
  } catch (e) {
    //print(e.toString());
  }

  return [];
}

Future<List> fetchEdition(String language, String edition) async {
  try {
    String url = "$editionsUrl/$language/$edition/chapters.json";

    if (kDebugMode) {
      print("downloading $url");
    }

    var data = (await http.get(Uri.parse(url))).body;
    if (kDebugMode) {
      print(data.toString());
    }
    if (kDebugMode) {
      print("DOWNLOADED >>>>>> $url");
    }

    return (jsonDecode(data));
  } catch (e) {
    if (kDebugMode) {
      print(e.toString());
    }
  }

  return [];
}

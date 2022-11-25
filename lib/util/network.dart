import 'dart:convert';

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

    print(data.toString());
    return (jsonDecode(data).keys.toList());
  } catch (e) {
    print(e.toString());
  }

  return ["NULL"];
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

    print(translations.toString());
    return (translations);
  } catch (e) {
    //print(e.toString());
  }

  return [];
}

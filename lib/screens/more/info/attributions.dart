import 'package:din/utils/network.dart';
import 'package:din/widgets/icons.dart';
import 'package:flutter/material.dart';

class Attributions extends StatelessWidget {
  const Attributions({super.key});

  @override
  Widget build(BuildContext context) {
    final List attributions = [
      {
        "asset": "Open source translation",
        "name": "Quran in English",
        "url": "https://github.com/t-itani/quran-in-english",
      },
      {
        "asset": "Hadith",
        "name": "Complete Sahih Bukhari JSON",
        "url": "https://github.com/essaji/Complete-Sahih-Bukhari-Json",
      },
      {
        "asset": "Translations",
        "name": "Quran Encyclopedia",
        "url": "https://quranenc.com/en/home#transes",
      },
      {
        "asset": "Translations",
        "name": "Kristories/Quran",
        "url": "http://github.com/kristories/quran",
      },
      {
        "asset": "Recitations",
        "name": "Every Aya",
        "url": "https://everyayah.com/recitations_ayat.html",
      },
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Attributions"),
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemBuilder: ((context, index) => ListTile(
                title: Text(attributions[index]["name"].toString()),
                subtitle: Text(attributions[index]["asset"].toString()),
                trailing: linkIcon,
                onTap: () => openLink(attributions[index]["url"].toString()),
              )),
          itemCount: attributions.length,
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ),
      ),
    );
  }
}

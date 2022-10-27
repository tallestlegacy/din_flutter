import 'package:din/components/verse.dart';
import 'package:flutter/material.dart';

import '../util/json.dart';

class Surah extends StatefulWidget {
  final chapter;

  const Surah({Key? key, this.chapter}) : super(key: key);
  @override
  State<Surah> createState() => _SurahState();
}

class _SurahState extends State<Surah> {
  List<dynamic> _verses = [];

  Future<void> getVerses() async {
    final text = await LoadJson().load(
        "assets/json/quran_editions/\$.original/${widget.chapter['id']}.json");
    final transliteration = await LoadJson().load(
        "assets/json/quran_editions/\$.transliteration/${widget.chapter['id']}.json");
    final translation = await LoadJson().load(
        "assets/json/quran_editions/en.quran-in-english/${widget.chapter['id']}.json");

    var verses = [];

    for (var i = 0; i < text["verses"].length; i++) {
      verses.add({
        "id": i + 1,
        "text": text["verses"][i],
        "translation": translation["verses"][i],
        "transliteration": transliteration["verses"][i],
      });
    }
    setState(() {
      _verses = verses;
    });
  }

  @override
  void initState() {
    super.initState();
    getVerses();
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (context, index) => Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Verse(verse: _verses[index]),
            if (index != _verses.length - 1) const Divider()
          ],
        ),
      ),
      childCount: _verses.length,
    ));
  }
}

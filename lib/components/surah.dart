import 'package:din/components/verse.dart';
import 'package:flutter/material.dart';

import '../util/json.dart';

class Surah extends StatefulWidget {
  final chapter;

  Surah({Key? key, this.chapter}) : super(key: key);
  @override
  _SurahState createState() => _SurahState();
}

class _SurahState extends State<Surah> {
  List<dynamic> _verses = [];

  Future<void> getVerses() async {
    final data = await LoadJson()
        .load("assets/json/quran/en/${widget.chapter['id']}.json");
    if (mounted) {
      setState(() {
        _verses = data["verses"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    getVerses();
    return ListView.separated(
      itemCount: _verses.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8),
        child: Verse(verse: _verses[index]),
      ),
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}

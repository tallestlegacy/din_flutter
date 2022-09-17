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
    final data = await LoadJson()
        .load("assets/json/quran/en/${widget.chapter['id']}.json");
    if (mounted) {
      setState(() {
        _verses = data["verses"];
      });
    }
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

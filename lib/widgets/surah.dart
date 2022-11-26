import 'package:flutter/material.dart';

import '/widgets/verse.dart';
import '/util/json.dart';

class Surah extends StatefulWidget {
  final chapter;

  const Surah({Key? key, this.chapter}) : super(key: key);
  @override
  State<Surah> createState() => _SurahState();
}

class _SurahState extends State<Surah> {
  List<dynamic> _verses = [];

  Future<void> initGetVerses() async {
    List<dynamic> verses = await getVerses(widget.chapter["id"]);

    if (mounted) {
      setState(() {
        _verses = verses;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initGetVerses();
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Verse(
              verse: _verses[index],
              chapter: widget.chapter["id"],
            ),
            if (index != _verses.length - 1) const Divider(height: 0)
          ],
        ),
      ),
      childCount: _verses.length,
    ));
  }
}

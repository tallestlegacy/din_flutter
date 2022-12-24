import 'package:din/screens/more/inspiration/juz/juz_data.dart';
import 'package:din/utils/store.dart';
import 'package:din/utils/string_locale.dart';
import 'package:din/widgets/bismi.dart';
import 'package:din/widgets/text_settings.dart';
import 'package:din/widgets/theme_toggle_button.dart';
import 'package:din/widgets/verse.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import "/utils/json.dart";

class JuzReader extends StatefulWidget {
  final int id;
  const JuzReader({super.key, required this.id});

  @override
  State<JuzReader> createState() => _JuzReaderState();
}

class _JuzReaderState extends State<JuzReader> {
  final ReaderStoreController readerStoreController =
      Get.put(ReaderStoreController());

  List _chaptersIndex = [];
  List _chapters = [];
  int _count = 0;

  Future<void> getChapters() async {
    final data =
        await LoadJson().load("assets/json/quran_editions/en.chapters.json");

    Juz thisJuz = Juz.fromJson(juz[widget.id - 1]);

    if (mounted) {
      setState(() {
        _chaptersIndex = data;
      });
    }

    List chapters = [];

    for (int i = 0; i < thisJuz.chapters.length; i++) {
      int chapterId = thisJuz.chapters[i];
      List verses = await getVerses(chapterId);
      int start = thisJuz.verses[chapterId.toString()][0] - 1;
      int end = thisJuz.verses[chapterId.toString()][1];
      verses = verses.sublist(start, end);
      if (mounted) {
        chapters.add(verses);

        setState(() {
          _count += verses.length;
        });
      }
    }

    if (mounted) {
      setState(() {
        _chapters = chapters;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    getChapters();
  }

  @override
  Widget build(BuildContext context) {
    Juz _juz = Juz.fromJson(juz[widget.id - 1]);
    return Scaffold(
      appBar: AppBar(
        actions: const [TextSettingsAction(), ThemeToggleButton()],
        title: Text("${toFarsi(widget.id)} " "   ${_juz.name}"),
      ),
      body: _chapters.isNotEmpty && _chaptersIndex.isNotEmpty
          ? ListView.builder(
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    //* Chapter tag
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: ListTile(
                            leading: Text(
                              "\u06dd${toFarsi(_juz.chapters[index])}",
                              style: googleFontify(
                                "Harmattan",
                                TextStyle(
                                  fontSize:
                                      readerStoreController.fontSize.value * 2,
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                              ),
                            ),
                            title: Text(
                              _chaptersIndex[_juz.chapters[index] - 1]["name"]
                                  .toString(),
                              style: googleFontify(
                                readerStoreController.arabicFont.value,
                                TextStyle(
                                  fontSize:
                                      readerStoreController.fontSize.value * 3,
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                              ),
                              textAlign: TextAlign.end,
                            ),
                            subtitle: Text(
                              "${_chaptersIndex[_juz.chapters[index] - 1]["translation"]}  "
                              "(${_juz.verses[_juz.chapters[index].toString()].join(" - ")})",
                              style: TextStyle(
                                fontSize: readerStoreController.fontSize.value,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    //* Bismi Allahi
                    if (_chaptersIndex[_juz.chapters[index] - 1]["id"] != 1 &&
                        _juz.verses[_juz.chapters[index].toString()][0] == 1)
                      const Padding(
                        padding: EdgeInsets.only(top: 32, bottom: 8),
                        child: Bismi(),
                      ),
                    //* Verses
                    ListView.separated(
                      padding: const EdgeInsets.symmetric(
                          vertical: 32, horizontal: 8),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, _index) => Verse(
                          verse: _chapters[index][_index],
                          chapter: _juz.chapters[index]),
                      itemCount: _chapters[index].length,
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(height: 0),
                    )
                  ],
                );
              },
              itemCount: _juz.chapters.length,
            )
          : const LinearProgressIndicator(),
    );
  }
}

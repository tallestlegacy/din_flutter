import 'package:din/screens/more/inspiration/juz/juz_data.dart';
import 'package:din/utils/store.dart';
import 'package:din/utils/string_locale.dart';
import 'package:din/widgets/back_button.dart';
import 'package:din/widgets/bismi.dart';
import 'package:din/widgets/text_settings.dart';
import 'package:din/widgets/theme_toggle_action.dart';
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

        setState(() {});
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
    Juz thisJuz = Juz.fromJson(juz[widget.id - 1]);
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        actions: const [TextSettingsAction(), ThemeToggleAction()],
        title: Obx(
          () => Text(readerStoreController.showTranslation.value
              ? "${widget.id} " "   ${thisJuz.translation}"
              : "${toFarsi(widget.id)} " "   ${thisJuz.name}"),
        ),
      ),
      body: _chapters.isNotEmpty && _chaptersIndex.isNotEmpty
          ? ListView.builder(
              itemBuilder: (context, index) {
                return Obx(
                  () => Column(
                    children: [
                      //* Chapter tag
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: ListTile(
                            leading: Text(
                              readerStoreController.showTranslation.value
                                  ? "${thisJuz.chapters[index]}"
                                  : toFarsi(thisJuz.chapters[index]),
                              style: googleFontify(
                                readerStoreController.arabicFont.value,
                                TextStyle(
                                  fontSize:
                                      readerStoreController.fontSize.value * 2,
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),
                              ),
                            ),
                            title: Text(
                              _chaptersIndex[thisJuz.chapters[index] - 1]
                                      ["name"]
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
                              "${_chaptersIndex[thisJuz.chapters[index] - 1]["translation"]}  "
                              "(${thisJuz.verses[thisJuz.chapters[index].toString()].join(" - ")})",
                              style: TextStyle(
                                fontSize: readerStoreController.fontSize.value,
                              ),
                            ),
                          ),
                        ),
                      ),
                      //* Bismi Allahi
                      if (_chaptersIndex[thisJuz.chapters[index] - 1]
                                  ["id"] !=
                              1 &&
                          _chaptersIndex[thisJuz.chapters[index] - 1]["id"] !=
                              9 &&
                          thisJuz.verses[thisJuz.chapters[index].toString()]
                                  [0] ==
                              1)
                        const Padding(
                          padding: EdgeInsets.only(top: 32, bottom: 8),
                          child: Bismi(),
                        ),
                      //* Verses
                      readerStoreController.ayaSpans.value
                          ? Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 32, horizontal: 16),
                              child: Text.rich(
                                textAlign: TextAlign.center,
                                TextSpan(
                                  style: googleFontify(
                                    readerStoreController.arabicFont.value,
                                    TextStyle(
                                      fontSize:
                                          readerStoreController.fontSize.value *
                                              1.5,
                                      height: 2.5,
                                    ),
                                  ),
                                  children: [
                                    for (var verse in _chapters[index]) ...[
                                      Verse(
                                              verse: verse,
                                              chapter: thisJuz.chapters[index])
                                          .span(context),
                                      TextSpan(
                                        text:
                                            " \u06dd${toFarsi(verse["id"])}   ",
                                        style: googleFontify(
                                          readerStoreController
                                              .ayaEndFont.value,
                                          TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .tertiary,
                                            decoration: null,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            )
                          : ListView.separated(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 32, horizontal: 8),
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, _index) => Verse(
                                  verse: _chapters[index][_index],
                                  chapter: thisJuz.chapters[index]),
                              itemCount: _chapters[index].length,
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const Divider(height: 0),
                            )
                    ],
                  ),
                );
              },
              itemCount: thisJuz.chapters.length,
            )
          : const LinearProgressIndicator(),
    );
  }
}

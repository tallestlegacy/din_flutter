import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/widgets/back_button.dart';
import '/widgets/text_settings.dart';
import '/widgets/verse.dart';
import '/utils/json.dart';
import '/utils/store.dart';
import '/utils/string_locale.dart';
import '/widgets/theme_toggle_button.dart';

class Favourites extends StatefulWidget {
  const Favourites({super.key});

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  final GlobalStoreController globalStoreController =
      Get.put(GlobalStoreController());

  final ReaderStoreController readerStoreController =
      Get.put(ReaderStoreController());

  List _chapters = [];
  final Map<int, List> _quran = {};

  Future<void> getChapters() async {
    final data =
        await LoadJson().load("assets/json/quran_editions/en.chapters.json");
    if (mounted) {
      setState(() {
        _chapters = data;
      });
    }
  }

  Future<void> getSurah(int chapter) async {
    var surah = await getVerses(chapter);

    if (mounted) {
      setState(() {
        _quran[chapter] = surah;
      });
    }
  }

  Map<int, List> chapterMap(var list) {
    final Map<int, List> favChapters = {};
    for (var verse in list) {
      if (favChapters[verse['chapter']] == null) {
        favChapters[verse['chapter']] = [];
      }
      favChapters[verse['chapter']]?.add(verse);
    }

    return favChapters;
  }

  @override
  void initState() {
    super.initState();
    getChapters();

    // Init Chapters

    for (int chapter
        in chapterMap(globalStoreController.favouriteVerses).keys) {
      getSurah(chapter);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const Text("Favourites"),
        actions: const [TextSettingsAction(), ThemeToggleButton()],
        //backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Obx(() {
        if (globalStoreController.favouriteVerses.isEmpty) {
          return const Center(
            child: Icon(Icons.format_quote_rounded),
          );
        }

        Map<int, List> favChapters =
            chapterMap(globalStoreController.favouriteVerses);

        var keys = favChapters.keys.toList();
        return ListView(
            padding: const EdgeInsets.all(8),
            children: keys.map((key) {
              var chapter = {};
              if (_chapters.isNotEmpty) chapter = _chapters[key - 1];

              var verses = <Widget>[];

              if (_quran.length >= favChapters.length) {
                favChapters[key]?.forEach((verse) {
                  verses.add(const Divider(height: 0));
                  verses.add(Verse(
                    verse: _quran[verse["chapter"]]?[verse["id"] - 1],
                    chapter: verse["chapter"],
                  ));
                });
              }

              return Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    children: [
                      if (_chapters.isNotEmpty)
                        Obx(
                          () => ListTile(
                            leading: Text(
                              readerStoreController.showTranslation.value
                                  ? chapter["id"].toString()
                                  : toFarsi(chapter["id"]),
                              style: googleFontify(
                                readerStoreController.arabicFont.value,
                                TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize:
                                      readerStoreController.fontSize.value *
                                          1.5,
                                ),
                              ),
                            ),
                            title: Text(
                              readerStoreController.showTranslation.value
                                  ? "${chapter["translation"]} (${chapter["name"]})"
                                  : chapter['name'],
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize:
                                    readerStoreController.fontSize.value * 1.5,
                              ),
                            ),
                            trailing: Icon(
                              Icons.my_library_books_rounded,
                              size: readerStoreController.fontSize.value * 1.5,
                            ),
                          ),
                        ),
                      Column(children: verses),
                    ],
                  ),
                ),
              );
            }).toList());
      }),
    );
  }
}

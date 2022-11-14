import 'package:din/components/back_button.dart';
import 'package:din/components/text_settings.dart';
import 'package:din/components/verse.dart';
import 'package:din/util/json.dart';
import 'package:din/util/store.dart';
import 'package:din/widgets/theme_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Favourites extends StatefulWidget {
  const Favourites({super.key});

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  final GlobalStoreController globalStoreController =
      Get.put(GlobalStoreController());

  List _chapters = [];

  Future<void> getChapters() async {
    final data =
        await LoadJson().load("assets/json/quran_editions/en.chapters.json");
    setState(() {
      _chapters = data;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getChapters();
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const Text("Favourites"),
        actions: const [TextSettingsAction(), ThemeToggleButton()],
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Obx(() {
        if (globalStoreController.favouriteVerses.isEmpty) {
          return const Center(
            child: Icon(Icons.format_quote_rounded),
          );
        }

        var favChapters = {};

        for (var verse in globalStoreController.favouriteVerses) {
          if (favChapters[verse['chapter']] == null) {
            favChapters[verse['chapter']] = [];
          }
          favChapters[verse['chapter']].add(verse);
        }

        var keys = favChapters.keys.toList();

        return ListView(
            children: keys.map((key) {
          var chapter = {};
          if (_chapters.isNotEmpty) chapter = _chapters[key - 1];
          var verses = <Widget>[];

          favChapters[key].forEach((verse) {
            verses.add(Padding(
              padding: const EdgeInsets.all(8),
              child: Verse(verse: verse),
            ));
          });

          return Column(
            children: [
              if (_chapters.isNotEmpty)
                Container(
                  margin: const EdgeInsets.only(top: 32),
                  child: Text(
                    "${chapter['name']} - ${chapter['translation']}",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              Column(children: verses),
              if (keys.last != key) const Divider(),
            ],
          );
        }).toList());
      }),
    );
  }
}

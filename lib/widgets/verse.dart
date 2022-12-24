import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import "package:share_plus/share_plus.dart";

import '/widgets/padded_text.dart';
import '/utils/json.dart';
import '/utils/store.dart';
import '/utils/string_locale.dart';

class Verse extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final verse;
  final int chapter;

  Verse({super.key, required this.verse, required this.chapter});

  final ReaderStoreController readerStoreController =
      Get.put(ReaderStoreController());

  onLongPressVerse(BuildContext context) async {
    final GlobalStoreController globalStoreController =
        Get.put(GlobalStoreController());

    final chapters =
        await LoadJson().load("assets/json/quran_editions/en.chapters.json");
    var currentChapter = chapters[chapter - 1];

    String shareText = "Quran ${currentChapter['id']}:${verse['id']}\n\n"
        "${verse['text']}"
        "\u06dd${toFarsi(verse['id'])}\n\n"
        "${verse['translation']}\n\n"
        "(${currentChapter['name']} - ${currentChapter['translation']} )";

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: ((context) {
        return Container(
          height: 150,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            color: Theme.of(context).canvasColor,
          ),
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text("Quran $chapter:${verse["id"]}"),
              Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.end,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 8,
                children: [
                  IconButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: shareText));
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.copy_rounded),
                  ),
                  IconButton(
                    onPressed: () async {
                      await Share.share(shareText).then((value) {
                        Navigator.pop(context);
                      });
                    },
                    icon: const Icon(Icons.share_rounded),
                  ),
                  Obx(
                    () => IconButton(
                      icon: Icon(
                          globalStoreController.favouriteVerses.isNotEmpty &&
                                  globalStoreController.isFavouriteVerse({
                                    "chapter": currentChapter["id"],
                                    "id": verse["id"]
                                  })
                              ? Icons.favorite_rounded
                              : Icons.favorite_outline_rounded),
                      onPressed: () {
                        var v = verse;
                        v['chapter'] = currentChapter['id'];
                        globalStoreController.addFavouriteAya({
                          "chapter": currentChapter["id"],
                          "id": verse["id"]
                        });
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListTile(
        enableFeedback: true,
        onLongPress: () => onLongPressVerse(context),
        leading: Text(
          readerStoreController.showTranslation.value
              ? verse['id'].toString()
              : "\u06dd${toFarsi(verse['id'])}",
          textAlign: TextAlign.center,
          style: googleFontify(
            "Harmattan",
            TextStyle(
              color: Colors.grey,
              fontSize: readerStoreController.showTranslation.value
                  ? readerStoreController.fontSize.value
                  : readerStoreController.fontSize.value * 1.5,
            ),
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        minVerticalPadding: 0,
        title: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Visibility(
                visible: readerStoreController.showArabicText.value,
                child: PaddedText(
                  text: verse['text'],
                  textAlign: TextAlign.right,
                  fontSize: readerStoreController.fontSize.value * 1.5,
                  fontWeight: FontWeight.w400,
                  //fontFamily: readerStoreController.arabicFont.value,
                  googleFont: readerStoreController.arabicFont.value,
                  color: Theme.of(context).primaryTextTheme.bodyText2?.color,
                ),
              ),
              Visibility(
                visible: readerStoreController.showTransliteration.value,
                child: PaddedText(
                  text: verse['transliteration'],
                  color: Theme.of(context).primaryTextTheme.bodyText2?.color,
                  fontSize: readerStoreController.fontSize.value,
                ),
              ),
              Visibility(
                visible: readerStoreController.showTranslation.value,
                child: PaddedText(
                  text: verse['translation'],
                  color: Theme.of(context).primaryTextTheme.bodyText1?.color,
                  fontSize: readerStoreController.fontSize.value,
                ),
              )
            ]),
      ),
    );
  }
}

class VersePreview extends StatefulWidget {
  const VersePreview({super.key});

  @override
  State<VersePreview> createState() => _VersePreviewState();
}

class _VersePreviewState extends State<VersePreview> {
  var _verse = {
    "id": 1,
    "text": "بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيمِ",
    "translation":
        "In the name of Allah, the Entirely Merciful, the Especially Merciful",
    "transliteration": "Bismi Allahi alrrahmani alrraheemi"
  };

  void init() async {
    var chapter = await getVerses(Random().nextInt(114) + 1);

    if (mounted) {
      setState(() {
        _verse = chapter[Random().nextInt(chapter.length)];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(width: 2, color: Theme.of(context).backgroundColor),
      ),
      child: Padding(
          padding: const EdgeInsets.all(0),
          child: Verse(
            verse: _verse,
            chapter: 1,
          )),
    );
  }
}

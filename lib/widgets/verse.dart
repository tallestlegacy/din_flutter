import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_share/flutter_share.dart';

import '/widgets/padded_text.dart';
import '/util/json.dart';
import '/util/store.dart';
import '/util/string_locale.dart';

class Verse extends StatelessWidget {
  final verse;
  final int chapter;

  const Verse({super.key, required this.verse, required this.chapter});

  @override
  Widget build(BuildContext context) {
    final ReaderStoreController readerStoreController =
        Get.put(ReaderStoreController());

    onLongPressVerse() async {
      final GlobalStoreController globalStoreController =
          Get.put(GlobalStoreController());

      final chapters =
          await LoadJson().load("assets/json/quran_editions/en.chapters.json");
      var currentChapter = chapters[chapter - 1];

      String shareText = "Quran ${currentChapter['id']}:${verse['id']}\n\n"
          "${verse['text']}\n\n"
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
                        await FlutterShare.share(
                          title: "Quran $currentChapter:${verse['id']}\n\n",
                          text: shareText,
                        ).then((value) {
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

    return ListTile(
      enableFeedback: true,
      onLongPress: onLongPressVerse,
      leading: Obx(
        () => Text(
          readerStoreController.showTranslation.value
              ? verse['id'].toString()
              : toFarsi(verse['id']),
          style: TextStyle(
              color: Colors.grey,
              fontSize: readerStoreController.fontSize.value),
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      minVerticalPadding: 0,
      title: Obx(
        () => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Visibility(
                visible: readerStoreController.showArabicText.value,
                child: PaddedText(
                  text: verse['text'],
                  textAlign: TextAlign.right,
                  fontSize: readerStoreController.fontSize.value * 1.5,
                  fontWeight: FontWeight.w400,
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

class VersePreview extends StatelessWidget {
  const VersePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(width: 2, color: Theme.of(context).backgroundColor),
      ),
      child: const Padding(
          padding: EdgeInsets.all(0),
          child: Verse(
            verse: {
              "id": 1,
              "text": "بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيمِ",
              "translation":
                  "In the name of Allah, the Entirely Merciful, the Especially Merciful",
              "transliteration": "Bismi Allahi alrrahmani alrraheemi"
            },
            chapter: 1,
          )),
    );
  }
}

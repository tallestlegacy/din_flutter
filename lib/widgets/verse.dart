import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:din/widgets/divider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import "package:share_plus/share_plus.dart";

import '/widgets/padded_text.dart';
import '/utils/json.dart';
import '/utils/store.dart';
import '/utils/string_locale.dart';

class Verse extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final verse;
  final int chapter;

  const Verse({super.key, required this.verse, required this.chapter});

  span(BuildContext context) => TextSpan(
        text: "${verse["text"]}",
        children: [
          TextSpan(
            text: " \u06dd${toFarsi(verse["id"])}     ",
            style: googleFontify(
              "Harmattan",
              TextStyle(
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ),
          )
        ],
        recognizer: LongPressGestureRecognizer()
          ..onLongPress = () => onLongPressVerse(context, verse, chapter),
      );

  @override
  State<Verse> createState() => _VerseState();
}

class _VerseState extends State<Verse> {
  final ReaderStoreController readerStoreController =
      Get.put(ReaderStoreController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListTile(
        enableFeedback: true,
        onLongPress: () =>
            onLongPressVerse(context, widget.verse, widget.chapter),
        leading: Text(
          readerStoreController.showTranslation.value
              ? widget.verse['id'].toString()
              : "\u06dd${toFarsi(widget.verse['id'])}",
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
              if (readerStoreController.showArabicText.value)
                PaddedText(
                  text: widget.verse['text'],
                  textAlign: TextAlign.right,
                  fontSize: readerStoreController.fontSize.value * 1.5,
                  fontWeight: FontWeight.w400,
                  //fontFamily: readerStoreController.arabicFont.value,
                  googleFont: readerStoreController.arabicFont.value,
                  color: Theme.of(context).primaryTextTheme.bodyText2?.color,
                ),
              if (readerStoreController.showTransliteration.value)
                PaddedText(
                  text: widget.verse['transliteration'],
                  color: Theme.of(context).primaryTextTheme.bodyText2?.color,
                  fontSize: readerStoreController.fontSize.value,
                ),
              if (readerStoreController.showTranslation.value)
                PaddedText(
                  text: widget.verse['translation'],
                  color: Theme.of(context).primaryTextTheme.bodyText1?.color,
                  fontSize: readerStoreController.fontSize.value,
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

onLongPressVerse(BuildContext context, verse, int chapter) async {
  final GlobalStoreController globalStoreController =
      Get.put(GlobalStoreController());

  final ReaderStoreController readerStoreController =
      Get.put(ReaderStoreController());

  final chapters =
      await LoadJson().load("assets/json/quran_editions/en.chapters.json");
  var currentChapter = chapters[chapter - 1];

  String shareText = "Quran ${currentChapter['id']}:${verse['id']}\n\n"
      "${verse['text']}"
      "${toFarsi(verse['id'])}\n\n"
      "${verse['translation']}\n\n"
      "(${currentChapter['name']} - ${currentChapter['translation']} )";

  bool isArabicText = !readerStoreController.showTransliteration.value ||
      readerStoreController.ayaSpans.value;

  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: ((context) {
      return Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            color: Theme.of(context).canvasColor,
          ),
          child: ListView(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 48),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              const HandleBar(),
              //* Share etc. menu
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    reverse: isArabicText,
                    child: Text(
                      isArabicText
                          ? "${verse["text"]}"
                          : "${verse["translation"]}",
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                          fontSize: readerStoreController.fontSize.value),
                    ),
                  ),
                  const Divider(),
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
                          icon: Icon(globalStoreController
                                      .favouriteVerses.isNotEmpty &&
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
              if (kDebugMode) const Divider(),
              //* Qira'at
              if (kDebugMode) VerseAudio(verse: verse, chapter: chapter)
            ],
          ));
    }),
  );
}

class VerseAudio extends StatefulWidget {
  final verse;
  final int chapter;
  const VerseAudio({super.key, required this.verse, required this.chapter});

  @override
  State<VerseAudio> createState() => _VerseAudioState();
}

class _VerseAudioState extends State<VerseAudio> {
  bool _isPlaying = false;
  final audioPlayer = AudioPlayer();
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  final ReaderStoreController readerStoreController =
      Get.put(ReaderStoreController());

  List<StreamSubscription> streams = [];

  @override
  void initState() {
    super.initState();

    streams.add(audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        _isPlaying = state == PlayerState.playing;
      });
    }));
    streams.add(audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        _duration = newDuration;
      });
    }));

    streams.add(audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        _position = newPosition;
      });
    }));

    audioPlayer.setReleaseMode(ReleaseMode.stop);
    streams.add(audioPlayer.onPlayerComplete.listen((event) {}));
  }

  @override
  void dispose() {
    super.dispose();

    streams.forEach((element) => element.cancel());

    audioPlayer.pause();
    audioPlayer.dispose();
  }

  get isEmpty => _duration.inSeconds == 0;

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        IconButton(
          onPressed: () async {
            if (_isPlaying) {
              audioPlayer.pause();
            } else {
              if (isEmpty) {
                String chapterId = widget.chapter.toString().padLeft(3, "0");
                String verseId = widget.verse["id"].toString().padLeft(3, "0");

                String url =
                    "https://everyayah.com/data/${readerStoreController.recitor.value}/$chapterId$verseId.mp3";

                await audioPlayer.setSource(UrlSource(url));

                if (kDebugMode) {
                  print(url);
                }
              }
              await audioPlayer.resume();
            }
          },
          icon:
              Icon(_isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded),
        ),
        Expanded(
          child: SliderTheme(
            data: SliderThemeData(
              thumbColor: !isEmpty
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey,
              inactiveTrackColor: !isEmpty
                  ? Theme.of(context).colorScheme.primary.withAlpha(100)
                  : Colors.grey.withAlpha(100),
              trackHeight: 2,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 7),
            ),
            child: Slider(
                min: 0,
                max: _duration.inSeconds.toDouble(),
                value: _position.inSeconds.toDouble(),
                onChanged: (value) async {
                  final position = Duration(seconds: value.toInt());
                  await audioPlayer.seek(position);
                }),
          ),
        ),
        if (!isEmpty) Text("${_duration.inSeconds - _position.inSeconds}s"),
      ],
    );
  }
}

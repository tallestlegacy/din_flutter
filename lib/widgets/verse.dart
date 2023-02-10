import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:din/constants/strings.dart';
import 'package:din/widgets/divider.dart';
import 'package:din/widgets/icons.dart';
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

class Verse extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final verse;
  final int chapter;
  final bool enabled;

  Verse({
    super.key,
    required this.verse,
    required this.chapter,
    this.enabled = true,
  });

  final ReaderStoreController readerStoreController =
      Get.put(ReaderStoreController());
  final GlobalStoreController globalStoreController =
      Get.put(GlobalStoreController());

  get isFavourite => globalStoreController.isFavouriteVerse({
        "chapter": chapter,
        "id": verse["id"],
      });

  get isSelected =>
      readerStoreController.selectedAya.value == "$chapter:${verse["id"]}";

  span(BuildContext context) => [
        TextSpan(
          text: "${verse["text"]}",
          style: TextStyle(
            backgroundColor: isSelected
                ? Theme.of(context).colorScheme.primary.withAlpha(56)
                : null,
            color: isFavourite ? Theme.of(context).colorScheme.primary : null,
          ),
          recognizer: LongPressGestureRecognizer()
            ..onLongPress = () => onLongPressVerse(context, verse, chapter),
        ),
        TextSpan(
          text: " \u06dd${toFarsi(verse["id"])}   ",
          style: googleFontify(
            readerStoreController.ayaEndFont.value,
            TextStyle(
              color: Theme.of(context).colorScheme.primary,
              decoration: null,
            ),
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListTile(
        selected: isSelected,
        selectedTileColor: Theme.of(context).primaryColor.withAlpha(56),
        enabled: enabled,
        enableFeedback: true,
        onLongPress: () => onLongPressVerse(context, verse, chapter),
        leading: Wrap(
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          spacing: 8,
          runSpacing: 8,
          children: [
            Text(
              readerStoreController.showTranslation.value
                  ? verse['id'].toString()
                  : "\u06dd${toFarsi(verse['id'])}",
              textAlign: TextAlign.center,
              style: googleFontify(
                readerStoreController.ayaEndFont.value,
                TextStyle(
                  fontSize: readerStoreController.showTranslation.value
                      ? readerStoreController.fontSize.value
                      : readerStoreController.fontSize.value * 1.5,
                ),
              ),
            ),
            if (isFavourite) favouriteIcon
          ],
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        minVerticalPadding: 0,
        title: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (readerStoreController.showArabicText.value)
                PaddedText(
                  text: verse['text'],
                  textAlign: TextAlign.right,
                  fontSize: readerStoreController.fontSize.value * 1.5,
                  fontWeight: FontWeight.w400,
                  //fontFamily: readerStoreController.arabicFont.value,
                  googleFont: readerStoreController.arabicFont.value,
                  color: isFavourite
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).primaryTextTheme.bodyMedium?.color,
                ),
              if (readerStoreController.showTransliteration.value)
                PaddedText(
                  text: verse['transliteration'],
                  color: Theme.of(context).primaryTextTheme.bodyMedium?.color,
                  fontSize: readerStoreController.fontSize.value,
                ),
              if (readerStoreController.showTranslation.value)
                PaddedText(
                  text: verse['translation'],
                  color: Theme.of(context).primaryTextTheme.bodySmall?.color,
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
  var _verse = sura1aya1;

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
        border: Border.all(
          width: 2,
          color: Theme.of(context).colorScheme.secondary.withAlpha(30),
        ),
      ),
      child: Padding(
          padding: const EdgeInsets.all(0),
          child: Verse(
            verse: _verse,
            chapter: 1,
            enabled: false,
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

  bool isArabicText = readerStoreController.ayaSpans.value ||
      !readerStoreController.showTranslation.value;

  String shareText = isArabicText
      ? "${currentChapter["name"]} ${toFarsi(verse["id"])}\n\n"
          "${verse['text']}\n\n"
      : "Quran $chapter:${verse['id']}\n\n"
          "${verse['text']}\n\n"
          "${verse['translation']}\n\n"
          "(${currentChapter['name']} - ${currentChapter['translation']} )";

  readerStoreController.selectedAya("$chapter:${verse["id"]}");

  // ignore: use_build_context_synchronously
  await showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: ((context) {
      return Container(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Theme.of(context).canvasColor,
        ),
        child: SafeArea(
          bottom: true,
          child: ListView(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              const HandleBar(),
              //* Share etc. menu
              Text(
                //isArabicText ? "${verse["text"]}" : "${verse["translation"]}",
                shareText,
                overflow: TextOverflow.fade,
                maxLines: 4,
                style: TextStyle(
                  fontSize: readerStoreController.fontSize.value,
                ),
              ),
              const Divider(),
              Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 20),
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
                                  globalStoreController.isFavouriteVerse(
                                      {"chapter": chapter, "id": verse["id"]})
                              ? Icons.favorite_rounded
                              : Icons.favorite_outline_rounded),
                          onPressed: () {
                            globalStoreController.addFavouriteAya(
                                {"chapter": chapter, "id": verse["id"]});
                          },
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const Divider(),
              //* Qira'at
              Obx(() => VerseAudio(
                    verse: verse,
                    chapter: chapter,
                    subfolder: readerStoreController.reciter.value.toString(),
                  )),
              const Spacing(padding: 16)
            ],
          ),
        ),
      );
    }),
  );

  readerStoreController.resetSelectedAya();
}

class VerseAudio extends StatefulWidget {
  final verse;
  final int chapter;
  final String subfolder;
  const VerseAudio(
      {super.key,
      required this.verse,
      required this.chapter,
      required this.subfolder});

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

    for (var element in streams) {
      element.cancel();
    }

    audioPlayer.pause();
    audioPlayer.dispose();
  }

  get isEmpty => _duration.inSeconds == 0;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: IconButton(
        onPressed: () async {
          if (_isPlaying) {
            audioPlayer.pause();
          } else {
            if (isEmpty) {
              String chapterId = widget.chapter.toString().padLeft(3, "0");
              String verseId = widget.verse["id"].toString().padLeft(3, "0");

              String url =
                  "$everyAyaUrl/${widget.subfolder}/$chapterId$verseId.mp3";

              await audioPlayer.setSource(UrlSource(url));

              if (kDebugMode) {
                print(url);
              }
            }
            await audioPlayer.resume();
          }
        },
        icon: Icon(_isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded),
      ),
      title: Flex(
        direction: Axis.horizontal,
        children: [
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
      ),
      subtitle: Text(widget.subfolder, textAlign: TextAlign.right),
    );
  }
}

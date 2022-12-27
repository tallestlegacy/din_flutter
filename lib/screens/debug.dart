import 'package:din/utils/json.dart';
import 'package:din/widgets/text_settings.dart';
import 'package:din/widgets/verse.dart';

import '../utils/adhan.dart';
import '../utils/store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/string_locale.dart';

class Debug extends StatefulWidget {
  const Debug({super.key});

  @override
  State<Debug> createState() => _DebugState();
}

class _DebugState extends State<Debug> {
  final GlobalStoreController globalStoreController =
      Get.put(GlobalStoreController());
  final TranslationsStoreController translationsStoreController =
      Get.put(TranslationsStoreController());
  final ReaderStoreController readerStoreController =
      Get.put(ReaderStoreController());

  List _verses = [];

  Future<void> initVerses() async {
    List verses = await getVerses(1);
    if (mounted) {
      setState(() {
        _verses = verses;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initVerses();
  }

  @override
  Widget build(BuildContext context) {
    final readerStoreController = Get.put(ReaderStoreController());
    // Definitions

    var prayerTimes = getAdhan(0.5, 35);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: const [TextSettingsAction()],
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Obx(
              () => Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  style: TextStyle(
                    fontSize: readerStoreController.fontSize.value * 1.5,
                    height: 1.5,
                  ),
                  children: [
                    for (var verse in _verses)
                      Verse(verse: verse, chapter: 1).span(context)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

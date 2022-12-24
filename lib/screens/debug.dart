import 'package:flutter_svg/flutter_svg.dart';

import '../utils/store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          SvgPicture.asset(
            "assets/svg/compass.svg",
            height: 200,
            color: Colors.red,
          ),
          Obx(() =>
              Text(translationsStoreController.quranTranslations.toString())),
        ],
      ),
    );
  }
}

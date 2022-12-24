import 'package:din/services/local_notification.dart';
import 'package:din/widgets/sabt.dart';

import '../utils/adhan.dart';
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
    // Definitions

    var prayerTimes = getAdhan(0.5, 35);

    return SliverAppBarStatus();

    return Scaffold(
      body: ListView(
        children: [
          Obx(() => Text(readerStoreController.arabicFont.value.toString())),
          Text(prayerTimes.fajr.toString()),
          Text(prayerTimes.dhuhr.toString()),
          Text(prayerTimes.asr!.toLocal().toString()),
          Text(prayerTimes.maghrib.toString()),
          Text(prayerTimes.ishabefore.toString()),
          Text(prayerTimes.isha!.toLocal().toString()),
          ElevatedButton(onPressed: showNotification, child: Text("Click me"))
        ],
      ),
    );
  }
}

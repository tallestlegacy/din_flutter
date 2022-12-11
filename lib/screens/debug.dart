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
    final List<String> _tabs = <String>['Tab 1', 'Tab 2'];
    return Scaffold(
      body: Center(
        child: Obx(() => Text(readerStoreController.arabicFont.value)),
      ),
    );
  }
}

import 'package:din/util/store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Debug extends StatelessWidget {
  const Debug({super.key});

  @override
  Widget build(BuildContext context) {
    final DebugController storeController = Get.put(DebugController());
    return Scaffold(
      appBar: AppBar(
          title: Obx(() => Text("Get Storage >> ${storeController.countObs}"))),
      floatingActionButton: FloatingActionButton(
        onPressed: () => storeController.increment(storeController.count),
      ),
    );
  }
}

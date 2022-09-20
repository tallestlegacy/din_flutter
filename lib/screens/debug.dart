import 'package:din/util/store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Debug extends StatefulWidget {
  const Debug({super.key});

  @override
  State<Debug> createState() => _DebugState();
}

class _DebugState extends State<Debug> {
  double _value = 20;

  @override
  Widget build(BuildContext context) {
    final DebugController storeController = Get.put(DebugController());
    return Scaffold(
        appBar: AppBar(
            title:
                Obx(() => Text("Get Storage >> ${storeController.countObs}"))),
        floatingActionButton: FloatingActionButton(
          onPressed: () => storeController.increment(storeController.count),
        ),
        body: Center(
          child: Text(Colors.blue.value.toRadixString(16)),
        ));
  }
}

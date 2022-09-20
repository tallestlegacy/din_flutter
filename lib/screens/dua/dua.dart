import 'package:din/screens/dua/hisnul.dart';
import 'package:flutter/material.dart';

class Dua extends StatelessWidget {
  final ScrollController scrollController;

  const Dua({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hisnul Muslim")),
      body: Hisnul(scrollController: scrollController),
    );
  }
}

import '/screens/dua/hisnul.dart';
import 'package:flutter/material.dart';

class Dua extends StatelessWidget {
  final ScrollController scrollController;

  const Dua({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hisnul(scrollController: scrollController),
    );
  }
}

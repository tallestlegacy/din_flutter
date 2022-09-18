import 'package:din/components/bukhari.dart';
import 'package:din/components/hisnul.dart';
import 'package:flutter/material.dart';

class Hadith extends StatefulWidget {
  final ScrollController scrollController;

  const Hadith({Key? key, required this.scrollController}) : super(key: key);

  @override
  State<Hadith> createState() => _HadithState();
}

class _HadithState extends State<Hadith> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Sahih Bukhari"),
        ),
        body: const Bukhari());
  }
}

import '/screens/hadith/bukhari.dart';
import 'package:flutter/material.dart';

class Hadith extends StatefulWidget {
  const Hadith({Key? key}) : super(key: key);

  @override
  State<Hadith> createState() => _HadithState();
}

class _HadithState extends State<Hadith> {
  @override
  Widget build(BuildContext context) {
    return Bukhari();
  }
}

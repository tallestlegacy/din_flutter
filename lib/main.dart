import 'package:din/screens/quran.dart';
import 'package:din/util/theme.dart';
import "package:flutter/material.dart";

void main() {
  runApp(const DinFlutterApp());
}

class DinFlutterApp extends StatelessWidget {
  const DinFlutterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Din",
      debugShowCheckedModeBanner: false,
      home: const QuranPage(),
      theme: Styles.themeData(false, context),
      darkTheme: Styles.themeData(true, context),
      themeMode: ThemeMode.system,
    );
  }
}

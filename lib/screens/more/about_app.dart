import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '/widgets/back_button.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    const String data = """
Din is a free and open source educational app for curious minds, new converts
and regular users that need a quick reference to common literary sources.  
It contains a complete quran, a few dua, hadith and other sunnah.
""";

    return Scaffold(
      appBar: AppBar(
        title: const Text("About the app"),
        leading: const CustomBackButton(),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 32, bottom: 16, left: 16, right: 16),
          child: MarkdownBody(
            data: data,
          ),
        ),
      ),
    );
  }
}

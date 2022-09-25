import 'package:din/components/back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

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
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: MarkdownBody(
            data: data,
          ),
        ),
      ),
    );
  }
}

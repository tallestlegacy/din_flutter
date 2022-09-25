import 'package:din/components/back_button.dart';
import 'package:din/components/text_settings.dart';
import 'package:din/components/verse.dart';
import 'package:flutter/material.dart';

class ReaderPreferences extends StatelessWidget {
  const ReaderPreferences({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reader preferences"),
        leading: const CustomBackButton(),
      ),
      body: Column(
        children: const [
          Padding(
            padding: EdgeInsets.all(16),
            child: VersePreview(),
          ),
          Divider(),
          TextSettings(),
        ],
      ),
    );
  }
}

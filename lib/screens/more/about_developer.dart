import 'package:din/components/back_button.dart';
import 'package:flutter/material.dart';

class AboutDeveloper extends StatelessWidget {
  const AboutDeveloper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About the Developers"),
        leading: const CustomBackButton(),
      ),
    );
  }
}

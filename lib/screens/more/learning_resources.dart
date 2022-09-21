import 'package:flutter/material.dart';

class LearningResources extends StatelessWidget {
  const LearningResources({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Learning Resources"),
        backgroundColor: Theme.of(context).backgroundColor,
      ),
    );
  }
}

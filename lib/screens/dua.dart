import 'package:din/components/hisnul.dart';
import 'package:flutter/material.dart';

class Dua extends StatelessWidget {
  const Dua({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hisnul Muslim")),
      body: const Hisnul(),
    );
  }
}

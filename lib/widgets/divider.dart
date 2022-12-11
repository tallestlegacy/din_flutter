import 'package:flutter/material.dart';

class HandleBar extends StatelessWidget {
  const HandleBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 16),
      width: 40,
      height: 4,
      decoration: BoxDecoration(
          color: Colors.grey.withAlpha(100),
          borderRadius: const BorderRadius.all(Radius.circular(8))),
    );
  }
}

class Spacing extends StatelessWidget {
  final double padding;
  const Spacing({super.key, this.padding = 8});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(padding));
  }
}

import 'package:flutter/material.dart';

class Verse extends StatelessWidget {
  final verse;

  const Verse({super.key, this.verse});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          PaddedText(
            text: "${verse['text']}",
            textAlign: TextAlign.right,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).primaryTextTheme.bodyText2?.color,
          ),
          PaddedText(
            text: "${verse['transliteration']}",
            color: Theme.of(context).primaryTextTheme.bodyText2?.color,
          ),
          PaddedText(
            text: "${verse['id']}. ${verse['translation']}",
            color: Theme.of(context).primaryTextTheme.bodyText1?.color,
          )
        ]);
  }
}

class PaddedText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final Color? color;
  final double fontSize;
  final FontWeight fontWeight;

  const PaddedText(
      {super.key,
      required this.text,
      this.textAlign = TextAlign.left,
      this.color = Colors.grey,
      this.fontSize = 12,
      this.fontWeight = FontWeight.normal});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Text(
        text,
        textAlign: textAlign,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          height: 1.5,
        ),
      ),
    );
  }
}

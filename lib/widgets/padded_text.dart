import 'package:flutter/material.dart';

class PaddedText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final Color? color;
  final double fontSize;
  final FontWeight fontWeight;
  final String fontFamily;

  const PaddedText({
    super.key,
    required this.text,
    this.textAlign = TextAlign.left,
    this.color = Colors.grey,
    this.fontSize = 12,
    this.fontWeight = FontWeight.normal,
    this.fontFamily = "",
  });

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
          fontFamily: fontFamily,
        ),
      ),
    );
  }
}

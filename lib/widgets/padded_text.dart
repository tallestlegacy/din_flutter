import 'package:flutter/material.dart';
import "package:google_fonts/google_fonts.dart";

class PaddedText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  final Color? color;
  final double fontSize;
  final FontWeight fontWeight;
  // final String fontFamily;
  final String googleFont;
  final double padding;

  const PaddedText({
    super.key,
    required this.text,
    this.textAlign = TextAlign.left,
    this.color = Colors.grey,
    this.fontSize = 12,
    this.fontWeight = FontWeight.normal,
    // this.fontFamily = "",
    this.googleFont = "",
    this.padding = 4,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: 1.5,
    );

    return Padding(
      padding: EdgeInsets.all(padding),
      child: Text(text,
          textAlign: textAlign,
          style: googleFont != ""
              ? GoogleFonts.getFont(googleFont, textStyle: textStyle)
              : textStyle),
    );
  }
}

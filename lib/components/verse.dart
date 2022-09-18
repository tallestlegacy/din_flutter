import 'package:din/util/store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Verse extends StatelessWidget {
  final verse;

  const Verse({super.key, this.verse});

  @override
  Widget build(BuildContext context) {
    final SettingsStoreController settingsStoreController =
        Get.put(SettingsStoreController());
    return ListTile(
      leading: Text(
        verse['id'].toString(),
        style: const TextStyle(color: Colors.grey),
      ),
      contentPadding: const EdgeInsets.all(0),
      minVerticalPadding: 0,
      title: Obx(
        () => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Visibility(
                visible: settingsStoreController.showArabicText.value,
                child: PaddedText(
                  text: verse['text'],
                  textAlign: TextAlign.right,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).primaryTextTheme.bodyText2?.color,
                ),
              ),
              Visibility(
                visible: settingsStoreController.showTransliteration.value,
                child: PaddedText(
                  text: verse['transliteration'],
                  color: Theme.of(context).primaryTextTheme.bodyText2?.color,
                ),
              ),
              Visibility(
                visible: settingsStoreController.showTranslation.value,
                child: PaddedText(
                  text: verse['translation'],
                  color: Theme.of(context).primaryTextTheme.bodyText1?.color,
                ),
              )
            ]),
      ),
    );
  }
}

class PaddedText extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
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

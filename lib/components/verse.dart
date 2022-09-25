import 'package:din/components/padded_text.dart';
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
      leading: Obx(
        () => Text(
          verse['id'].toString(),
          style: TextStyle(
              color: Colors.grey,
              fontSize: settingsStoreController.fontSize.value),
        ),
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
                  fontSize: settingsStoreController.fontSize.value * 1.5,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).primaryTextTheme.bodyText2?.color,
                ),
              ),
              Visibility(
                visible: settingsStoreController.showTransliteration.value,
                child: PaddedText(
                  text: verse['transliteration'],
                  color: Theme.of(context).primaryTextTheme.bodyText2?.color,
                  fontSize: settingsStoreController.fontSize.value,
                ),
              ),
              Visibility(
                visible: settingsStoreController.showTranslation.value,
                child: PaddedText(
                  text: verse['translation'],
                  color: Theme.of(context).primaryTextTheme.bodyText1?.color,
                  fontSize: settingsStoreController.fontSize.value,
                ),
              )
            ]),
      ),
    );
  }
}

class VersePreview extends StatelessWidget {
  const VersePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(width: 2, color: Theme.of(context).backgroundColor),
      ),
      child: const Padding(
          padding: EdgeInsets.all(16),
          child: Verse(
            verse: {
              "id": 1,
              "text": "بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيمِ",
              "translation":
                  "In the name of Allah, the Entirely Merciful, the Especially Merciful",
              "transliteration": "Bismi Allahi alrrahmani alrraheemi"
            },
          )),
    );
  }
}

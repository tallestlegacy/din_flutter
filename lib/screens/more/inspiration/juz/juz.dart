import 'package:din/screens/more/inspiration/juz/juz_data.dart';
import 'package:din/screens/more/inspiration/juz/juz_reader.dart';
import 'package:din/utils/store.dart';
import 'package:din/widgets/back_button.dart';
import 'package:din/widgets/text_settings.dart';
import 'package:din/widgets/theme_toggle_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/verse.dart';
import '/utils/json.dart';
import '/utils/string_locale.dart';

class Juz extends StatelessWidget {
  const Juz({super.key});

  @override
  Widget build(BuildContext context) {
    final ReaderStoreController readerStoreController =
        Get.put(ReaderStoreController());
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const Text("Juz"),
        actions: const [
          TextSettingsAction(),
          ThemeToggleButton(),
        ],
      ),
      body: Obx(
        () => SafeArea(
          bottom: true,
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: [
              for (var section in juz)
                Card(
                  child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => JuzReader(id: section["id"]),
                          ),
                        );
                      },
                      leading: Text(
                        "\u06dd${toFarsi(section["id"])}",
                        style: googleFontify(
                          "Harmattan",
                          TextStyle(
                            fontSize:
                                readerStoreController.fontSize.value * 1.5,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                      ),
                      title: Text(
                        section["name"],
                        style: googleFontify(
                          readerStoreController.arabicFont.value,
                          TextStyle(
                            fontSize: readerStoreController.fontSize.value * 2,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        textAlign: TextAlign.right,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (readerStoreController.showTransliteration.value)
                            Text(
                              section["transliteration"],
                              style: TextStyle(
                                fontSize: readerStoreController.fontSize.value,
                              ),
                            ),
                          if (readerStoreController.showTranslation.value)
                            Text(
                              section["translation"],
                              style: TextStyle(
                                fontSize: readerStoreController.fontSize.value,
                              ),
                            ),
                        ],
                      ),
                      trailing: Wrap(
                        spacing: 4,
                        children: [
                          Text(
                            readerStoreController.showTranslation.value
                                ? section["chapters"].length.toString()
                                : toFarsi(section["chapters"].length),
                            style: googleFontify(
                              readerStoreController.arabicFont.value,
                              TextStyle(
                                fontSize: readerStoreController.fontSize.value,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.my_library_books_rounded,
                            size: readerStoreController.fontSize.value,
                            color: Colors.grey,
                          )
                        ],
                      )),
                )
            ],
          ),
        ),
      ),
    );
  }
}

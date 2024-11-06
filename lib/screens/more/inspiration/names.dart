import 'package:din/widgets/back_button.dart';
import 'package:din/widgets/text_settings.dart';
import 'package:din/widgets/theme_toggle_action.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/padded_text.dart';
import '/utils/string_locale.dart';
import '/utils/json.dart';
import '/utils/store.dart';

class Names extends StatefulWidget {
  const Names({super.key});

  @override
  State<Names> createState() => _NamesState();
}

class _NamesState extends State<Names> {
  List<dynamic> _namesOfAllah = [];
  // List<dynamic> _namesOfMuhammad = [];

  final ReaderStoreController readerStoreController =
      Get.put(ReaderStoreController());

  Future<void> getNames() async {
    final data1 = await LoadJson().load("assets/json/99 names of Allah.json");
    // final data2 =
    //     await LoadJson().load("assets/json/99 names of Muhammad.json");
    if (mounted) {
      setState(() {
        _namesOfAllah = data1;
        // _namesOfMuhammad = data2;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getNames();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Asma Ul Husna"),
        leading: const CustomBackButton(),
        actions: const [TextSettingsAction(), ThemeToggleAction()],
      ),
      body: SafeArea(
        bottom: true,
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemBuilder: (BuildContext context, int index) =>
              NameCard(name: _namesOfAllah[index], index: index),
          itemCount: _namesOfAllah.length,
        ),
      ),
    );
  }
}

class NameCard extends StatelessWidget {
  var name;
  int index;

  NameCard({super.key, required this.name, required this.index});

  @override
  Widget build(BuildContext context) {
    final ReaderStoreController readerStoreController =
        Get.put(ReaderStoreController());

    // String link =
    //     "https://myislam.org/99-names-of-allah/${name["transliteration"].toString().toLowerCase().replaceAll("'", "")}/";

    return Obx(
      () => Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ListTile(
              leading: Text(
                readerStoreController.showTranslation.value
                    ? (index + 1).toString()
                    : toFarsi(index + 1),
                style: googleFontify(
                  readerStoreController.arabicFont.value,
                  TextStyle(
                    fontSize: readerStoreController.fontSize.value,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
              title: PaddedText(
                text: "${name["name"]}",
                googleFont: readerStoreController.arabicFont.value,
                textAlign: TextAlign.right,
                fontSize: readerStoreController.fontSize.value * 2,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (readerStoreController.showTransliteration.value)
                    Text(name["transliteration"],
                        style: TextStyle(
                            fontSize: readerStoreController.fontSize.value)),
                  if (readerStoreController.showTranslation.value)
                    Text(name["translation"],
                        style: TextStyle(
                            fontSize: readerStoreController.fontSize.value)),
                ],
              ),
            ),
            /* const Divider(),
            TextButton(
              onPressed: () => openLink(
                link,
                external: false,
              ),
              child: PaddedText(
                text: "Learn More",
                color: Theme.of(context).colorScheme.tertiary,
              ),
            ), */
          ],
        ),
      ),
    );
  }
}

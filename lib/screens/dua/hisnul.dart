import 'package:din/components/back_button.dart';
import 'package:din/components/padded_text.dart';
import 'package:din/components/text_settings.dart';
import 'package:din/util/json.dart';
import 'package:din/util/store.dart';
import 'package:din/widgets/theme_toggle_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Hisnul extends StatefulWidget {
  final ScrollController scrollController;

  const Hisnul({Key? key, required this.scrollController}) : super(key: key);

  @override
  State<Hisnul> createState() => _HisnulState();
}

class _HisnulState extends State<Hisnul> {
  var _refs = [];

  Future<void> getRefs() async {
    var data =
        await LoadJson().load("assets/json/hadith/hisnulmuslim/index.json");
    if (mounted) {
      setState(() {
        _refs = data;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getRefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hisnul Muslim"),
        actions: const [ThemeToggleButton()],
      ),
      body: ListView.builder(
        controller: widget.scrollController,
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              trailing: Text(
                "${_refs[index]['hadiths'].length}",
                style: const TextStyle(color: Colors.grey),
              ),
              title: Text("${_refs[index]['title']}"),
              onTap: () => Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => HisnulReference(ref: _refs[index]),
                ),
              ),
            ),
          );
        },
        itemCount: _refs.length,
      ),
    );
  }
}

class HisnulReference extends StatelessWidget {
  final ref;
  const HisnulReference({Key? key, required this.ref}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SettingsStoreController settingsStoreController =
        Get.put(SettingsStoreController());

    return SafeArea(
      bottom: true,
      top: false,
      child: Scaffold(
        appBar: AppBar(
          leading: const CustomBackButton(),
          title: Text("${ref['title']}"),
          actions: const [TextSettingsAction(), ThemeToggleButton()],
          titleTextStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSecondary),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: ref['hadiths'].length,
          itemBuilder: (context, index) => Card(
            child: Obx(
              () => ListTile(
                title: settingsStoreController.showArabicText.value
                    ? Text(
                        ref['hadiths'][index]['text']
                            .toString()
                            .replaceAll("\n", " "),
                        style: TextStyle(
                          fontSize:
                              settingsStoreController.fontSize.value * 1.25,
                          color: Theme.of(context)
                              .primaryTextTheme
                              .bodyText2
                              ?.color,
                        ),
                      )
                    : null,
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Visibility(
                      visible:
                          settingsStoreController.showTransliteration.value,
                      child: PaddedText(
                        text: ref['hadiths'][index]['transliteration']
                            .toString()
                            .replaceAll("\n", " "),
                        fontSize: settingsStoreController.fontSize.value,
                        color:
                            Theme.of(context).primaryTextTheme.bodyText2?.color,
                      ),
                    ),
                    Visibility(
                      visible: settingsStoreController.showTranslation.value,
                      child: PaddedText(
                        text: ref['hadiths'][index]['translation']
                            .toString()
                            .replaceAll("\n", " "),
                        fontSize: settingsStoreController.fontSize.value,
                        color:
                            Theme.of(context).primaryTextTheme.bodyText1?.color,
                      ),
                    ),
                  ],
                ),
                leading: Text(
                  "${ref['hadiths'][index]['id']}",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: settingsStoreController.fontSize.value,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

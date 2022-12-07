import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/widgets/back_button.dart';
import '/widgets/padded_text.dart';
import '/widgets/text_settings.dart';
import '/util/json.dart';
import '/util/store.dart';
import '/util/string_locale.dart';
import '/widgets/theme_toggle_button.dart';

class Hisnul extends StatefulWidget {
  const Hisnul({Key? key}) : super(key: key);

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

  final ReaderStoreController readerStoreController =
      Get.put(ReaderStoreController());

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
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () {
              showSearch(context: context, delegate: HisnulSearch(_refs));
            },
          ),
          const ThemeToggleButton(),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          return Card(
            child: Obx(
              () => ListTile(
                trailing: Text(
                  readerStoreController.showTranslation.value
                      ? _refs[index]['hadiths'].length.toString()
                      : toFarsi(_refs[index]['hadiths'].length),
                  style: const TextStyle(color: Colors.grey, fontSize: 10),
                ),
                title: Text("${_refs[index]['title']}"),
                onTap: () => Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => HisnulReference(ref: _refs[index]),
                  ),
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

class HisnulSearch extends SearchDelegate {
  List refs = [];
  HisnulSearch(this.refs);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            if (query == "") {
              close(context, null);
            } else {
              query = "";
            }
          },
          icon: const Icon(Icons.close_rounded))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back_rounded));
  }

  @override
  Widget buildResults(BuildContext context) {
    List matchQuery = [];
    for (var ref in refs) {
      if (ref["title"].toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(ref);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
            title: Text(result["title"]),
            onTap: () {
              close(context, null);
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => HisnulReference(ref: result),
                ),
              );
            });
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List matchQuery = [];
    for (var ref in refs) {
      if (ref["title"].toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(ref);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result["title"]),
          onTap: () => Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => HisnulReference(ref: result),
            ),
          ),
        );
      },
    );
  }
}

class HisnulReference extends StatelessWidget {
  final ref;
  const HisnulReference({Key? key, required this.ref}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ReaderStoreController readerStoreController =
        Get.put(ReaderStoreController());

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
                title: readerStoreController.showArabicText.value
                    ? Text(
                        ref['hadiths'][index]['text'].replaceAll("\n", " "),
                        style: TextStyle(
                          fontSize: readerStoreController.fontSize.value * 1.25,
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
                      visible: readerStoreController.showTransliteration.value,
                      child: PaddedText(
                        text: ref['hadiths'][index]['transliteration']
                            .replaceAll("\n", " "),
                        fontSize: readerStoreController.fontSize.value,
                        color:
                            Theme.of(context).primaryTextTheme.bodyText2?.color,
                      ),
                    ),
                    Visibility(
                      visible: readerStoreController.showTranslation.value,
                      child: PaddedText(
                        text: ref['hadiths'][index]['translation']
                            .replaceAll("\n", " "),
                        fontSize: readerStoreController.fontSize.value,
                        color:
                            Theme.of(context).primaryTextTheme.bodyText1?.color,
                      ),
                    ),
                  ],
                ),
                leading: Text(
                  readerStoreController.showTranslation.value
                      ? ref['hadiths'][index]['id'].toString()
                      : toFarsi(ref['hadiths'][index]['id']),
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: readerStoreController.fontSize.value,
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

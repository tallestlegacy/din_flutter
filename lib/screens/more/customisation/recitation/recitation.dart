import 'package:din/constants/every_aya.dart';
import 'package:din/constants/strings.dart';
import 'package:din/utils/network.dart';
import 'package:din/utils/store.dart';
import 'package:din/widgets/back_button.dart';
import 'package:din/widgets/icons.dart';
import 'package:din/widgets/theme_toggle_button.dart';
import 'package:din/widgets/verse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Recitation extends StatelessWidget {
  const Recitation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reciters"),
        leading: const CustomBackButton(),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () {
              showSearch(context: context, delegate: RecitorsSearch());
            },
          ),
          const ThemeToggleButton(),
        ],
      ),
      body: ListView.separated(
        itemCount: everyAya.length,
        itemBuilder: (context, index) {
          var track = everyAya[(index + 1).toString()];
          return RecitorListTile(track: track);
        },
        separatorBuilder: (BuildContext context, int index) =>
            const Divider(height: 0),
      ),
    );
  }
}

class RecitorListTile extends StatelessWidget {
  final track;

  RecitorListTile({super.key, required this.track});

  final ReaderStoreController readerStoreController =
      Get.put(ReaderStoreController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListTile(
        title: Text("${track["name"]}"),
        subtitle: Text("${track["bitrate"]}"),
        leading: Radio(
          value: track["subfolder"].toString(),
          groupValue: readerStoreController.recitor.value,
          onChanged: (value) {
            readerStoreController.setRecitor(value.toString());
          },
        ),
        trailing: const Icon(Icons.chevron_right_rounded),
        onTap: (() {
          Navigator.push(context,
              CupertinoPageRoute(builder: (context) => Reciter(track: track)));
        }),
      ),
    );
  }
}

class RecitorsSearch extends SearchDelegate {
  final ReaderStoreController readerStoreController =
      Get.put(ReaderStoreController());

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
    for (var ref in everyAya.values) {
      if (ref["name"]!.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(ref);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var track = matchQuery[index];
        return RecitorListTile(track: track);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) => buildResults(context);
}

class Reciter extends StatelessWidget {
  final track;

  Reciter({super.key, required this.track});

  final ReaderStoreController readerStoreController =
      Get.put(ReaderStoreController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        actions: const [ThemeToggleButton()],
        title: Text(track["name"]),
      ),
      body: SafeArea(
        bottom: true,
        child: Obx(
          () => ListView(
            padding: const EdgeInsets.all(8),
            children: [
              ListTile(
                title: const Text("Bit rate"),
                subtitle: Text(track["bitrate"]),
              ),
              const Divider(),
              ListTile(
                title: const Text("Source"),
                subtitle: Text("$everyAyaUrl/${track["subfolder"]}"),
                trailing: linkIcon,
                onTap: (() {
                  openLink("$everyAyaUrl/${track["subfolder"]}");
                }),
              ),
              const Divider(),
              ListTile(
                title: const Text("Preview"),
                subtitle: Column(
                  children: [
                    //Verse(verse: sura1aya1, chapter: 1, enabled: false),
                    VerseAudio(
                      chapter: 1,
                      verse: sura1aya1,
                      subfolder: track["subfolder"].toString(),
                    ),
                  ],
                ),
              ),
              const Divider(),
              readerStoreController.recitor.value != track["subfolder"]
                  ? TextButton(
                      onPressed: () async {
                        readerStoreController.setRecitor(track["subfolder"]);
                        var messenger = ScaffoldMessenger.of(context);
                        messenger.showSnackBar(
                          SnackBar(
                            content: Text(
                                "${track["subfolder"]} is the new default"),
                          ),
                        );
                      },
                      child: const Text("Set as Default"))
                  : const ListTile(
                      leading: Icon(Icons.check_circle_rounded),
                      title: Text("Default"),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

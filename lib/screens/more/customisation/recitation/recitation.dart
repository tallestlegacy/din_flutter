import 'package:din/constants/every_aya.dart';
import 'package:din/constants/strings.dart';
import 'package:din/utils/store.dart';
import 'package:din/widgets/back_button.dart';
import 'package:din/widgets/theme_toggle_action.dart';
import 'package:din/widgets/verse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Recitation extends StatelessWidget {
  const Recitation({super.key});

  @override
  Widget build(BuildContext context) {
    everyAya
        .sort((a, b) => a['name'].toString().compareTo(b['name'].toString()));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reciters"),
        leading: const CustomBackButton(),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () {
              showSearch(context: context, delegate: RecitersSearch());
            },
          ),
          const ThemeToggleAction(),
        ],
      ),
      body: SafeArea(
        bottom: true,
        child: ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: everyAya.length,
          itemBuilder: (context, index) {
            var track = everyAya[index];
            return ReciterListTile(track: track);
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(height: 0),
        ),
      ),
    );
  }
}

class ReciterListTile extends StatelessWidget {
  final track;

  ReciterListTile({super.key, required this.track});

  final ReaderStoreController readerStoreController =
      Get.put(ReaderStoreController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListTile(
        title: Text("${track["name"]}"),
        leading: readerStoreController.hasSubfolder(track["tracks"])
            ? const Icon(Icons.check_circle_rounded)
            : const Icon(Icons.person_rounded, color: Colors.grey),
        trailing: const Icon(Icons.chevron_right_rounded),
        subtitle: Wrap(
          spacing: 4,
          runSpacing: 4,
          children: [for (var t in track["tracks"]) Text(t["bitrate"])],
        ),
        onTap: (() {
          Navigator.push(context,
              CupertinoPageRoute(builder: (context) => Reciter(track: track)));
        }),
      ),
    );
  }
}

class RecitersSearch extends SearchDelegate {
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
    for (var ref in everyAya) {
      if (ref["name"].toString().toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(ref);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var track = matchQuery[index];
        return ReciterListTile(track: track);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) => buildResults(context);
}

class Reciter extends StatefulWidget {
  final track;

  Reciter({super.key, required this.track});

  @override
  State<Reciter> createState() => _ReciterState();
}

class _ReciterState extends State<Reciter> {
  final ReaderStoreController readerStoreController =
      Get.put(ReaderStoreController());

  String subfolder = "";

  @override
  void initState() {
    super.initState();

    if (mounted) {
      setState(() {
        subfolder = widget.track["tracks"][0]["subfolder"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        actions: const [ThemeToggleAction()],
        title: Text(widget.track["name"]),
      ),
      body: SafeArea(
        bottom: true,
        child: Obx(
          () => ListView(
            padding: const EdgeInsets.all(8),
            children: [
              for (var source in widget.track["tracks"])
                RadioListTile(
                  value: source["subfolder"].toString(),
                  groupValue: subfolder,
                  onChanged: (value) {
                    setState(() {
                      subfolder = source["subfolder"];
                    });
                  },
                  title: Text(source["bitrate"]),
                  subtitle:
                      readerStoreController.reciter.value == source["subfolder"]
                          ? const Text("Default")
                          : null,
                ),
              const Divider(),
              VerseAudio(
                chapter: 1,
                verse: sura1aya1,
                subfolder: subfolder,
              ),
              readerStoreController.reciter.value != subfolder
                  ? ListTile(
                      onTap: () async {
                        readerStoreController.setReciter(subfolder);
                        var messenger = ScaffoldMessenger.of(context);
                        messenger.showSnackBar(
                          SnackBar(
                            content: Text("$subfolder is the new default"),
                          ),
                        );
                      },
                      title: Text(
                        "Set as Default",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ))
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

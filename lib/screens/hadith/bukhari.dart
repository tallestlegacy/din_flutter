import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/widgets/back_button.dart';
import '/widgets/text_settings.dart';
import '/utils/json.dart';
import '/utils/store.dart';
import '/utils/string_locale.dart';
import '/widgets/theme_toggle_button.dart';

class Bukhari extends StatefulWidget {
  const Bukhari({Key? key}) : super(key: key);

  @override
  State<Bukhari> createState() => _BukhariState();
}

class _BukhariState extends State<Bukhari> {
  List _volumes = [];
  int length = 97;

  Future<void> getVolumes() async {
    var data = await LoadJson().load("assets/json/hadith/bukhari/index.json");
    if (mounted) {
      setState(() {
        _volumes = data;
      });
    }
  }

  final ReaderStoreController readerStoreController =
      Get.put(ReaderStoreController());

  List getAllBooks(List<dynamic> volumes) {
    List books = [];

    for (var volume in volumes) {
      books.addAll(volume["books"]);
    }

    return books;
  }

  @override
  void initState() {
    super.initState();
    getVolumes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sahih Bukhari"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: BukhariSearch(refs: getAllBooks(_volumes)));
            },
          ),
          const ThemeToggleButton(),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _volumes.length,
        itemBuilder: (context, index) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                "${_volumes[index]['name']}",
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            for (var book in _volumes[index]['books'])
              Obx(
                () => Card(
                  child: ListTile(
                    title: Text(
                      "${book['name']}",
                    ),
                    trailing: Text(
                      readerStoreController.showTranslation.value
                          ? "${book['length']}"
                          : toFarsi(book['length']),
                      style: googleFontify(
                        readerStoreController.arabicFont.value,
                        const TextStyle(color: Colors.grey, fontSize: 10),
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => BukhariHadiths(
                            book: book,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}

class BukhariSearch extends SearchDelegate {
  List refs = [];
  BukhariSearch({required this.refs});

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
      if (ref["name"].toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(ref);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
            title: Text(result["name"]),
            onTap: () {
              close(context, null);
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => BukhariHadiths(book: result),
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
      if (ref["name"].toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(ref);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
            title: Text(result["name"]),
            onTap: () {
              close(context, null);
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => BukhariHadiths(book: result),
                ),
              );
            });
      },
    );
  }
}

class BukhariHadiths extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final book;
  const BukhariHadiths({Key? key, required this.book}) : super(key: key);

  @override
  State<BukhariHadiths> createState() => _BukhariHadithsState();
}

class _BukhariHadithsState extends State<BukhariHadiths> {
  var _hadiths = [];
  Future<void> getHadiths() async {
    var data = await LoadJson()
        .load("assets/json/hadith/bukhari/${widget.book['id']}.json");
    if (mounted) {
      setState(() {
        _hadiths = data['hadiths'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getHadiths();
  }

  @override
  Widget build(BuildContext context) {
    final ReaderStoreController readerStoreController =
        Get.put(ReaderStoreController());
    return SafeArea(
      bottom: true,
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: Text("${widget.book['name']}"),
          leading: const CustomBackButton(),
          actions: const [TextSettingsAction(), ThemeToggleButton()],
          titleTextStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSecondary),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: _hadiths.length,
          itemBuilder: (context, index) => Card(
            child: Obx(
              () => ListTile(
                leading: Text(
                  readerStoreController.showTranslation.value
                      ? _hadiths[index]['id'].toString()
                      : toFarsi(_hadiths[index]['id']),
                  style: googleFontify(
                    readerStoreController.arabicFont.value,
                    TextStyle(
                      color: Colors.grey,
                      fontSize: readerStoreController.fontSize.value,
                    ),
                  ),
                ),
                title: Text(
                  _hadiths[index]['by'],
                  style:
                      TextStyle(fontSize: readerStoreController.fontSize.value),
                ),
                subtitle: Text(
                  _hadiths[index]['text'],
                  style:
                      TextStyle(fontSize: readerStoreController.fontSize.value),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

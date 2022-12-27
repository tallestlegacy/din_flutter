import 'dart:convert';

import 'package:din/constants/every_aya.dart';
import 'package:din/utils/store.dart';
import 'package:din/widgets/back_button.dart';
import 'package:din/widgets/theme_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Recitation extends StatelessWidget {
  const Recitation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recitors"),
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
  var track;

  RecitorListTile({super.key, required this.track});

  final ReaderStoreController readerStoreController =
      Get.put(ReaderStoreController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => RadioListTile(
        controlAffinity: ListTileControlAffinity.trailing,
        value: track["subfolder"].toString(),
        groupValue: readerStoreController.recitor.value,
        onChanged: (value) {
          readerStoreController.setRecitor(value.toString());
        },
        title: Text("${track["name"]}"),
        subtitle: Text("${track["bitrate"]}}"),
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

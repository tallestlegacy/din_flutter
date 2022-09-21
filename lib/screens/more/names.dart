import 'package:din/components/text_settings.dart';
import 'package:din/widgets/theme_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../util/json.dart';
import '../../util/store.dart';

class Names extends StatefulWidget {
  const Names({super.key});

  @override
  State<Names> createState() => _NamesState();
}

class _NamesState extends State<Names> {
  List<dynamic> _namesOfAllah = [];
  List<dynamic> _namesOfMuhammad = [];

  Future<void> getNames() async {
    final data1 = await LoadJson().load("assets/json/99 names of Allah.json");
    final data2 =
        await LoadJson().load("assets/json/99 names of Muhammad.json");
    if (mounted) {
      setState(() {
        _namesOfAllah = data1;
        _namesOfMuhammad = data2;
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
    final SettingsStoreController settingsStoreController =
        Get.put(SettingsStoreController());

    Widget buildNamesListView(var names, double fontSize) {
      return ListView.separated(
        itemCount: names.length,
        itemBuilder: (context, index) => ListTile(
          leading: Text(
            (index + 1).toString(),
            style: TextStyle(fontSize: fontSize),
          ),
          title: Text(
            "${names[index]["name"]} - ${names[index]["transliteration"]}",
            style: TextStyle(fontSize: fontSize),
          ),
          subtitle: Text(
            names[index]["translation"],
            style: TextStyle(fontSize: fontSize),
          ),
        ),
        separatorBuilder: (builder, context) => const Divider(),
      );
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          title: const Text("99 Names"),
          bottom: TabBar(
              indicatorColor: Theme.of(context).primaryColor,
              labelPadding: const EdgeInsets.all(8),
              tabs: const [
                Text("Allah"),
                Text("Muhammad"),
              ]),
          actions: const [TextSettingsAction(), ThemeToggleButton()],
        ),
        body: TabBarView(children: [
          Obx(
            () => buildNamesListView(
                _namesOfAllah, settingsStoreController.fontSize.value),
          ),
          Obx(
            () => buildNamesListView(
                _namesOfMuhammad, settingsStoreController.fontSize.value),
          ),
        ]),
      ),
    );
  }
}

import 'package:din/components/back_button.dart';
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

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) => [
            SliverOverlapAbsorber(
              sliver: SliverAppBar(
                floating: true,
                snap: true,
                pinned: true,
                forceElevated: innerBoxIsScrolled,
                backgroundColor: Theme.of(context).backgroundColor,
                title: const Text("99 Names"),
                leading: const CustomBackButton(),
                bottom: TabBar(
                  labelPadding: const EdgeInsets.all(8),
                  tabs: const [
                    Text("Allah"),
                    Text("Muhammad"),
                  ],
                  indicatorColor: Theme.of(context).primaryColor,
                ),
                actions: const [TextSettingsAction(), ThemeToggleButton()],
              ),
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
          ],
          body: TabBarView(
            children: [_namesOfAllah, _namesOfMuhammad].map((var names) {
              return SafeArea(
                top: false,
                bottom: true,
                child: Builder(
                  builder: (BuildContext context) {
                    return CustomScrollView(
                      slivers: <Widget>[
                        SliverOverlapInjector(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) => Column(
                              children: [
                                Obx(
                                  (() {
                                    double fontSize =
                                        settingsStoreController.fontSize.value;
                                    return ListTile(
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
                                    );
                                  }),
                                ),
                                if (index != names.length - 1) const Divider()
                              ],
                            ),
                            childCount: names.length,
                          ),
                        )
                      ],
                    );
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
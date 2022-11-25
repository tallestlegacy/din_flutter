import 'package:din/util/store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Translations extends StatefulWidget {
  const Translations({super.key});

  @override
  State<Translations> createState() => _TranslationsState();
}

class _TranslationsState extends State<Translations> {
  @override
  Widget build(BuildContext context) {
    final TranslationsStoreController translationsStoreController =
        Get.put(TranslationsStoreController());

    translationsStoreController.updateQuranTranslations();

    return Obx(
      () => DefaultTabController(
        length: translationsStoreController.quranTranslations.length,
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
                  title: const Text("Translations"),
                  bottom: TabBar(
                    isScrollable: true,
                    labelPadding: const EdgeInsets.all(8),
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: translationsStoreController.quranTranslations
                        .map((element) => Text(
                              element["language"],
                            ))
                        .toList(),
                    indicatorColor: Theme.of(context).primaryColor,
                  ),
                ),
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
            ],
            body: TabBarView(
              children: translationsStoreController.quranTranslations
                  .map((var language) {
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
                              (context, index) => ListTile(
                                leading: const Icon(Icons.translate_rounded),
                                title: Text(language["editions"][index]),
                                trailing: Icon(Icons.download),
                              ),
                              childCount: language["editions"].length,
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
      ),
    );
  }
}

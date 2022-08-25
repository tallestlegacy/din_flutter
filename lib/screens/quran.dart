import 'package:din/util/json.dart';
import 'package:flutter/material.dart';

import 'package:din/components/surah.dart';

class QuranPage extends StatefulWidget {
  final ScrollController scrollController;

  QuranPage({Key? key, required this.scrollController}) : super(key: key);

  @override
  _QuranPageState createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  List _chapters = [];
  int currentPage = -1;

  Future<void> getChapters() async {
    final data = await LoadJson().load("assets/json/quran/chapters.json");
    setState(() {
      _chapters = data;
      currentPage = currentPage < 0 ? 0 : currentPage;
    });
  }

  void onPageChanged(int page) {
    setState(() {
      currentPage = page;
    });
  }

  String getChapterText(int page) {
    if (page >= 0) {
      var chapter = _chapters[page];
      return "${chapter['id']}  -  ${chapter['name']}  -  ${chapter['translation']}";
    }
    return "Din";
  }

  @override
  Widget build(BuildContext context) {
    getChapters();

    final PageController pageController = PageController();

    return Scaffold(
      body: NestedScrollView(
        controller: widget.scrollController,
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text(getChapterText(currentPage)),
              leading: IconButton(
                icon: const Icon(Icons.menu_rounded),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
              snap: true,
              floating: true,
            ),
          ];
        },
        body: PageView(
          reverse: true,
          controller: pageController,
          onPageChanged: onPageChanged,
          children: <Widget>[
            for (var chapter in _chapters) Surah(chapter: chapter)
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView.separated(
          itemCount: _chapters.length,
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              pageController.jumpToPage(index);
              Scaffold.of(context).closeDrawer();
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Text(
                  "${_chapters[index]['id']}.  ${_chapters[index]['translation']}"),
            ),
          ),
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ),
      ),
    );
  }
}

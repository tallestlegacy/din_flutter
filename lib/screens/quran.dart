import 'package:din/util/json.dart';
import 'package:flutter/material.dart';

import 'package:din/components/surah.dart';

class QuranPage extends StatefulWidget {
  const QuranPage({Key? key}) : super(key: key);

  @override
  _QuranPageState createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  List _chapters = [];
  int currentPage = -1;

  Future<void> getChapters() async {
    final data = await LoadJson().load("assets/json/chapters.json");
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

    final PageController controller = PageController();

    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text(getChapterText(currentPage)),
              titleTextStyle: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              leading: IconButton(
                icon: const Icon(Icons.menu),
                color: Colors.white,
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
          ];
        },
        body: PageView(
          controller: controller,
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
              controller.jumpToPage(index);
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

import 'package:din/util/json.dart';
import 'package:flutter/material.dart';

import 'package:din/components/surah.dart';

class QuranPage extends StatefulWidget {
  final ScrollController scrollController;

  const QuranPage({Key? key, required this.scrollController}) : super(key: key);

  @override
  State<QuranPage> createState() => _QuranPageState();
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
  void initState() {
    super.initState();
    getChapters();
  }

  @override
  Widget build(BuildContext context) {
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
            for (var chapter in _chapters)
              CustomScrollView(
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Text(
                        "بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيمِ",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 32,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ]),
                  ),
                  Surah(
                    chapter: chapter,
                  )
                ],
              )
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
            child: ListTile(
              subtitle: Text("${_chapters[index]['translation']}"),
              leading: Text("${_chapters[index]['id']}"),
              title: Text(
                "${_chapters[index]['name']}",
                style: Theme.of(context).primaryTextTheme.bodyText2,
              ),
              trailing: Text(
                "${_chapters[index]['total_verses']}",
                style: Theme.of(context).primaryTextTheme.bodyText2,
              ),
            ),
          ),
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
        ),
      ),
    );
  }
}

import 'package:scroll_to_index/scroll_to_index.dart';

import '/widgets/surah.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import '/widgets/text_settings.dart';
import '/utils/json.dart';
import '/utils/store.dart';
import '/widgets/theme_toggle_button.dart';
import '/utils/string_locale.dart';

class QuranPage extends StatefulWidget {
  final ScrollController scrollController;

  const QuranPage({Key? key, required this.scrollController}) : super(key: key);

  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  List _chapters = [];
  int _currentPage = -1;

  Future<void> getChapters() async {
    final data =
        await LoadJson().load("assets/json/quran_editions/en.chapters.json");

    if (mounted) {
      setState(() {
        _chapters = data;
        _currentPage = _currentPage < 0 ? 0 : _currentPage;
      });
    }
  }

  String getChapterText(int page, {bool? showTranslation}) {
    if (_chapters.isEmpty) return "Din";

    if (page >= 0 && page <= 114) {
      var chapter = _chapters[page];
      if (showTranslation ?? false) {
        return "${chapter['id']}. ${chapter['translation']}   ( ${chapter['name']} )";
      }
      return "(${toFarsi(chapter['id'])})  ${chapter['name']}";
    }
    return "Din";
  }

  final ReaderStoreController readerStoreController =
      Get.put(ReaderStoreController());
  final GlobalStoreController globalStoreController =
      Get.put(GlobalStoreController());

  @override
  void initState() {
    super.initState();
    getChapters();
  }

  @override
  void dispose() {
    super.dispose();
    globalStoreController.setCurrentSurah(_currentPage);
  }

  @override
  Widget build(BuildContext context) {
    final autoScrollController = AutoScrollController(
      viewportBoundaryGetter: () =>
          Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
      axis: Axis.vertical,
    );

    void onPageChanged(int page) {
      setState(() {
        _currentPage = page;
      });
      globalStoreController.setCurrentSurah(_currentPage);
    }

    PageController pageController =
        PageController(initialPage: globalStoreController.currentSurah.value);

    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).backgroundColor,
      ),
      child: Scaffold(
        body: NestedScrollView(
          controller: widget.scrollController,
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: Obx(
                  () => Text(
                    getChapterText(
                      globalStoreController.currentSurah.value,
                      showTranslation:
                          readerStoreController.showTranslation.value &&
                              !readerStoreController.ayaSpans.value,
                    ),
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                leading: IconButton(
                  icon: const Icon(Icons.menu_rounded),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                    autoScrollController.scrollToIndex(
                      globalStoreController.currentSurah.value,
                      preferPosition: AutoScrollPosition.middle,
                    );
                  },
                ),
                snap: true,
                floating: true,
                forceElevated: true,
                actions: const [TextSettingsAction(), ThemeToggleButton()],
                elevation: 1,
                backgroundColor: Theme.of(context).backgroundColor,
              ),
            ];
          },
          body: PageView(
            reverse: readerStoreController.reverseScrolling.value,
            controller: pageController,
            onPageChanged: onPageChanged,
            children: <Widget>[
              for (var chapter in _chapters)
                Surah(
                  chapter: chapter,
                )
            ],
          ),
        ),
        onDrawerChanged: (isOpened) {
          globalStoreController.drawerIsOpen(isOpened);
        },
        drawer: Drawer(
          child: ListView.separated(
            controller: autoScrollController,
            key: const PageStorageKey<String>("quran drawer"),
            itemCount: _chapters.length,
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                pageController.jumpToPage(index);
                Scaffold.of(context).closeDrawer();
              },
              child: Obx(
                () => AutoScrollTag(
                  controller: autoScrollController,
                  index: index,
                  key: ValueKey(index),
                  child: ListTile(
                    selected:
                        pageController.page == (_chapters[index]["id"] - 1),
                    selectedColor:
                        Theme.of(context).primaryTextTheme.bodyText2?.color,
                    selectedTileColor:
                        Theme.of(context).primaryColor.withAlpha(50),
                    subtitle: Text("${_chapters[index]['translation']}"),
                    leading: Text(
                      readerStoreController.showTranslation.value
                          ? _chapters[index]['id'].toString()
                          : toFarsi(_chapters[index]['id']),
                      style: googleFontify(
                          readerStoreController.arabicFont.value, null),
                    ),
                    title: Text(
                      "${_chapters[index]['name']} - ${_chapters[index]['transliteration']}",
                      style: Theme.of(context).primaryTextTheme.bodyText2,
                    ),
                    trailing: Wrap(
                      spacing: 4,
                      children: [
                        Text(
                          readerStoreController.showTranslation.value
                              ? _chapters[index]['total_verses'].toString()
                              : toFarsi(_chapters[index]['total_verses']),
                          style: googleFontify(
                            readerStoreController.arabicFont.value,
                            TextStyle(
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyText2!
                                  .color,
                              fontSize: 10,
                            ),
                          ),
                        ),
                        const Icon(Icons.my_library_books_rounded,
                            size: 14, color: Colors.grey)
                      ],
                    ),
                  ),
                ),
              ),
            ),
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(height: 0),
          ),
        ),
      ),
    );
  }
}

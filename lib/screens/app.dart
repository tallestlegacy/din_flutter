import 'package:din/screens/dua/dua.dart';
import 'package:din/widgets/scroll_to_hide.dart';
import 'package:din/screens/debug.dart';
import 'package:din/screens/hadith/hadith.dart';
import 'package:din/screens/quran.dart';
import 'package:din/screens/more/more.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late ScrollController scrollController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();

    super.dispose();
  }

  void handleNavigationTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      QuranPage(scrollController: scrollController),
      Dua(scrollController: scrollController),
      Hadith(scrollController: scrollController),
      MoreScreen(scrollController: scrollController),
      const Debug()
    ];
    return SafeArea(
      bottom: true,
      top: false,
      child: Scaffold(
        body: screens[_selectedIndex],
        bottomNavigationBar: ScrollToHide(
          controller: scrollController,
          child: SizedBox(
            height: 64,
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: handleNavigationTap,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  icon: const Icon(Icons.menu_book_rounded),
                  label: 'Quran',
                ),
                BottomNavigationBarItem(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  icon: const Icon(Icons.try_sms_star_rounded),
                  label: 'Dua',
                ),
                BottomNavigationBarItem(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  icon: const Icon(Icons.book),
                  label: 'Hadith',
                ),
                BottomNavigationBarItem(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  icon: const Icon(Icons.menu_open_rounded),
                  label: 'More',
                ),
                if (kDebugMode)
                  BottomNavigationBarItem(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    icon: const Icon(Icons.bug_report_rounded),
                    label: 'Debug',
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

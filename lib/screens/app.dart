import '/screens/dua/dua.dart';
import '/widgets/scroll_to_hide.dart';
import '/screens/debug.dart';
import '/screens/hadith/hadith.dart';
import '/screens/quran.dart';
import '/screens/more/more.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
      const Dua(),
      const Hadith(),
      const MoreScreen(),
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
            child: NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: handleNavigationTap,
              destinations: const <NavigationDestination>[
                NavigationDestination(
                  icon: const Icon(Icons.menu_book_rounded),
                  label: 'Quran',
                ),
                NavigationDestination(
                  icon: const Icon(Icons.try_sms_star_rounded),
                  label: 'Dua',
                ),
                NavigationDestination(
                  icon: const Icon(Icons.book),
                  label: 'Hadith',
                ),
                NavigationDestination(
                  icon: const Icon(Icons.menu_open_rounded),
                  label: 'More',
                ),
                if (kDebugMode)
                  NavigationDestination(
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

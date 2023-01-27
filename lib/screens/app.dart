import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '/screens/dua/dua.dart';
import '/widgets/scroll_to_hide.dart';
import '/screens/debug.dart';
import '/screens/hadith/hadith.dart';
import '/screens/quran.dart';
import '/screens/more/more.dart';
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
    if (mounted) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Theme.of(context).colorScheme.secondary,
      ));
    }

    List<Widget> screens = [
      QuranPage(scrollController: scrollController),
      const Dua(),
      const Hadith(),
      const MoreScreen(),
      if (kDebugMode) const Debug()
    ];

    List icons = const [
      {
        "icon": Icon(Icons.menu_book_rounded),
        "label": 'Quran',
      },
      {
        "icon": Icon(Icons.try_sms_star_rounded),
        "label": 'Dua',
      },
      {
        "icon": Icon(Icons.book_rounded),
        "label": 'Hadith',
      },
      {
        "icon": Icon(Icons.menu_open_rounded),
        "label": 'More',
      },
      if (kDebugMode)
        {
          "icon": Icon(Icons.bug_report_rounded),
          "label": 'Debug',
        }
    ];

    return WillPopScope(
      onWillPop: () async {
        if (_selectedIndex == 0) {
          return true;
        }
        setState(() {
          _selectedIndex = 0;
        });
        return false;
      },
      child: SafeArea(
        bottom: true,
        top: false,
        child: Scaffold(
          body: MediaQuery.of(context).size.width < 600
              ? IndexedStack(
                  index: _selectedIndex,
                  children: screens,
                )
              : Row(
                  children: [
                    Expanded(
                      child: IndexedStack(
                        index: _selectedIndex,
                        children: screens,
                      ),
                    ),
                    NavigationRail(
                      minExtendedWidth: 160,
                      destinations: <NavigationRailDestination>[
                        for (var e in icons)
                          NavigationRailDestination(
                            icon: e["icon"],
                            label: Text(e["label"]),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                          ),
                      ],
                      selectedIndex: _selectedIndex,
                      onDestinationSelected: handleNavigationTap,
                    ),
                  ],
                ),
          bottomNavigationBar: MediaQuery.of(context).size.width < 600
              ? ScrollToHide(
                  controller: scrollController,
                  child: SizedBox(
                    height: 72,
                    child: NavigationBar(
                      // backgroundColor: Theme.of(context).colorScheme.tertiary,
                      selectedIndex: _selectedIndex,
                      onDestinationSelected: handleNavigationTap,
                      labelBehavior:
                          NavigationDestinationLabelBehavior.onlyShowSelected,
                      destinations: <NavigationDestination>[
                        for (var e in icons)
                          NavigationDestination(
                            icon: e["icon"],
                            label: e["label"],
                          ),
                      ],
                    ),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}

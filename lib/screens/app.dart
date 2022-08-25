import 'package:din/components/scroll_to_hide.dart';
import 'package:din/screens/hadith.dart';
import 'package:din/screens/quran.dart';
import 'package:din/screens/settings.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
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
      Hadith(scrollController: scrollController),
      const SettingsScreen()
    ];
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: ScrollToHide(
        controller: scrollController,
        child: BottomNavigationBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white54,
          showUnselectedLabels: false,
          currentIndex: _selectedIndex,
          onTap: handleNavigationTap,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_rounded),
              label: 'Quran',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Hadith',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_open_rounded),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}

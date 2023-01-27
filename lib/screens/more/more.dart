import 'package:din/screens/more/customisation/recitation/recitation.dart';
import 'package:din/screens/more/info/info.dart';
import 'package:din/screens/more/inspiration/juz/juz.dart';
import 'package:din/screens/more/notes/notes.dart';
import 'package:din/screens/more/tools/prayer_times.dart';
import 'package:din/screens/more/tools/qibla.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'customisation/appearance.dart';
import 'inspiration/favourites.dart';
import 'inspiration/names.dart';
import 'customisation/reader_preferences.dart';
import 'customisation/translations/translations.dart';
import '../../widgets/theme_toggle_action.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  Future<PackageInfo> getPackageInfo() async {
    return await PackageInfo.fromPlatform();
  }

  PackageInfo _packageInfo = PackageInfo(
    appName: '',
    packageName: '',
    version: '',
    buildNumber: '',
    buildSignature: '',
  );

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();

    if (mounted) {
      setState(() {
        _packageInfo = info;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  @override
  Widget build(BuildContext context) {
    void push(Widget page) {
      Navigator.push(context, CupertinoPageRoute(builder: (context) => page));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("More"),
        actions: const [ThemeToggleAction()],
        // backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          ListTile(
            title: const Text("Inspiration"),
            subtitle: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.stars_rounded),
                  title: const Text("Asma Ul Husna"),
                  onTap: () => push(const Names()),
                ),
                ListTile(
                  enabled: true,
                  leading: const Icon(Icons.menu_book_rounded),
                  title: const Text("Juz"),
                  onTap: () => push(const Juz()),
                ),
                ListTile(
                  leading: const Icon(Icons.favorite_rounded),
                  title: const Text("Favourites"),
                  onTap: () => push(const Favourites()),
                ),
                if (kDebugMode)
                  ListTile(
                    enabled: false,
                    leading: const Icon(Icons.edit_note_rounded),
                    title: const Text("Notes"),
                    onTap: () => push(const Notes()),
                  ),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text("Tools"),
            subtitle: Column(
              children: [
                if (kDebugMode) // TODO add feature
                  ListTile(
                    enabled: false,
                    leading: const Icon(Icons.search_rounded),
                    title: const Text("Global Search"),
                    subtitle:
                        const Text("Quran, Dua and Hadith full text search"),
                    onTap: () {},
                  ),
                if (kDebugMode) // TODO add features
                  ListTile(
                    enabled: false,
                    leading: const Icon(Icons.event_note_rounded),
                    title: const Text("Hijri Calendar"),
                    onTap: () {},
                  ),
                ListTile(
                  leading: const Icon(Icons.explore_rounded),
                  title: const Text("Qibla"),
                  onTap: () => push(Qibla()),
                ),
                ListTile(
                  leading: const Icon(Icons.av_timer_rounded),
                  title: const Text("Adhan"),
                  onTap: () => push(const PrayerTimesScreen()),
                ),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text("Customisation"),
            subtitle: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.palette_outlined),
                  title: const Text("Appearance"),
                  onTap: () => push(const Appearance()),
                ),
                ListTile(
                  leading: const Icon(Icons.text_format_rounded),
                  title: const Text("Reader preferences"),
                  subtitle: const Text("Size, text display format, fontface"),
                  onTap: () => push(ReaderPreferences()),
                ),
                ListTile(
                  leading: const Icon(Icons.spatial_audio_off_rounded),
                  title: const Text("Recitation"),
                  onTap: () => push(const Recitation()),
                ),
                ListTile(
                  leading: const Icon(Icons.translate_rounded),
                  title: const Text("Translation"),
                  onTap: () => push(const Translations()),
                ),
                if (kDebugMode) // TODO add feature
                  ListTile(
                    enabled: false,
                    leading: const Icon(Icons.notifications),
                    title: const Text("Notifications"),
                    subtitle: const Text("Prayer times, fasting, holidays"),
                    onTap: () {},
                  ),
              ],
            ),
          ),
          const Divider(),
          Column(
            children: [
              ListTile(
                leading: const Icon(Icons.info_outline_rounded),
                title: const Text("App Info"),
                subtitle: Text(_packageInfo.version),
                onTap: () => push(const Info()),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

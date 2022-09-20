import 'package:din/screens/more/about_app.dart';
import 'package:din/screens/more/about_developer.dart';
import 'package:din/screens/more/appearance.dart';
import 'package:din/screens/more/reader_preferences.dart';
import 'package:din/widgets/theme_toggle_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  final ScrollController scrollController;

  const MoreScreen({Key? key, required this.scrollController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void Push(Widget page) {
      Navigator.push(context, CupertinoPageRoute(builder: (context) => page));
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("More"),
          actions: const [ThemeToggleButton()],
          // backgroundColor: Theme.of(context).backgroundColor,
        ),
        body: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.stars_rounded),
              title: const Text("99 Names"),
              subtitle:
                  const Text("Names of Allah and the prophet Muhammad (ﷺ.)"),
              onTap: () {},
              enabled: false,
            ),
            ListTile(
              leading: const Icon(Icons.stars_rounded),
              title: const Text("Allah's promises"),
              onTap: () {},
              enabled: false,
            ),
            ListTile(
              leading: const Icon(Icons.bookmark),
              title: const Text("Online References"),
              subtitle: const Text("Books, websites, videos"),
              onTap: () {},
              enabled: false,
            ),
            ListTile(
              leading: const Icon(CupertinoIcons.heart_fill),
              title: const Text("Favourites"),
              onTap: () {},
              enabled: false,
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.text_format_rounded),
              title: const Text("Reader preferences"),
              subtitle: const Text("Size, fonts, display format"),
              onTap: () => Push(const ReaderPreferences()),
            ),
            ListTile(
              leading: const Icon(Icons.palette_outlined),
              title: const Text("Appearance"),
              subtitle: const Text("Theme modes, accent colors"),
              onTap: () => Push(const Appearance()),
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.share_rounded),
              title: Text("Share"),
              enabled: false,
            ),
            const ListTile(
              leading: Icon(Icons.star_rounded),
              title: Text("Rate the app"),
              enabled: false,
            ),
            const ListTile(
              leading: Icon(Icons.question_answer_rounded),
              title: Text("Help and Feedback"),
              subtitle: Text("Privacy policy, contact us, recommendations"),
              enabled: false,
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.info_outline_rounded),
              title: const Text("About the app"),
              onTap: () => Push(const AboutApp()),
            ),
            ListTile(
              leading: const Icon(Icons.badge_outlined),
              title:
                  const Text("About the developers"), // TODO find a better icon
              onTap: () => Push(const AboutDeveloper()),
            ),
            ListTile(
              leading: const Icon(Icons.code_sharp),
              title: const Text(
                  "Sources and Licencing"), // TODO find a better icon
              onTap: () => {},
              enabled: false,
            ),
          ],
        ));
  }
}

import 'package:din/screens/more/about_app.dart';
import 'package:din/screens/more/about_developer.dart';
import 'package:din/screens/more/appearance.dart';
import 'package:din/screens/more/learning_resources.dart';
import 'package:din/screens/more/names.dart';
import 'package:din/screens/more/reader_preferences.dart';
import 'package:din/util/network.dart';
import 'package:din/widgets/theme_toggle_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';

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
                  const Text("99 Names of Allah and the prophet Muhammad (ﷺ.)"),
              onTap: () => Push(const Names()),
            ),
            ListTile(
              leading: const Icon(Icons.stars_rounded),
              title: const Text("Allah's promises"),
              onTap: () {},
              enabled: false,
            ),
            ListTile(
              leading: const Icon(Icons.bookmark),
              title: const Text("Learning resources"),
              subtitle: const Text("Books, websites, videos, alphabet"),
              onTap: () => Push(const LearningResources()),
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text("Favourites"),
              subtitle: const Text("Aya, hadith, names of allah"),
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
            ListTile(
              leading: const Icon(Icons.translate_rounded),
              title: const Text("Translations"),
              subtitle: const Text("Multiple translations, language selection"),
              onTap: () => {},
              enabled: false,
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.school_rounded),
              title: Text("How to use this app"),
              subtitle: Text("User guide"),
              enabled: false,
            ),
            const ListTile(
              leading: Icon(Icons.share_rounded),
              title: Text("Share"),
              enabled: false,
            ),
            const ListTile(
              leading: Icon(Icons.thumbs_up_down_rounded),
              title: Text("Rate the app"),
              enabled: false,
            ),
            ListTile(
              leading: const Icon(Icons.question_answer_rounded),
              title: const Text("Help and Feedback"),
              subtitle: const Text("Contact, recommendations"),
              onTap: () => launchUri(context, Uri.parse("https://google.com")),
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
                  const Text("Meet the developers"), // TODO find a better icon
              onTap: () => Push(const AboutDeveloper()),
            ),
            ListTile(
              leading: const Icon(Icons.code_rounded),
              title: const Text("Sources and Licencing"),
              onTap: () => {},
              enabled: false,
            ),
          ],
        ));
  }
}

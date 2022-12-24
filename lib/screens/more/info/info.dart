import 'package:din/constants/strings.dart';
import 'package:din/utils/json.dart';
import 'package:din/widgets/back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';

import '/screens/more/info/about_app.dart';
import '/screens/more/info/about_developer.dart';
import '/utils/network.dart';
import '/widgets/icons.dart';
import '/widgets/theme_toggle_button.dart';

class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
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
        leading: const CustomBackButton(),
        title: const Text("App info"),
        actions: const [ThemeToggleButton()],
      ),
      body: ListView(
        children: [
          const DinAppIcon(),
          ListTile(
            title: const Text("App details"),
            subtitle: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.info_outline_rounded),
                  title: const Text("About the app"),
                  onTap: () => push(const AboutApp()),
                ),
                ListTile(
                  leading: const Icon(Icons.badge_outlined),
                  title: const Text("Meet the developer"),
                  onTap: () => push(const AboutDeveloper()),
                ),
                ListTile(
                  leading: const Icon(Icons.code_rounded),
                  title: const Text("Sources and Licencing"),
                  onTap: () =>
                      openLink("https://github.com/tallestlegacy/din_dt"),
                  trailing: linkIcon,
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.info_rounded),
                  enabled: false,
                  title: Text("Version ${_packageInfo.version}"),
                  subtitle:
                      Text("(Build number : ${_packageInfo.buildNumber})"),
                )
              ],
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text("Review and Share"),
            subtitle: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.share_rounded),
                  title: const Text("Share"),
                  onTap: () async {
                    await Share.share(
                      'Din - Quran and Sunnah (PlayStore) \n https://play.google.com/store/apps/details?id=com.tallestlegacy.din_dt',
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.thumbs_up_down_rounded),
                  title: const Text("Rate the app"),
                  onTap: () {
                    openLink(
                        "https://play.google.com/store/apps/details?id=com.tallestlegacy.din_dt");
                  },
                  trailing: linkIcon,
                ),
                ListTile(
                  leading: const Icon(Icons.question_answer_rounded),
                  title: const Text("Help and Feedback"),
                  subtitle: const Text("Contact, recommendations"),
                  onTap: () => openLink(
                    "mailto:tallestlegacy@gmail.com?subject=Din > Help and Feedback",
                  ),
                  trailing: linkIcon,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

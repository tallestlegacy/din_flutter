import 'package:din/widgets/back_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';

import '/widgets/divider.dart';
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

  late ScrollController _scrollController;
  static const kExpandedHeight = 300.0;

  @override
  void initState() {
    super.initState();
    _initPackageInfo();

    _scrollController = ScrollController()..addListener(() {});
  }

  bool get _isSliverAppBarExpanded {
    return _scrollController.hasClients &&
        _scrollController.offset > kExpandedHeight - kToolbarHeight;
  }

  @override
  Widget build(BuildContext context) {
    void push(Widget page) {
      Navigator.push(context, CupertinoPageRoute(builder: (context) => page));
    }

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            leading: const CustomBackButton(),
            actions: const [ThemeToggleButton()],
            pinned: true,
            snap: false,
            floating: false,
            stretch: true,
            elevation: 2,
            expandedHeight: kExpandedHeight,
            flexibleSpace: _isSliverAppBarExpanded
                ? null
                : FlexibleSpaceBar(
                    background: Container(
                      color: Theme.of(context).primaryColor,
                      child: const DinAppIcon(),
                    ),
                    stretchModes: const [
                      StretchMode.zoomBackground,
                    ],
                  ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
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
                        title: Text("Version ${_packageInfo.version}"),
                        subtitle: Text(
                            "(Build number : ${_packageInfo.buildNumber})"),
                        trailing: copyIcon,
                        onLongPress: () {
                          String versionInfo = "Version ${_packageInfo.version}"
                              "(Build number : ${_packageInfo.buildNumber})";
                          Clipboard.setData(ClipboardData(text: versionInfo));
                          var scaffold = ScaffoldMessenger.of(context);
                          scaffold.showSnackBar(
                            const SnackBar(
                              content: Text("Copied version info"),
                            ),
                          );
                        },
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
                        trailing: shareIcon,
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
                      const Spacing(padding: 64),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

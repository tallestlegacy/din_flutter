import 'package:din/components/back_button.dart';
import 'package:din/widgets/theme_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LearningResources extends StatelessWidget {
  const LearningResources({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Learning Resources"),
        backgroundColor: Theme.of(context).backgroundColor,
        leading: const CustomBackButton(),
        actions: const [ThemeToggleButton()],
      ),
      body: ListView(children: [
        ListTile(
          leading: const Icon(Icons.stars_rounded),
          title: const Text("Pillars of Islam"),
          subtitle: const Text("The 5 pillars of islam"),
          onTap: () {},
          enabled: false,
        ),
        const Divider(),
        ListTile(
          leading: const Icon(FontAwesomeIcons.youtube),
          title: const Text("Youtube"),
          onTap: () {},
          enabled: false,
        ),
        ListTile(
          leading: const Icon(Icons.abc_rounded),
          title: const Text("Arabic alphabet"),
          onTap: () {},
          enabled: false,
        )
      ]),
    );
  }
}

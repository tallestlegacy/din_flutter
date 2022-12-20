import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '/widgets/icons.dart';
import '/widgets/back_button.dart';
import '/utils/network.dart';

class AboutDeveloper extends StatelessWidget {
  const AboutDeveloper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("This is me"),
        leading: const CustomBackButton(),
        //backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                "Marvin Mokua",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            ListTile(
              leading: const Icon(FontAwesomeIcons.github),
              title: const Text("Github"),
              subtitle: const Text("github.com/tallestlegacy"),
              onTap: () {
                openLink("https://github.com/tallestlegacy");
              },
              trailing: linkIcon,
            ),
            const Divider(),
            ListTile(
              leading: const Icon(FontAwesomeIcons.linkedin),
              title: const Text("LinkedIn"),
              subtitle: const Text("linkedin.com/in/marvin-mokua"),
              onTap: () {
                openLink("https://linkedin.com/in/marvin-mokua");
              },
              trailing: linkIcon,
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.mail),
              title: const Text("Email"),
              subtitle: const Text("tallestlegacy@gmail.com"),
              onTap: () {
                openLink("mailto:tallestlegacy@gmail.com");
              },
              trailing: linkIcon,
            ),
          ],
        ),
      ),
    );
  }
}

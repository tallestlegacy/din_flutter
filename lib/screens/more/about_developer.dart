import 'package:din/components/back_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutDeveloper extends StatelessWidget {
  const AboutDeveloper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About me"),
        leading: const CustomBackButton(),
        backgroundColor: Theme.of(context).backgroundColor,
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
            const ListTile(
              leading: Icon(FontAwesomeIcons.github),
              title: Text("Github"),
              subtitle: Text("tallestlegacy@github.com"),
            ),
            const ListTile(
              leading: Icon(FontAwesomeIcons.linkedin),
              title: Text("LinkedIn"),
              subtitle: Text("linkedin.com/in/marvin-mokua"),
            ),
            const ListTile(
              leading: Icon(Icons.mail),
              title: Text("Email"),
              subtitle: Text("tallestlegacy@gmail.com"),
            ),
          ],
        ),
      ),
    );
  }
}

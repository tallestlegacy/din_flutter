import 'package:flutter/material.dart';

class Translation extends StatelessWidget {
  String edition;
  Translation({super.key, required this.edition});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.translate_rounded),
      title: Text(edition),
      trailing: Icon(Icons.download_rounded),
    );
  }
}

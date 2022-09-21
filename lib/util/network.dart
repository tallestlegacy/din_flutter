import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchUri(BuildContext context, Uri uri) async {
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showMaterialBanner(
      const MaterialBanner(
        content: Text("Cannot launch url"),
        actions: [],
      ),
    );
    throw "Could not launch url";
  }
}

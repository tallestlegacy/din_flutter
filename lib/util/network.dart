import 'package:url_launcher/url_launcher.dart';

Future<void> openLink(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw "Could not launch $url";
  }
}

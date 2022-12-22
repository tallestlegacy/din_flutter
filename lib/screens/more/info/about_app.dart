import 'package:din/widgets/icons.dart';
import 'package:din/widgets/theme_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '/widgets/back_button.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    const String data = """ 
### Vision
I wanted to create an application than includes everyone, a platform that doesn't 
discriminate user preferences, whether it's font size or text colour. To create
an inclusive environment where everyone can be comfortable reading their Quran and 
Hadith or Dua how they felt was best for them.  

Din is an open source, ad-free mobile app for the anyone interested in Islamic
literature and canon, for the average muslim and for any curious cats who need a
reference or want to learn the Islamic way.

Feel free to choose your preferred translation, or whether to show translations 
altogether. **Change the default theme**, choose whether you want to swipe left to
right or right to left. There's more Arabic fonts than you need.


### Privacy Policy
Din does not need or collect any user data. All your preferences and network
information is left on your device. We require a few permissions for some **opt-in 
features** to work.

#### Internet Access
The app needs internet access to download multi-lingual translations and download
adhan.

#### Location
The app requires location services to be on for Prayer times and Qibla direction 
to be synced. This data remains in your phone. Please allow Location services
when you want to use this feature, and turn on location during calibration.

""";

    return Scaffold(
      appBar: AppBar(
        title: const Text("About the app"),
        leading: const CustomBackButton(),
        actions: const [ThemeToggleButton()],
      ),
      body: SafeArea(
        bottom: true,
        child: ListView(
            padding:
                const EdgeInsets.only(top: 32, bottom: 16, left: 16, right: 16),
            children: const [
              MarkdownBody(data: data),
              DinAppIcon(),
            ]),
      ),
    );
  }
}

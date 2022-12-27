import 'package:din/widgets/theme_toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '/widgets/back_button.dart';

class AboutApp extends StatelessWidget {
  const AboutApp({super.key});

  @override
  Widget build(BuildContext context) {
    const String visionData = """ 
### My Vision
I wanted to create an application than includes everyone, a platform that doesn't 
discriminate user preferences, whether it's font size or text colour. To create
an inclusive environment where everyone can be comfortable reading their Quran and 
Hadith or Dua how they felt was best for them.  

Din is an **open source**, ad-free mobile app for the anyone interested in Islamic
literature and canon, for the average muslim and for any curious cats who need a
reference or want to learn the Islamic way.

Feel free to choose your preferred translation, or whether to show translations 
altogether. *Change the default theme*, choose whether you want to swipe left to
right or right to left. There's even more Arabic fonts than you'd ever need.
""";
    const String policyData = """
### Privacy Policy
Din does not need or collect any user data. All your preferences and network
information is left on your device. We require a few permissions for some **opt-in 
features** to work.

#### Internet Access
The app needs internet access to download translations

#### Location
The app requires location services to be on for Prayer times and Qibla direction 
to be synced. This data remains in your phone. Please allow Location services
when you want to use this feature, and turn on location during calibration.
""";

    const String featureImprovements = """
### Improvements & Feature Suggestions

The app is actively being built and the following improvements are underway
-  Compass rotations animation is a little laggy
-  Pinch to zoom on all text pages  
-  Juz page may undergo some UI and performance improvements.

And here are some of the incoming features
1.  Adhan notifications
1.  Global search (quran, hadith and dua) with match highlighting
1.  Quran commentary (from online sources)
1.  99 names commentary (from online sources)
1.  Qira'at
1.  Tajweed and its guidelines
1.  Islamic literature library

Thank you to all the people I've been nagging about testing this app, you're the 
reason that keeps me coding, and anyone can reach out to me [tallestlegacy@gmail.com](email)
for inquiries and feature suggestions.

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
              MarkdownBody(data: visionData),
              Divider(),
              MarkdownBody(data: policyData),
              Divider(),
              MarkdownBody(data: featureImprovements),
            ]),
      ),
    );
  }
}

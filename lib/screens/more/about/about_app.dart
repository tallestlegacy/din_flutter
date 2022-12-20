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

Feel free to choose your prefered translation, or whether to show translations 
altogether. **Change the default theme**, choose wether you want to swipe left to
right or right to left.

### Privacy Policy
Din does not need or collect any user data. All your preferences and network
information is left on your device.
""";

    return Scaffold(
      appBar: AppBar(
        title: const Text("About the app"),
        leading: const CustomBackButton(),
        //backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 32, bottom: 16, left: 16, right: 16),
          child: MarkdownBody(
            data: data,
          ),
        ),
      ),
    );
  }
}

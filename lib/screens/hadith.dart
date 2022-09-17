import 'package:din/components/bukhari.dart';
import 'package:din/components/hisnul.dart';
import 'package:flutter/material.dart';

class Hadith extends StatefulWidget {
  final ScrollController scrollController;

  const Hadith({Key? key, required this.scrollController}) : super(key: key);

  @override
  State<Hadith> createState() => _HadithState();
}

class _HadithState extends State<Hadith> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TabBar(
                indicatorColor: Theme.of(context).colorScheme.primary,
                tabs: const <Widget>[
                  Tab(child: Text("Bukhari")),
                  Tab(child: Text("HisnulMuslim")),
                ],
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Bukhari(),
            Hisnul(),
          ],
        ),
      ),
    );
  }
}

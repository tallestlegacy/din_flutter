import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Debug extends StatefulWidget {
  const Debug({super.key});

  @override
  State<Debug> createState() => _DebugState();
}

class _DebugState extends State<Debug> {
  double _value = 20;

  @override
  Widget build(BuildContext context) {
    final List<String> _tabs = <String>['Tab 1', 'Tab 2'];
    return Scaffold(
      body: Center(
        child: IconButton(
          icon: const Icon(Icons.navigate_next_rounded),
          onPressed: () {
            Navigator.push(
              context,
              PageTransition(
                child: Scaffold(
                  appBar: AppBar(
                    title: const Text("Hello"),
                  ),
                ),
                type: PageTransitionType.rightToLeftJoined,
                childCurrent: this.widget,
              ),
            );
          },
        ),
      ),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';

class SliverAppBarStatus extends StatefulWidget {
  const SliverAppBarStatus({Key? key}) : super(key: key);

  @override
  _SliverAppBarStatusState createState() => _SliverAppBarStatusState();
}

class _SliverAppBarStatusState extends State<SliverAppBarStatus> {
  late ScrollController _scrollController;
  Color _textColor = Colors.white;
  static const kExpandedHeight = 200.0;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          _textColor = _isSliverAppBarExpanded ? Colors.white : Colors.black;
        });
      });
  }

  bool get _isSliverAppBarExpanded {
    return _scrollController.hasClients &&
        _scrollController.offset > kExpandedHeight - kToolbarHeight;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverAppBar(
            // show and hide SliverAppBar Title
            title: _isSliverAppBarExpanded
                ? Text(
                    'App Bar Title',
                    style: TextStyle(color: _textColor),
                  )
                : null,
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: kExpandedHeight,
            // show and hide FlexibleSpaceBar title
            flexibleSpace: _isSliverAppBarExpanded
                ? null
                : FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(
                      'Beach',
                      textScaleFactor: 1,
                      style: TextStyle(
                          color: _textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 30),
                    ),
                    background: Container(
                      color: Theme.of(context).primaryColor,
                    )),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, int index) {
                return ListTile(
                  leading: Container(
                    margin: const EdgeInsets.all(8.0),
                    color: Colors
                        .primaries[Random().nextInt(Colors.primaries.length)],
                    padding: const EdgeInsets.all(8),
                    width: 100,
                  ),
                  title: Text('Place ${index + 1}', textScaleFactor: 1.5),
                );
              },
              childCount: 20,
            ),
          ),
        ],
      ),
    );
  }
}

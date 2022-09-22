import 'package:flutter/material.dart';

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
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  title: const Text('Books'),
                  floating: true,
                  pinned: true,
                  snap: false,
                  forceElevated: innerBoxIsScrolled,
                  bottom: TabBar(
                    tabs: _tabs.map((String name) => Tab(text: name)).toList(),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: _tabs.map((String name) {
              return SafeArea(
                top: false,
                bottom: false,
                child: Builder(
                  builder: (BuildContext context) {
                    return CustomScrollView(
                      key: PageStorageKey<String>(name),
                      slivers: <Widget>[
                        SliverOverlapInjector(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.all(8.0),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return ListTile(
                                  title: Text('Item $index'),
                                );
                              },
                              childCount: 30,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

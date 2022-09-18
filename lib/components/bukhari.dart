import 'package:din/util/json.dart';
import 'package:flutter/material.dart';

class Bukhari extends StatefulWidget {
  const Bukhari({Key? key}) : super(key: key);

  @override
  State<Bukhari> createState() => _BukhariState();
}

class _BukhariState extends State<Bukhari> {
  List _volumes = [];
  int length = 97;

  Future<void> getVolumes() async {
    var data = await LoadJson().load("assets/json/hadith/bukhari/index.json");
    if (mounted) {
      setState(() {
        _volumes = data;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getVolumes();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: _volumes.length,
      itemBuilder: (context, index) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "${_volumes[index]['name']}",
              style: TextStyle(
                fontSize: 24,
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          for (var book in _volumes[index]['books'])
            Card(
              child: ListTile(
                title: Text(
                  "${book['name']}",
                ),
                trailing: Text(
                  "${book['length']}",
                  style: const TextStyle(color: Colors.grey),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BukhariHadiths(
                        book: book,
                      ),
                    ),
                  );
                },
              ),
            )
        ],
      ),
    );
  }
}

class BukhariHadiths extends StatefulWidget {
  final book;
  const BukhariHadiths({Key? key, required this.book}) : super(key: key);

  @override
  State<BukhariHadiths> createState() => _BukhariHadithsState();
}

class _BukhariHadithsState extends State<BukhariHadiths> {
  var _hadiths = [];
  Future<void> getHadiths() async {
    var data = await LoadJson()
        .load("assets/json/hadith/bukhari/${widget.book['id']}.json");
    if (mounted) {
      setState(() {
        _hadiths = data['hadiths'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getHadiths();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.book['name']}"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _hadiths.length,
        itemBuilder: (context, index) => Card(
          child: ListTile(
            leading: Text(
              _hadiths[index]['id'].toString(),
              style: const TextStyle(color: Colors.grey),
            ),
            title: Text(_hadiths[index]['by']),
            subtitle: Text(_hadiths[index]['text']),
          ),
        ),
      ),
    );
  }
}
import 'package:din/util/json.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Bukhari extends StatefulWidget {
  const Bukhari({Key? key}) : super(key: key);

  @override
  _BukhariState createState() => _BukhariState();
}

class _BukhariState extends State<Bukhari> {
  List _books = [];
  int length = 97;

  Future<void> getBooks() async {
    var data = await LoadJson().load("assets/json/hadith/bukhari/index.json");
    if (mounted) {
      setState(() {
        _books = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    getBooks();
    return ListView.builder(
      itemCount: _books.length,
      itemBuilder: (context, index) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text("${_books[index]['name']}",
                style: TextStyle(
                    fontSize: 24, color: Theme.of(context).accentColor)),
          ),
          for (var book in _books[index]['books'])
            Card(
              elevation: .5,
              child: ListTile(
                dense: true,
                leading: Text("${book['hadiths'].length}"),
                title: Text("${book['name']}"),
                trailing: const Icon(CupertinoIcons.right_chevron, size: 16),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BukhariHadiths(book: book),
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

class BukhariHadiths extends StatelessWidget {
  var book;

  BukhariHadiths({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${book['name']}"),
      ),
      body: ListView.builder(
          itemCount: book['hadiths'].length,
          itemBuilder: (context, index) => Card(
                child: ListTile(
                  title: Text("${book['hadiths'][index]['by']}"),
                  subtitle: Text("${book['hadiths'][index]['text']}"),
                  leading: Text("${index + 1}"),
                  minLeadingWidth: 4,
                  minVerticalPadding: 16,
                ),
              )),
    );
  }
}

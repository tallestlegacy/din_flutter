import 'package:din/util/json.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Hisnul extends StatefulWidget {
  const Hisnul({Key? key}) : super(key: key);

  @override
  _HisnulState createState() => _HisnulState();
}

class _HisnulState extends State<Hisnul> {
  var _refs = [];

  Future<void> getRefs() async {
    var data =
        await LoadJson().load("assets/json/hadith/hisnulmuslim/index.json");
    if (mounted) {
      setState(() {
        _refs = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    getRefs();

    return ListView.builder(
      itemBuilder: (context, index) {
        return Card(
            elevation: 0.5,
            child: ListTile(
              dense: true,
              leading: Text("${_refs[index]['hadiths'].length}"),
              trailing: const Icon(CupertinoIcons.right_chevron, size: 16),
              title: Text("${_refs[index]['title']}"),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HisnulReference(ref: _refs[index]),
                ),
              ),
            ));
      },
      itemCount: _refs.length,
    );
  }
}

class HisnulReference extends StatelessWidget {
  var ref;
  HisnulReference({Key? key, required this.ref}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("${ref['title']}"),
      ),
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: ListView.builder(
          itemCount: ref['hadiths'].length,
          itemBuilder: (context, index) => Card(
            child: ListTile(
              title: Text(ref['hadiths'][index]['text']
                  .toString()
                  .replaceAll("\n", " ")),
              subtitle: Text(ref['hadiths'][index]['translation']
                  .toString()
                  .replaceAll("\n", " ")),
              leading: Text("${ref['hadiths'][index]['id']}"),
              minLeadingWidth: 4,
              minVerticalPadding: 16,
              dense: true,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:din/util/json.dart';
import 'package:flutter/material.dart';

class Hisnul extends StatefulWidget {
  const Hisnul({Key? key}) : super(key: key);

  @override
  State<Hisnul> createState() => _HisnulState();
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
  void initState() {
    super.initState();
    getRefs();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            trailing: Text(
              "${_refs[index]['hadiths'].length}",
              style: const TextStyle(color: Colors.grey),
            ),
            title: Text("${_refs[index]['title']}"),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HisnulReference(ref: _refs[index]),
              ),
            ),
          ),
        );
      },
      itemCount: _refs.length,
    );
  }
}

class HisnulReference extends StatelessWidget {
  final ref;
  const HisnulReference({Key? key, required this.ref}) : super(key: key);

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
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: ref['hadiths'].length,
        itemBuilder: (context, index) => Card(
          child: ListTile(
            title: Text(
                ref['hadiths'][index]['text'].toString().replaceAll("\n", " ")),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(ref['hadiths'][index]['transliteration']
                    .toString()
                    .replaceAll("\n", " ")),
                Text(ref['hadiths'][index]['translation']
                    .toString()
                    .replaceAll("\n", " ")),
              ],
            ),
            leading: Text(
              "${ref['hadiths'][index]['id']}",
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        ),
      ),
    );
  }
}

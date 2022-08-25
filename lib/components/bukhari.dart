import 'package:flutter/widgets.dart';

class Bukhari extends StatefulWidget {
  const Bukhari({Key? key}) : super(key: key);

  @override
  _BukhariState createState() => _BukhariState();
}

class _BukhariState extends State<Bukhari> {
  List _books = [];
  const length = 97;

  Future<void> getBooks() async {
    for (int i = 0; i < length; i++) {}
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Bukhari"),
    );
  }
}

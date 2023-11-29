import 'package:flutter/material.dart';
import 'package:uno/uno.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}

void fetchBooks () {
  final uno = Uno();

    uno.get('https://escribo.com/books.json').then((response){
      print(response.data); // it's a Map<String, dynamic>.
    }).catchError((error){
      print(error); // It's a UnoError.
    });
}

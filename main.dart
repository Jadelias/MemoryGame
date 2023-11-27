
import 'package:flutter/material.dart';
import 'main_menu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memory Test',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MainMenuPage(players: []),
    );
  }
}
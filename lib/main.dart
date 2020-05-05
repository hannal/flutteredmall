import 'package:flutter/material.dart';
import './toppage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      ),
      home: TopPage(title: 'Flutterred Mall'),
    );
  }
}

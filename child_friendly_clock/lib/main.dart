import 'package:flutter/material.dart';
import 'package:child_friendly_clock/src/home/view/home.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primaryColor: Color(0xff2d2e40),
      ),
      home: new Home(),
    );
  }
}

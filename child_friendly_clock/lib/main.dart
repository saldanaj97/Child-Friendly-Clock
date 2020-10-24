import 'package:child_friendly_clock/src/alarm/view/alarm.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:child_friendly_clock/src/home/view/home.dart';
import 'package:child_friendly_clock/src/alarm/view/alarm_create.dart';
import './src/stopwatch/view/stopwatch.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Stopwatch(),
    );
  }
}

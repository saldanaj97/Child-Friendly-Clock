import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:child_friendly_clock/src/home/view/home.dart';

void main() async {
  // Removed temporarily while working on fixing bugs
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primaryColor: Color(0xff2d2e40),
      ),
      home: Splash2(),
    );
  }
}

class Splash2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 4,
      navigateAfterSeconds: new Home(),
      image: Image.asset(
        'assets/images/SplashScreen.png',
        scale: .1,
      ),
      backgroundColor: Color(0xff2d2e40),
      loadingText: Text(
        "Loading",
        style: TextStyle(color: Colors.white),
      ),
      photoSize: 150.0,
      loaderColor: Colors.white,
    );
  }
}

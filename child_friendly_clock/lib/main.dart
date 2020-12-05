import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:child_friendly_clock/src/home/view/home.dart';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import './src/alarm/view/note.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import './src/alarm/utils/globals.dart' as globals;

/// The name associated with the UI isolate's [SendPort].
const String isolateName = 'isolate';

/// A port used to communicate from a background isolate to the UI isolate.
final ReceivePort port = ReceivePort();

final navigatorKey = GlobalKey<NavigatorState>();



void main() async {
  // Removed temporarily while working on fixing bugs
  WidgetsFlutterBinding.ensureInitialized();
  // Register the UI isolate's SendPort to allow for communication from the
  // background isolate.
  IsolateNameServer.registerPortWithName(
    port.sendPort,
    isolateName,
  );

  await AndroidAlarmManager.initialize();
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('notif_icon');
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,);
  await globals.flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
        if (payload != null) {
          print("clicked on notification: $payload");
          SendPort port;
          port ??= IsolateNameServer.lookupPortByName('alarm $payload isolate');
          port?.send(payload);
        }
      });
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  void onAlarm(dynamic id) async{
    int i = id;
    print("Alarm $id has fired.");
    showNote(navigatorKey.currentContext, "ALARM!!", i);
  }
  @override
  Widget build(BuildContext context) {
    port.listen(onAlarm);
    return new MaterialApp(
      theme: new ThemeData(
        primaryColor: Color(0xff2d2e40),
      ),
      home: Splash2(),
      navigatorKey: navigatorKey,
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

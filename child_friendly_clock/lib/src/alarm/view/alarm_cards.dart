import 'dart:ui';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:child_friendly_clock/src/alarm/utils/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:child_friendly_clock/src/alarm/model/Alarm.dart';
import 'package:child_friendly_clock/src/alarm/view/edit_alarms.dart';
import '../view/note.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'dart:isolate';
import '../utils/globals.dart' as globals;
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class AlarmCards extends StatefulWidget {
  final Alarm alarm;
  final VoidCallback updateListCallback;
  AlarmCards({this.alarm, this.updateListCallback});

  @override
  _AlarmCardsState createState() => _AlarmCardsState();
}



class _AlarmCardsState extends State<AlarmCards> {
  Future alarmsFuture;

  @override
  void initState() {
    super.initState();
    alarmsFuture = getAlarms();
  }

  getAlarms() async {
    final alarmsData = await DBProvider.db.getAlarms();
    return alarmsData;
  }

  bool isSwitched = false;
  bool canSave = false;

  String intToDay(int i) {
    if (i == 0)
      return "Sun";
    else if (i == 1)
      return "Mon";
    else if (i == 2)
      return "Tues";
    else if (i == 3)
      return "Wed";
    else if (i == 4)
      return "Thur";
    else if (i == 5)
      return "Fri";
    else if (i == 6) return "Sat";
    return "";
  }

  @override
  Widget build(BuildContext context) {
    var time;
    var height = 155.0;
    var freq = "";

    List<List<int>> groups = [];

    if (widget.alarm.period == "PM" && widget.alarm.hour != 12)
      time = TimeOfDay(hour: widget.alarm.hour + 12, minute: widget.alarm.minute);
    else if (widget.alarm.period == "AM" && widget.alarm.hour == 12)
      time = TimeOfDay(hour: widget.alarm.hour - 12, minute: widget.alarm.minute);
    else
      time = TimeOfDay(hour: widget.alarm.hour, minute: widget.alarm.minute);

    for (int i = 0; i < 7; i++) {
      List<int> group = [];
      while (widget.alarm.frequency[i] == 1) {
        group.add(i);
        if (i == 6) break;
        i++;
      }
      if (group.isNotEmpty) groups.add(group);
    }
    for (int i = 0; i < groups.length; i++) {
      if (i == 0) {
        if (groups[i].length == 1)
          freq = intToDay(groups[i].first);
        else if (groups[i].length == 2)
          freq = intToDay(groups[i].first) + ", " + intToDay(groups[i].last);
        else
          freq = intToDay(groups[i].first) + " - " + intToDay(groups[i].last);
      } else if (i == groups.length - 1) {
        if (groups[i].length == 1)
          freq = freq + " & " + intToDay(groups[i].first);
        else if (groups[i].length == 2)
          freq = freq + ", " + intToDay(groups[i].first) + " & " + intToDay(groups[i].last);
        else
          freq = freq + " & " + intToDay(groups[i].first) + " - " + intToDay(groups[i].last);
      } else {
        if (groups[i].length == 1)
          freq = freq + ", " + intToDay(groups[i].first);
        else if (groups[i].length == 2)
          freq = freq + ", " + intToDay(groups[i].first) + ", " + intToDay(groups[i].last);
        else
          freq = freq + ", " + intToDay(groups[i].first) + " - " + intToDay(groups[i].last);
      }
    }

    if(widget.alarm.enabled == 1){
      isSwitched = true;
    }
    else{
      isSwitched = false;
    }

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) async {
                await DBProvider.db.deleteAlarm(widget.alarm.alarmID);
                Scaffold.of(context).showSnackBar(SnackBar(content: Text(widget.alarm.name + ' deleted')));
                widget.updateListCallback();
                for(int i = 0; i < 8; i++)
                  await AndroidAlarmManager.cancel(widget.alarm.alarmID+i);
              },
              background: Container(
                color: Colors.red,
              ),
              child: Container(
                width: 350,
                height: height,
                child: Card(
                  color: Color(0xFF434974),
                  elevation: 15,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.arrow_right,
                                        size: 45,
                                        color: Colors.white,
                                      ),
                                      Container(
                                        child: Text(
                                          widget.alarm.name,
                                          style: TextStyle(
                                            fontFamily: 'Open Sans',
                                            fontSize: 23,
                                            color: const Color(0xffffffff),
                                            fontWeight: FontWeight.w600,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                /* **** ON/OFF SWITCH **** */
                                Container(
                                  child: Switch(
                                    value: isSwitched,
                                    onChanged: (value) async {
                                      if(value){
                                        widget.alarm.enabled = 1;
                                      }
                                      else{
                                        widget.alarm.enabled = 0;
                                      }
                                      isSwitched = value;
                                      await DBProvider.db.editAlarm(widget.alarm);
                                      alarmSetup(widget.alarm, isSwitched);
                                      widget.updateListCallback();
                                    },
                                    activeTrackColor: Colors.lightGreenAccent,
                                    activeColor: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    time.format(context),
                                    style: TextStyle(
                                      fontFamily: 'Open Sans',
                                      fontSize: 40,
                                      color: const Color(0xffffffff),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  IconButton(
                                      icon: Icon(
                                        Icons.speaker_notes,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        // showNote takes in context and a string so
                                        // replace 'User ... ' with the note from the db
                                        showNote(context, widget.alarm.note, -1);
                                      })
                                ],
                              ),
                            ),
                            /* *** Days / Edit Button *** */
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              width: 325,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    freq,
                                    style: TextStyle(
                                      fontFamily: 'Open Sans',
                                      fontSize: 15,
                                      color: const Color(0xffffffff),
                                      fontWeight: FontWeight.w300,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  IconButton(
                                    padding: EdgeInsets.only(),
                                    icon: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditAlarm(
                                            editAlarm: widget.alarm,
                                            clickCallback: () => setState(
                                              () {
                                                alarmsFuture = getAlarms();
                                              },
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  void alarmSetup(Alarm setupAlarm, bool value) async{
    print("Setting Up Alarm");
    int addHour;
    if (setupAlarm.period == "AM") {
      addHour = 0;
      if(setupAlarm.hour == 12)
        addHour = -12;
    } else {
      addHour = 12;
    }
    int hours = (setupAlarm.hour + addHour);
    int minute = setupAlarm.minute;
    DateTime monday;
    DateTime tuesday;
    DateTime wednesday;
    DateTime thursday;
    DateTime friday;
    DateTime saturday;
    DateTime sunday;
    DateTime now = new DateTime.now();
    int month = now.month;
    int day = now.day;
    int year = now.year;

    DateTime oneshot = new DateTime(year, month, day, hours, minute);
    //depending on what day it is, we will create alarm times for the next 7 days
    switch(now.weekday){
      //if it is monday
      case(1):
        if(now.hour > hours){
          monday = new DateTime(year, month, day+7, hours, minute);
        }
        else if(now.hour == hours && now.minute >= minute){
          monday = new DateTime(year, month, day+7, hours, minute);
        }
        else{
          monday = new DateTime(year, month, day, hours, minute);
        }
        tuesday = new DateTime(year, month, day+1, hours, minute);
        wednesday = new DateTime(year, month, day+2, hours, minute);
        thursday = new DateTime(year, month, day+3, hours, minute);
        friday = new DateTime(year, month, day+4, hours, minute);
        saturday = new DateTime(year, month, day+5, hours, minute);
        sunday = new DateTime(year, month, day+6, hours, minute);
        break;

      //if it is tuesday
      case(2):
        if(now.hour > hours){
          tuesday = new DateTime(year, month, day+7, hours, minute);
        }
        else if(now.hour == hours && now.minute >= minute){
          tuesday = new DateTime(year, month, day+7, hours, minute);
        }
        else{
          tuesday = new DateTime(year, month, day, hours, minute);
        }
        monday = new DateTime(year, month, day+6, hours, minute);
        wednesday = new DateTime(year, month, day+1, hours, minute);
        thursday = new DateTime(year, month, day+2, hours, minute);
        friday = new DateTime(year, month, day+3, hours, minute);
        saturday = new DateTime(year, month, day+4, hours, minute);
        sunday = new DateTime(year, month, day+5, hours, minute);
        break;

      //if it is wednesday
      case(3):
        if(now.hour > hours){
          wednesday = new DateTime(year, month, day+7, hours, minute);
        }
        else if(now.hour == hours && now.minute >= minute){
          wednesday = new DateTime(year, month, day+7, hours, minute);
        }
        else{
          wednesday = new DateTime(year, month, day, hours, minute);
        }
        monday = new DateTime(year, month, day+5, hours, minute);
        tuesday = new DateTime(year, month, day+6, hours, minute);
        thursday = new DateTime(year, month, day+1, hours, minute);
        friday = new DateTime(year, month, day+2, hours, minute);
        saturday = new DateTime(year, month, day+3, hours, minute);
        sunday = new DateTime(year, month, day+4, hours, minute);
        break;

      //if it is thursday
      case(4):
        if(now.hour > hours){
          thursday = new DateTime(year, month, day+7, hours, minute);
        }
        else if(now.hour == hours && now.minute >= minute){
          thursday = new DateTime(year, month, day+7, hours, minute);
        }
        else{
          thursday = new DateTime(year, month, day, hours, minute);
        }
        monday = new DateTime(year, month, day+4, hours, minute);
        tuesday = new DateTime(year, month, day+5, hours, minute);
        wednesday = new DateTime(year, month, day+6, hours, minute);
        friday = new DateTime(year, month, day+1, hours, minute);
        saturday = new DateTime(year, month, day+2, hours, minute);
        sunday = new DateTime(year, month, day+3, hours, minute);
        break;

      //if it is friday
      case(5):
        if(now.hour > hours){
          friday = new DateTime(year, month, day+7, hours, minute);
        }
        else if(now.hour == hours && now.minute >= minute){
          friday = new DateTime(year, month, day+7, hours, minute);
        }
        else{
          friday = new DateTime(year, month, day, hours, minute);
        }
        monday = new DateTime(year, month, day+3, hours, minute);
        tuesday = new DateTime(year, month, day+4, hours, minute);
        wednesday = new DateTime(year, month, day+5, hours, minute);
        thursday = new DateTime(year, month, day+6, hours, minute);
        saturday = new DateTime(year, month, day+1, hours, minute);
        sunday = new DateTime(year, month, day+2, hours, minute);
        break;

      //if it is saturday
      case(6):
        if(now.hour > hours){
          saturday = new DateTime(year, month, day+7, hours, minute);
        }
        else if(now.hour == hours && now.minute >= minute){
          saturday = new DateTime(year, month, day+7, hours, minute);
        }
        else{
          saturday = new DateTime(year, month, day, hours, minute);
        }
        monday = new DateTime(year, month, day+2, hours, minute);
        tuesday = new DateTime(year, month, day+3, hours, minute);
        wednesday = new DateTime(year, month, day+4, hours, minute);
        thursday = new DateTime(year, month, day+5, hours, minute);
        friday = new DateTime(year, month, day+6, hours, minute);
        sunday = new DateTime(year, month, day+1, hours, minute);
        break;

      //if it is sunday
      case(7):
        if(now.hour > hours){
          sunday = new DateTime(year, month, day+7, hours, minute);
        }
        else if(now.hour == hours && now.minute >= minute){
          sunday = new DateTime(year, month, day+7, hours, minute);
        }
        else{
          sunday = new DateTime(year, month, day, hours, minute);
        }
        monday = new DateTime(year, month, day+1, hours, minute);
        tuesday = new DateTime(year, month, day+2, hours, minute);
        wednesday = new DateTime(year, month, day+3, hours, minute);
        thursday = new DateTime(year, month, day+4, hours, minute);
        friday = new DateTime(year, month, day+5, hours, minute);
        saturday = new DateTime(year, month, day+6, hours, minute);
        break;
    }

    tz.initializeTimeZones();
    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
    //if the switch is set to on, initialize alarms and have them repeat every 7 days
    int alarmID = widget.alarm.alarmID*10;
    if (value == true) {
      if (widget.alarm.frequency[0] == 1) {
        if(DateTime.now().isBefore(sunday)) {
          await AndroidAlarmManager.periodic(
              Duration(days: 7), alarmID, showPrint,
              startAt: sunday,
              exact: true,
              wakeup: true,
              rescheduleOnReboot: true);
        }
      }
      else{
        await AndroidAlarmManager.cancel(alarmID);
      }
      if (widget.alarm.frequency[1] == 1) {
        if(DateTime.now().isBefore(monday)){
          await AndroidAlarmManager.periodic(Duration(days: 7), alarmID+1, showPrint,
              startAt: monday,
              exact: true,
              wakeup: true,
              rescheduleOnReboot: true);
        }
      }
      else{
        await AndroidAlarmManager.cancel(alarmID+1);
      }
      if (widget.alarm.frequency[2] == 1) {
        if(DateTime.now().isBefore(tuesday)){
          await AndroidAlarmManager.periodic(Duration(days: 7), alarmID+2, showPrint,
            startAt: tuesday,
            exact: true,
            wakeup: true,
            rescheduleOnReboot: true);
        }
      }
      else{
        await AndroidAlarmManager.cancel(alarmID+2);
      }
      if (widget.alarm.frequency[3] == 1) {
        if(DateTime.now().isBefore(wednesday)){
          await AndroidAlarmManager.periodic(Duration(days: 7), alarmID+3, showPrint,
              startAt: wednesday,
              exact: true,
              wakeup: true,
              rescheduleOnReboot: true);
        }
      }
      else{
        await AndroidAlarmManager.cancel(alarmID+3);
      }
      if (widget.alarm.frequency[4] == 1) {
        print('calculated datetime: $thursday');
        if(DateTime.now().isBefore(thursday)) {
          await AndroidAlarmManager.periodic(
              Duration(days: 7), alarmID + 4, showPrint,
              startAt: thursday,
              exact: true,
              wakeup: true,
              rescheduleOnReboot: true);
        }
        else{
          await AndroidAlarmManager.periodic(
              Duration(days: 7), alarmID + 4, showPrint,
              startAt: _nextWeekInstanceOfDateTime(thursday),
              exact: true,
              wakeup: true,
              rescheduleOnReboot: true);
        }
      }
      else{
        await AndroidAlarmManager.cancel(alarmID+4);
      }
      if (widget.alarm.frequency[5] == 1) {
        if(DateTime.now().isBefore(friday)) {
          await AndroidAlarmManager.periodic(
              Duration(days: 7), alarmID + 5, showPrint,
              startAt: friday,
              exact: true,
              wakeup: true,
              rescheduleOnReboot: true);
        }
      }
      else{
        await AndroidAlarmManager.cancel(alarmID+5);
      }
      if (widget.alarm.frequency[6] == 1) {
        if(DateTime.now().isBefore(saturday)) {
          await AndroidAlarmManager.periodic(
              Duration(days: 7), alarmID + 6, showPrint,
              startAt: saturday,
              exact: true,
              wakeup: true,
              rescheduleOnReboot: true);
        }
      }
      else{
        await AndroidAlarmManager.cancel(alarmID+6);
      }
      if(!widget.alarm.frequency.contains(1)){
        if(DateTime.now().isBefore(oneshot)) {
          //no day was selected so just make the alarm for today.
          await AndroidAlarmManager.oneShotAt(oneshot, alarmID+7, showPrint);
          print("made one shot: $oneshot");
        }
        else{
          //time already passed today so make for tomorrow.
          DateTime newTime = _tomorrowInstanceOfDateTime(oneshot);
          await AndroidAlarmManager.oneShotAt(newTime, alarmID+7, showPrint);
          print("made one shot: $newTime");
        }
      }
      else{
        await AndroidAlarmManager.cancel(alarmID+7);
      }
      //cancel alarms if switch is set to off
    } else {
      await AndroidAlarmManager.cancel(alarmID);
      await AndroidAlarmManager.cancel(alarmID+1);
      await AndroidAlarmManager.cancel(alarmID+2);
      await AndroidAlarmManager.cancel(alarmID+3);
      await AndroidAlarmManager.cancel(alarmID+4);
      await AndroidAlarmManager.cancel(alarmID+5);
      await AndroidAlarmManager.cancel(alarmID+6);
      await AndroidAlarmManager.cancel(alarmID+7);
    }
  }
}

DateTime _tomorrowInstanceOfDateTime(DateTime dt){
  final DateTime now = DateTime.now();
  DateTime scheduledDate = DateTime(now.year, now.month, dt.day, dt.hour, dt.minute);
  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(const Duration(days: 1));
  }
  return scheduledDate;
}
DateTime _nextWeekInstanceOfDateTime(DateTime dt){
  final DateTime now = DateTime.now();
  DateTime scheduledDate = DateTime(now.year, now.month, dt.day, dt.hour, dt.minute);
  if (scheduledDate.isBefore(now)) {
    scheduledDate = scheduledDate.add(const Duration(days: 7));
  }
  return scheduledDate;
}

showPrint(int alarmID) async{
  print(alarmID);
  //Receive port to listen for when the user wants to turn off the alarm ringtone.
  final ReceivePort rPort = ReceivePort();
  IsolateNameServer.registerPortWithName(
    rPort.sendPort,
    "alarm $alarmID isolate",
  );
  rPort.listen((message) {
    FlutterRingtonePlayer.stop();
  });

  //This starts the ring tone.
  await FlutterRingtonePlayer.play(
    android: AndroidSounds.alarm,
    ios: IosSounds.alarm,
    looping: true,
    volume: 0.3,
    asAlarm: true,
  );

  var androidPlatformChannelSpecifics = new AndroidNotificationDetails('your channel id', 'your channel name', 'your channel description', importance: Importance.max, priority: Priority.high, icon: "notif_icon");
  var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
  var platformChannelSpecifics = new NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
  await globals.flutterLocalNotificationsPlugin.show(0, "Alarm!", "Click Here To Stop.", platformChannelSpecifics, payload: '$alarmID');

  // Send port to tell app that the alarm went off.
  SendPort uiSendPort;
  uiSendPort ??= IsolateNameServer.lookupPortByName('isolate');
  uiSendPort?.send(alarmID);
}



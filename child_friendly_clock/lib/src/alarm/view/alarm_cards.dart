import 'dart:ui';
import 'package:child_friendly_clock/src/alarm/utils/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:child_friendly_clock/src/alarm/model/Alarm.dart';
import 'package:child_friendly_clock/src/alarm/view/edit_alarms.dart';
import '../view/note.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';

class AlarmCards extends StatefulWidget {
  final Alarm alarm;
  final VoidCallback updateListCallback;
  AlarmCards({this.alarm, this.updateListCallback});

  @override
  _AlarmCardsState createState() => _AlarmCardsState();
}
showPrint(int i){
  print('alarm $i ');
  //showNote(, "Alarm");
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

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                DBProvider.db.deleteAlarm(widget.alarm.alarmID);
                widget.updateListCallback();
                Scaffold.of(context).showSnackBar(SnackBar(content: Text(widget.alarm.name + ' deleted')));
              },
              background: Container(
                color: Colors.red,
              ),
              child: Container(
                width: 325,
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
                                    onChanged: (value) {
                                      setState(() {
                                        isSwitched = value; //TODO: Make the on/off switch actually turn alarm on/off
                                        int addHour;
                                        if (widget.alarm.period == "AM") {
                                          addHour = 0;
                                        }
                                        else{
                                          addHour = 11;
                                        }
                                        int hours = (widget.alarm.hour + addHour);
                                        int minute = widget.alarm.minute;
                                        DateTime monday = new DateTime(2020, 11, 2, hours, minute);
                                        DateTime tuesday = new DateTime(2020, 11, 3, hours, minute);
                                        DateTime wednesday = new DateTime(2020, 11, 4, hours, minute);
                                        DateTime thursday = new DateTime(2020, 11, 5, hours, minute);
                                        DateTime friday = new DateTime(2020, 11, 6, hours, minute);
                                        DateTime saturday = new DateTime(2020, 11, 7, hours, minute);
                                        DateTime sunday = new DateTime(2020, 11, 1, hours, minute);
                                        DateTime now = new DateTime.now();



                                        print(isSwitched);
                                        if(value == true) {
                                          if(widget.alarm.frequency[0] == 1){
                                             AndroidAlarmManager.periodic(
                                                  Duration(minutes: 10),
                                                  0,
                                                  showPrint,
                                                  startAt: sunday,
                                                  exact: true,
                                                  wakeup: true,
                                                  rescheduleOnReboot: true);
                                          }
                                          if(widget.alarm.frequency[1] == 1){
                                            AndroidAlarmManager.periodic(
                                                Duration(minutes: 10),
                                                1,
                                                showPrint,
                                                startAt: monday,
                                                exact: true,
                                                wakeup: true,
                                                rescheduleOnReboot: true);
                                          }
                                          if(widget.alarm.frequency[2] == 1){
                                            AndroidAlarmManager.periodic(
                                                Duration(minutes: 10),
                                                2,
                                                showPrint,
                                                startAt: tuesday,
                                                exact: true,
                                                wakeup: true,
                                                rescheduleOnReboot: true);
                                          }
                                          if(widget.alarm.frequency[3] == 1){
                                            AndroidAlarmManager.periodic(
                                                Duration(minutes: 10),
                                                3,
                                                showPrint,
                                                startAt: wednesday,
                                                exact: true,
                                                wakeup: true,
                                                rescheduleOnReboot: true);
                                          }
                                          if(widget.alarm.frequency[4] == 1){
                                            AndroidAlarmManager.periodic(
                                                Duration(minutes: 10),
                                                4,
                                                showPrint,
                                                startAt: thursday,
                                                exact: true,
                                                wakeup: true,
                                                rescheduleOnReboot: true);
                                          }
                                          if(widget.alarm.frequency[5] == 1){
                                            AndroidAlarmManager.periodic(
                                                Duration(minutes: 10),
                                                5,
                                                showPrint,
                                                startAt: friday,
                                                exact: true,
                                                wakeup: true,
                                                rescheduleOnReboot: true);
                                          }
                                          if(widget.alarm.frequency[6] == 1){
                                            AndroidAlarmManager.periodic(
                                                Duration(minutes: 10),
                                                6,
                                                showPrint,
                                                startAt: saturday,
                                                exact: true,
                                                wakeup: true,
                                                rescheduleOnReboot: true);
                                          }
                                        }
                                        else{
                                          AndroidAlarmManager.cancel(0);
                                          AndroidAlarmManager.cancel(1);
                                          AndroidAlarmManager.cancel(2);
                                          AndroidAlarmManager.cancel(3);
                                          AndroidAlarmManager.cancel(4);
                                          AndroidAlarmManager.cancel(5);
                                          AndroidAlarmManager.cancel(6);
                                        }
                                      });
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
                                        print(widget.alarm.note);
                                        showNote(context, widget.alarm.note);
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
}

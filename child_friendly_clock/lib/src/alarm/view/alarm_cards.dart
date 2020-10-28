import 'package:child_friendly_clock/src/alarm/utils/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:child_friendly_clock/src/alarm/model/Alarm.dart';

class AlarmCards extends StatefulWidget {
  final Alarm alarm;
  final VoidCallback updateListCallback;
  AlarmCards({this.alarm, this.updateListCallback});

  @override
  _AlarmCardsState createState() => _AlarmCardsState();
}

class _AlarmCardsState extends State<AlarmCards> {
  bool isSwitched = false;

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
    var height = 150.0;
    var freq = "";

    List<List<int>> groups = [];

/*     print(widget.alarm.name);
    print('Hour Value: ' + '${widget.alarm.hour}');
    print('Period: ' + widget.alarm.period); */
    print('Frequency: ' + widget.alarm.frequency.toString());
    if (widget.alarm.period == "PM" && widget.alarm.hour != 12)
      time = TimeOfDay(hour: widget.alarm.hour + 12, minute: widget.alarm.minute);
    else if (widget.alarm.period == "AM" && widget.alarm.hour == 12)
      time = TimeOfDay(hour: widget.alarm.hour - 12, minute: widget.alarm.minute);
    else
      time = TimeOfDay(hour: widget.alarm.hour, minute: widget.alarm.minute);

    for (int i = 0; i < 7; i++) {
      List<int> group = [];
      while (widget.alarm.frequency[i]) {
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

    //print("groups: " + groups.toString());
    //print("frequency: " + freq);
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
                  child: Stack(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topCenter,
                        child: Stack(
                          children: <Widget>[
                            /* **** ALARM LABEL **** */
                            Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(left: 10, top: 5, bottom: 10),
                                  child: Icon(
                                    Icons.arrow_right,
                                    size: 45,
                                    color: Colors.white,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 5),
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
                            /* **** ON/OFF SWITCH **** */
                            Container(
                              alignment: Alignment.topRight,
                              child: Switch(
                                value: isSwitched,
                                onChanged: (value) {
                                  setState(() {
                                    isSwitched = value; //TODO: Make the on/off switch actually turn alarm on/off
                                    print(isSwitched);
                                  });
                                },
                                activeTrackColor: Colors.lightGreenAccent,
                                activeColor: Colors.green,
                              ),
                            ),
                            /* **** DAYS ALARM IS ACTIVE **** */
                            Container(
                              margin: EdgeInsets.only(top: 50, left: 24),
                              child: Text(
                                time.format(context),
                                style: TextStyle(
                                  fontFamily: 'Open Sans',
                                  fontSize: 40,
                                  color: const Color(0xffffffff),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.bottomLeft,
                              width: 325,
                              margin: EdgeInsets.only(left: 25),
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
                                  /* Container(
                                    padding: EdgeInsets.only(left: 100),
                                    child: Text(
                                      'Edit',
                                      style: TextStyle(
                                        fontFamily: 'Open Sans',
                                        fontSize: 15,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ), */
                                  IconButton(
                                    padding: EdgeInsets.only(right: 5),
                                    icon: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white,
                                      size: 15,
                                    ),
                                    onPressed: () {},
                                  )
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

// Function that will contain the dropdown for the expandable list
  Widget editAlarm(dayOfTheWeek) {
    var selected = false;

    return Container(
      child: ClipOval(
        child: Container(
          color: selected ? Colors.yellow : Colors.blue,
          height: 30,
          width: 30,
          child: GestureDetector(
            onTap: () {
              setState(
                () {
                  selected = true;
                  print('Tapped date circle');
                },
              );
            },
            child: Center(
              child: Text(
                dayOfTheWeek,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

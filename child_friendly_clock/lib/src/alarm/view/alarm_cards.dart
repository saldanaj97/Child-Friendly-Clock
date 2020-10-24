import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:child_friendly_clock/src/alarm/model/Alarm.dart';

class AlarmCards extends StatefulWidget {
  final Alarm alarm;
  AlarmCards(this.alarm);

  @override
  _AlarmCardsState createState() => _AlarmCardsState();
}

class _AlarmCardsState extends State<AlarmCards> {
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    var time;
    var height = 150.0;

/*     print(widget.alarm.name);
    print('Hour Value: ' + '${widget.alarm.hour}');
    print('Period: ' + widget.alarm.period); */
    if (widget.alarm.period == "PM" && widget.alarm.hour != 12)
      time = TimeOfDay(hour: widget.alarm.hour + 12, minute: widget.alarm.minute);
    else if (widget.alarm.period == "AM" && widget.alarm.hour == 12)
      time = TimeOfDay(hour: widget.alarm.hour - 12, minute: widget.alarm.minute);
    else
      time = TimeOfDay(hour: widget.alarm.hour, minute: widget.alarm.minute);

    return AnimatedContainer(
      duration: Duration(seconds: 1),
      alignment: Alignment.center,
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                color: Colors.black,
                width: 325,
                height: height,
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
                            margin: EdgeInsets.only(left: 9),
                            child: ExpansionTile(
                              initiallyExpanded: false,
                              title: Text(
                                'Mon - Fri',
                                style: TextStyle(
                                  fontFamily: 'Open Sans',
                                  fontSize: 25,
                                  color: const Color(0xffffffff),
                                  fontWeight: FontWeight.w300,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    /*editAlarm('M'),
                                    editAlarm('T'),
                                    editAlarm('W'),
                                    editAlarm('TR'),
                                    editAlarm('F'),
                                    editAlarm('Sa'),
                                    editAlarm('Su'),*/
                                    IconButton(
                                        icon: Icon(Icons.cancel),
                                        color: Colors.white,
                                        onPressed: () {
                                          // ADD THE DELETE ALARM FUNCTION HERE
                                          print('Delete Alarm Pressed');
                                        }),
                                  ],
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
            ],
          ),
        ],
      ),
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

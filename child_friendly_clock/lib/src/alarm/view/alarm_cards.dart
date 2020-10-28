import 'dart:ui';

import 'package:child_friendly_clock/src/alarm/utils/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:child_friendly_clock/src/alarm/model/Alarm.dart';
import 'package:numberpicker/numberpicker.dart';

class AlarmCards extends StatefulWidget {
  final Alarm alarm;
  final VoidCallback updateListCallback;
  AlarmCards({this.alarm, this.updateListCallback});

  @override
  _AlarmCardsState createState() => _AlarmCardsState();
}

enum FormType{
  main,
  edit,
}



class _AlarmCardsState extends State<AlarmCards> {
  bool isSwitched = false;
  List<bool> _selections = [false, false];
  Future alarmsFuture;
  FormType _form = FormType.main;
  TextEditingController _nameController;
  bool canSave = false;
  bool monday = false;
  bool tuesday = false;
  bool wednesday = false;
  bool thursday = false;
  bool friday = false;
  bool saturday = false;
  bool sunday = false;



  @override
  void initState(){
    super.initState();
    _nameController = TextEditingController(text: widget.alarm.name);
    if(widget.alarm.period == 'AM'){
      _selections = [true, false];
    }
    else{
      _selections = [false, true];
    }
  }

  @override
  void dispose(){
    _nameController.dispose();
    super.dispose();
  }

  getAlarms() async{
    final alarmsData = await DBProvider.db.getAlarms();
    return alarmsData;
  }

  void _formChange() async{
    setState(() {
      if(_form == FormType.main){
        _form = FormType.edit;
      }
      else{
        _form = FormType.main;
      }
    });
  }



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

    if (_form == FormType.main) {
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
                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text(widget.alarm.name + ' deleted')));
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
                                    margin: EdgeInsets.only(
                                        left: 10, top: 5, bottom: 10),
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
                                      isSwitched =
                                          value; //TODO: Make the on/off switch actually turn alarm on/off
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
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceEvenly,
                                  children: [
                                    Text(
                                      'Mon - Fri',
                                      style: TextStyle(
                                        fontFamily: 'Open Sans',
                                        fontSize: 25,
                                        color: const Color(0xffffffff),
                                        fontWeight: FontWeight.w300,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 100),
                                      child: Text(
                                        'Edit',
                                        style: TextStyle(
                                          fontFamily: 'Open Sans',
                                          fontSize: 20,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      padding: EdgeInsets.only(),
                                      icon: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        _formChange();
                                      },
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
    else if(_form == FormType.edit){
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
                  Scaffold.of(context).showSnackBar(
                      SnackBar(content: Text(widget.alarm.name + ' deleted')));
                },
                background: Container(
                  color: Colors.red,
                ),
                child: Container(
                  width: 325,
                  height: height*(1.2),
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
                                    margin: EdgeInsets.only(
                                        left: 10, top: 5, bottom: 10),
                                    child: Icon(
                                      Icons.arrow_right,
                                      size: 45,
                                      color: Colors.white,
                                    ),
                                  ),
                                  // Container for editing the name of the alarm
                                  Container(
                                    width: 250,
                                    margin: EdgeInsets.only(bottom: 5),
                                    child: TextField(
                                      autofocus: false,
                                      decoration: InputDecoration(border: InputBorder.none, hintText: "Enter a Name", hintStyle: TextStyle(color: Colors.grey[500])),
                                      autocorrect: true,
                                      textAlign: TextAlign.left,
                                      keyboardType: TextInputType.text,
                                      maxLines: 1,
                                      controller: _nameController,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 23.0,
                                        letterSpacing: 2.0,
                                      ),
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
                                      isSwitched =
                                          value; //TODO: Make the on/off switch actually turn alarm on/off
                                      print(isSwitched);
                                    });
                                  },
                                  activeTrackColor: Colors.lightGreenAccent,
                                  activeColor: Colors.green,
                                ),
                              ),


                              //container for editing the time and am/pm
                              Container(
                                margin: EdgeInsets.only(top: 20, left: 5),
                                child: Row(
                                  children: <Widget>[
                                    SizedBox(width: 20),
                                    NumberPicker.integer(
                                        initialValue: widget.alarm.hour,
                                        minValue: 1,
                                        maxValue: 12,
                                        onChanged: (newValue) => setState(() => widget.alarm.hour = newValue)),
                                    Text(':',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 23.0,
                                        )),
                                    NumberPicker.integer(
                                      initialValue: widget.alarm.minute,
                                      minValue: 0,
                                      maxValue: 59,
                                      zeroPad: true,
                                      listViewWidth: 60.0,
                                      onChanged: (newValue) => setState(() => widget.alarm.minute = newValue)),
                                    ToggleButtons(
                                      children: [Text('AM'), Text('PM')],
                                      isSelected: _selections,
                                      onPressed: (int index) {
                                        setState(() {
                                          for(int btnIndex = 0; btnIndex < _selections.length; btnIndex++){
                                            if(btnIndex == index) {
                                              _selections[btnIndex] = true;
                                              if (btnIndex == 0) {
                                                widget.alarm.period = "AM";
                                              }
                                              else {
                                                widget.alarm.period = "PM";
                                              }
                                            }
                                            else{
                                                _selections[btnIndex] = false;
                                            }
                                          }
                                        });
                                      },
                                    ),
                                  ],
                                ),

                              ),
                              // container for editing the frequency
                              Container(
                                alignment: Alignment.bottomLeft,
                                width: 325,
                                //margin: EdgeInsets.only(left: 5),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RaisedButton(
                                        textColor: sunday ? Colors.black : Colors.white,
                                        shape: CircleBorder(),
                                      child: Text("Sun",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                        )),
                                      color: sunday ? Colors.white : Colors.blue,
                                      onPressed: () => setState(() => sunday = !sunday),
                                    ),
                                    RaisedButton(
                                      textColor: monday ? Colors.black : Colors.white,
                                      shape: CircleBorder(),
                                      child: Text("Mon",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                          )),
                                      color: monday ? Colors.white : Colors.blue,
                                      onPressed: () => setState(() => monday = !monday),
                                    ),
                                    RaisedButton(
                                      textColor: tuesday ? Colors.black : Colors.white,
                                      shape: CircleBorder(),
                                      child: Text("Tues",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                          )),
                                      color: tuesday ? Colors.white : Colors.blue,
                                      onPressed: () => setState(() => tuesday = !tuesday),
                                    ),
                                    RaisedButton(
                                      textColor: wednesday ? Colors.black : Colors.white,
                                      shape: CircleBorder(),
                                      child: Text("Wed",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                          )),
                                      color: wednesday ? Colors.white : Colors.blue,
                                      onPressed: () => setState(() => wednesday = !wednesday),
                                    ),
                                    RaisedButton(
                                      textColor: thursday ? Colors.black : Colors.white,
                                      shape: CircleBorder(),
                                      child: Text("Thurs",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                          )),
                                      color: thursday ? Colors.white : Colors.blue,
                                      onPressed: () => setState(() => thursday = !thursday),
                                    ),
                                    RaisedButton(
                                      textColor: friday ? Colors.black : Colors.white,
                                      shape: CircleBorder(),
                                      child: Text("Fri",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                          )),
                                      color: friday ? Colors.white : Colors.blue,
                                      onPressed: () => setState(() => friday = !friday),
                                    ),
                                    RaisedButton(
                                      textColor: saturday ? Colors.black : Colors.white,
                                      shape: CircleBorder(),
                                      child: Text("Sat",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0,
                                          )),
                                      color: saturday ? Colors.white : Colors.blue,
                                      onPressed: () => setState(() => saturday = !saturday),
                                    ),
                                    RaisedButton(
                                      textColor: Colors.white,
                                      shape: CircleBorder(),
                                      child: Text("Save",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0
                                          )),
                                      color: Colors.red,
                                      onPressed: () {
                                        _formChange();
                                        //todo: here we should connect to the database to update the alarm
                                      },
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
  }

// Function that will contain the dropdown for the expandable list
  Widget editAlarm() {
    var selected = false;
    print("edditing");
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
                "dayOfTheWeek",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

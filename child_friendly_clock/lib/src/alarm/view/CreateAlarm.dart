import 'package:child_friendly_clock/src/alarm/view/alarm.dart';
import 'package:child_friendly_clock/src/widgets/view/navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:flushbar/flushbar.dart';
import 'package:child_friendly_clock/src/alarm/model/Alarm.dart';
import 'package:child_friendly_clock/src/alarm/utils/database.dart';
import 'package:child_friendly_clock/src/alarm/view/save_button.dart';
import 'package:child_friendly_clock/src/alarm/view/frequency_button.dart';

class CreateAlarm extends StatefulWidget {
  final VoidCallback clickCallback;
  CreateAlarm({this.clickCallback});

  @override
  _CreateAlarmState createState() => _CreateAlarmState();
}

class _CreateAlarmState extends State<CreateAlarm> {
  TextEditingController _nameController;
  var newAlarm = Alarm(hour: 8, minute: 0, second: 0, period: "AM", name: "None", note: "No note set. ", enabled: 0);
  double proxyMinute = 0.0;
  List<bool> _selections = [true, false];
  List<int> _frequency = [0, 0, 0, 0, 0, 0, 0]; // for every day of the week starting with sunday
  bool canSave = false;
  String alarmNote;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 45, 45, 70),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pushReplacement(context, SizeRoute(page: alarm())),
        ),
        title: Text('Add Alarm'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 55, 55, 70),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 25, right: 25, bottom: 15),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Name:',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.bold,
                        fontSize: 28.0,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(border: InputBorder.none, hintText: "Enter name", hintStyle: TextStyle(color: Colors.grey[500])),
                        autofocus: false,
                        keyboardType: TextInputType.text,
                        controller: _nameController,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.0,
                          letterSpacing: 2.0,
                        ),
                        onChanged: (text) {
                          setState(() {
                            if (text == '') {
                              canSave = false;
                            } else {
                              canSave = true;
                            }
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 25, right: 25, bottom: 15),
                child: Row(
                  children: <Widget>[
                    Text('Time:',
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.bold,
                          fontSize: 28.0,
                        )),
                    SizedBox(width: 20.0),
                    NumberPicker.integer(
                        initialValue: newAlarm.hour,
                        minValue: 1,
                        maxValue: 12,
                        listViewWidth: 35.0,
                        onChanged: (newValue) => setState(() => newAlarm.hour = newValue)),
                    Text(':',
                        style: TextStyle(
                          color: Colors.lightBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        )),
                    NumberPicker.integer(
                        initialValue: newAlarm.minute,
                        minValue: 0,
                        maxValue: 59,
                        zeroPad: true,
                        listViewWidth: 60.0,
                        onChanged: (newValue) => setState(() => newAlarm.minute = newValue)),
                    ToggleButtons(
                        children: [Text('AM'), Text('PM')],
                        isSelected: _selections,
                        onPressed: (int index) {
                          setState(() {
                            for (int btnIndex = 0; btnIndex < _selections.length; btnIndex++) {
                              if (btnIndex == index) {
                                _selections[btnIndex] = true;
                                if (btnIndex == 0)
                                  newAlarm.period = "AM";
                                else
                                  newAlarm.period = "PM";
                              } else {
                                _selections[btnIndex] = false;
                              }
                            }
                          });
                        })
                  ],
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  Expanded(child:
                  FrequencyButton(day: 'Sun', active: _frequency[0] == 1, toggle: () => setState(() {
                  if(_frequency[0] == 1)
                  _frequency[0] = 0;
                  else
                  _frequency[0] = 1;
                  }))),
                  Expanded(child:
                  FrequencyButton(day: 'Mon', active: _frequency[1] == 1, toggle: () => setState(() {
                  if(_frequency[1] == 1)
                  _frequency[1] = 0;
                  else
                  _frequency[1] = 1;
                  }))),
                  Expanded(child:
                  FrequencyButton(day: 'Tues', active: _frequency[2] == 1, toggle: () => setState(() {
                  if(_frequency[2] == 1)
                  _frequency[2] = 0;
                  else
                  _frequency[2] = 1;
                  }))),
                  Expanded(child:
                  FrequencyButton(day: 'Wed', active: _frequency[3] == 1, toggle: () => setState(() {
                  if(_frequency[3] == 1)
                  _frequency[3] = 0;
                  else
                  _frequency[3] = 1;
                  }))),
                  Expanded(child:
                  FrequencyButton(day: 'Thurs', active: _frequency[4] == 1, toggle: () => setState(() {
                  if(_frequency[4] == 1)
                  _frequency[4] = 0;
                  else
                  _frequency[4] = 1;
                  }))),
                  Expanded(child:
                  FrequencyButton(day: 'Fri', active: _frequency[5] == 1, toggle: () => setState(() {
                  if(_frequency[5] == 1)
                  _frequency[5] = 0;
                  else
                  _frequency[5] = 1;
                  }))),
                  Expanded(child:
                  FrequencyButton(day: 'Sat', active: _frequency[6] == 1, toggle: () => setState(() {
                  if(_frequency[6] == 1)
                  _frequency[6] = 0;
                  else
                  _frequency[6] = 1;
                  })))
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 15, bottom: 15),
                child: Column(
                  children: [
                    Text(
                      'Note ',
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.bold,
                        fontSize: 28.0,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: TextField(
                        maxLines: 5,
                        maxLength: 144,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Leave a note(optional)",
                          hintStyle: TextStyle(color: Colors.grey[500], fontSize: 20),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: BorderSide(
                              color: Colors.white,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                        autofocus: false,
                        keyboardType: TextInputType.multiline,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          letterSpacing: 2.0,
                        ),
                        onChanged: (text) {
                          setState(() {
                            newAlarm.note = text;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FlatButton(
                      height: 40,
                      minWidth: 135,
                      textColor: Colors.lightBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Text('Cancel',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          )),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pushReplacement(context, SizeRoute(page: alarm()));
                      },
                    ),
                    SaveButton(
                      active: canSave,
                      save: () {
                        newAlarm.frequency = _frequency;
                        newAlarm.name = _nameController.text;
                        DBProvider.db.newAlarm(newAlarm);
                        widget.clickCallback();
                        Navigator.pop(context);
                        //Navigator.pushReplacement(context, SizeRoute(page: alarm()));
                        var notificationMessage = newAlarm.name + ' has now been added. ';
                        Flushbar(
                          message: notificationMessage,
                          duration: Duration(seconds: 3),
                          margin: EdgeInsets.all(8),
                          borderRadius: 8,
                        )..show(context);
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

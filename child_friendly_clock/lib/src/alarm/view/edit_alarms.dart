import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:flushbar/flushbar.dart';
import 'package:child_friendly_clock/src/alarm/model/Alarm.dart';
import 'package:child_friendly_clock/src/alarm/view/save_button.dart';
import 'package:child_friendly_clock/src/alarm/view/frequency_button.dart';
import 'package:child_friendly_clock/src/alarm/utils/database.dart';

class EditAlarm extends StatefulWidget {
  final Alarm editAlarm;
  final VoidCallback clickCallback;
  EditAlarm({this.clickCallback, this.editAlarm});

  @override
  _EditAlarmState createState() => _EditAlarmState();
}

class _EditAlarmState extends State<EditAlarm> {
  TextEditingController _alarmNameController = new TextEditingController();
  bool canSave = true;
  List<bool> _selections = [false, false];
  List<bool> _frequency = [false, false, false, false, false, false, false];
  String alarmNote = '';

  @override
  void initState() {
    super.initState();
    _alarmNameController.text = widget.editAlarm.name;
    if (widget.editAlarm.period == "AM") {
      _selections[0] = true;
    } else {
      _selections[1] = true;
    }
    _frequency = widget.editAlarm.frequency;
  }

// Function that will contain the dropdown for the expandable list
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 45, 45, 70),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Edit Alarm'),
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
                    Text('Name: ',
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.bold,
                          fontSize: 28.0,
                        )),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(border: InputBorder.none, hintText: "Enter name", hintStyle: TextStyle(color: Colors.grey[500])),
                        autofocus: false,
                        keyboardType: TextInputType.text,
                        controller: _alarmNameController,
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
                        initialValue: widget.editAlarm.hour,
                        minValue: 1,
                        maxValue: 12,
                        listViewWidth: 35.0,
                        onChanged: (newValue) => setState(() => widget.editAlarm.hour = newValue)),
                    Text(':', style: TextStyle(color: Colors.lightBlue, fontWeight: FontWeight.bold, fontSize: 20.0)),
                    NumberPicker.integer(
                        initialValue: widget.editAlarm.minute,
                        minValue: 0,
                        zeroPad: true,
                        maxValue: 59,
                        listViewWidth: 60.0,
                        onChanged: (newValue) => setState(() => widget.editAlarm.minute = newValue)),
                    ToggleButtons(
                      children: [Text('AM'), Text('PM')],
                      isSelected: _selections,
                      onPressed: (int index) {
                        setState(() {
                          for (int btnIndex = 0; btnIndex < _selections.length; btnIndex++) {
                            if (btnIndex == index) {
                              _selections[btnIndex] = true;
                              if (btnIndex == 0) {
                                widget.editAlarm.period = "AM";
                              } else {
                                widget.editAlarm.period = "PM";
                              }
                            } else {
                              _selections[btnIndex] = false;
                            }
                          }
                        });
                      },
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FrequencyButton(
                      day: 'Sun',
                      active: _frequency[0],
                      toggle: () => setState(() {
                            _frequency[0] = !_frequency[0];
                          })),
                  FrequencyButton(
                      day: 'Mon',
                      active: _frequency[1],
                      toggle: () => setState(() {
                            _frequency[1] = !_frequency[1];
                          })),
                  FrequencyButton(
                      day: 'Tues',
                      active: _frequency[2],
                      toggle: () => setState(() {
                            _frequency[2] = !_frequency[2];
                          })),
                  FrequencyButton(
                      day: 'Wed',
                      active: _frequency[3],
                      toggle: () => setState(() {
                            _frequency[3] = !_frequency[3];
                          })),
                  FrequencyButton(
                      day: 'Thurs',
                      active: _frequency[4],
                      toggle: () => setState(() {
                            _frequency[4] = !_frequency[4];
                          })),
                  FrequencyButton(
                      day: 'Fri',
                      active: _frequency[5],
                      toggle: () => setState(() {
                            _frequency[5] = !_frequency[5];
                          })),
                  FrequencyButton(
                      day: 'Sat',
                      active: _frequency[6],
                      toggle: () => setState(() {
                            _frequency[6] = !_frequency[6];
                          }))
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 15, bottom: 15),
                child: Column(
                  children: [
                    Text(
                      'Note ',
                      style: TextStyle(color: Colors.white, letterSpacing: 2.0, fontWeight: FontWeight.bold, fontSize: 28.0),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: TextField(
                        maxLines: 5,
                        maxLength: 144,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: widget.editAlarm.note,
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
                        style: TextStyle(color: Colors.black, fontSize: 18.0, letterSpacing: 2.0),
                        onChanged: (text) {
                          setState(() {
                            widget.editAlarm.note = text;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 15),
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
                      child: Text('Cancel', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                      color: Colors.white,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    SaveButton(
                      active: canSave,
                      save: () {
                        widget.editAlarm.frequency = _frequency;
                        widget.editAlarm.name = _alarmNameController.text;
                        widget.clickCallback();
                        DBProvider.db.updateAlarm(widget.editAlarm, widget.editAlarm.name, widget.editAlarm.hour, widget.editAlarm.minute,
                            widget.editAlarm.frequency, widget.editAlarm.note);
                        Navigator.of(context).pop();
                        var notificationMessage = widget.editAlarm.name + ' has now been updated. ';
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
